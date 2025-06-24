import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/advert_exchange_rate.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_public_info.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_user_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

import '../../../../models/otc/c2c/otc_record.dart';

class OtcConfigUtils {
  CustomerCoinListModel? coinModel;
  int minValue = 10;
  int maxValue = 500000;
  static OtcConfigUtils? _getInstance;
  OtcPublicInfo? publicInfo;
  CountryNumberInfo? selectedInfo;
  CountryNumberInfo? currentInfo;
  AdvertExchangeRate? exchangeRate;

  RxString payCoin = "USD".obs;
  RxString payTitle = "USD".obs;
  bool isHome = true;
  bool get haveC2C => OtcConfigUtils().publicInfo == null ? false : OtcConfigUtils().publicInfo!.haveC2C;
  var showApplyTip = true;

  factory OtcConfigUtils() => _getInstance ??= OtcConfigUtils._();
  OtcConfigUtils._();

  CountryNumberInfo? get defaultCoin => publicInfo?.paycoins?.firstWhereOrNull((element) => element.key == payCoin.value);
  bool addPurchase = false; //是否发布委托中

  int get decimalPoint {
    if (ObjectUtil.isNotEmpty(defaultCoin)) {
      return defaultCoin?.scaleLength ?? 0;
    }
    return 0;
  }

  Decimal getMinPrice(bool isPurchase) {
    return Decimal.fromInt(10); //isPurchase ?: Decimal.fromInt(100);
  }

  // Decimal getMinPrice(bool isPurchase) {
  //   return  Decimal.fromInt(10);//isPurchase ?: Decimal.fromInt(100);
  // }

  Decimal getMaxPrice(bool isPurchase, String? unitPrice, String? amount) {
    //unitPrice : 单价 , amount : 数量
    Decimal maxPrice = Decimal.parse(
        isPurchase ? OtcConfigUtils().exchangeRate?.buyValue ?? '0' : OtcConfigUtils().exchangeRate?.sellValue ?? '0');
    Decimal uPrice = Decimal.parse(unitPrice ?? '0');
    Decimal unit = Decimal.parse(amount ?? '0');
    return uPrice * unit;
  }

  static Future goChatPage(Record? record, {bool complain = false, String? complainId}) async {
    if (complain) {
      await Get.toNamed(Routes.C2C_APPEAL, arguments: complainId);
      return;
    }
    await Get.toNamed(Routes.C2C_CHAT, arguments: '${record?.id}');
  }

  /// status 订单状态 order订单id
  static Future goOrderDetail({required int status, required num orderId, bool isBuy = true}) async {
    CustomerOrderModel? model;

    try {
      EasyLoading.show();
      CustomerOrderDetailModel detailModel = await AFCustomer.getOrderhWithId(id: orderId);
      status = detailModel.status ?? 0;
      model = CustomerOrderModel();
      detailModel.idNum = orderId;
      model.detailModel = detailModel;
      EasyLoading.dismiss();
    } on dio.DioException catch (e) {
      model = null;
      EasyLoading.showError('${e.error}');
    }

    ///  待支付1 已支付2 交易成功3 取消4 申诉5 打币中6 异常订单7 申诉处理完成8 申诉取消9
    if (status == 1) {
      await Get.toNamed(Routes.CUSTOMER_DEAL_ORDER, arguments: {'id': orderId, 'model': model});
    } else if (status == 2) {
      if (isBuy) {
        await Get.toNamed(Routes.CUSTOMER_ORDER_WAIT, arguments: {'id': orderId, 'model': model});
      } else {
        await Get.toNamed(Routes.CUSTOMER_DEAL_ORDER, arguments: {'id': orderId, 'model': model});
      }
    } else {
      await Get.toNamed(Routes.CUSTOMER_ORDER_WAIT, arguments: {'id': orderId, 'model': model});
    }

    // else if (status == 3) {
    //   await Get.toNamed(Routes.CUSTOMER_ORDER_WAIT,
    //       arguments: {'id': orderId, 'model': model});
    // } else if (status == 4) {
    //   await Get.toNamed(Routes.CUSTOMER_ORDER_CANCEL,
    //       arguments: {'id': orderId, 'model': model});
    // } else if (status == 5) {
    //   // await Get.toNamed(Routes.CUSTOMER_ORDER_APPEAL, arguments: {'id': orderId, 'model': model});
    //   await Get.toNamed(Routes.CUSTOMER_ORDER_WAIT,
    //       arguments: {'id': orderId, 'model': model});
    // }
    // else if (status == 6) {
    //   await Get.toNamed(Routes.CUSTOMER_ORDER_WAIT, arguments: {'id': orderId, 'model': model});
    // }
    // else if (status == 7) {
    //   return '异常订单';
    // } else if (status == 8) {
    //   await Get.toNamed(Routes.CUSTOMER_ORDER_WAIT, arguments: {'id': orderId, 'model': model});
    // } else if (status == 9) {
    //   await Get.toNamed(Routes.CUSTOMER_ORDER_WAIT, arguments: {'id': orderId, 'model': model});
    // }else {
    //   await Get.toNamed(Routes.CUSTOMER_ORDER_WAIT, arguments: {'id': orderId, 'model': model});
    // }
  }

  static getPublicInfo() {
    OtcApi.instance().public_info().then((value) {
      OtcConfigUtils().publicInfo = value;

      if (!OtcConfigUtils().haveC2C) {
        Bus.getInstance().emit(EventType.quicEntry, 'other35');
      }
    });
  }

  List<ApplyMerchantModel> get applyMerchantListModel =>
      OtcConfigUtils().publicInfo?.applyMerchantTypeConfig == null ? [] : OtcConfigUtils().publicInfo!.applyMerchantTypeConfig!;

  List<String> get applyMerchantList => applyMerchantListModel.map((e) => e.getMerchantType(e.merchantType)).toList();
}
