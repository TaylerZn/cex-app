import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/advert_form_fill.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/payment_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/data/customer_data.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SalesComissionController extends GetxController {
  //TODO: Implement SalesComissionController
  final count = 0.obs;
  late int type;
  num tradeMaxValue = 500000;
  AdvertFormFill formFill = AdvertFormFill();
  RefreshController refreshVC = RefreshController();

  @override
  void onInit() {
    super.onInit();
    type = Get.arguments['type'];
  }

  bool get isPurchaseMode => type == 0;
  List<PaymentInfo?>? paymentList = [];

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  Future<void> loadData({bool isOnrRady = true}) async {
    if (isOnrRady) EasyLoading.show();
    paymentList = await OtcApi.instance().paymentList();
    if (ObjectUtil.isNotEmpty(paymentList) && ObjectUtil.isEmpty(formFill.payments)) {
      formFill.payments = [paymentList?.first?.id];
    }

    var res = await AFCustomer.advertMaxVolme(source: type == 0 ? 'BUY' : 'SELL');
    tradeMaxValue = res['volume'];
    EasyLoading.dismiss();
    update();
  }

  @override
  void onClose() {
    OtcConfigUtils().addPurchase = false;
    super.onClose();
  }

  Future<void> startPublish() async {
    formFill.transUserLimit = formFill.transUserLimit?.map((e) => e + 1).toList();
    formFill.paycoin = OtcConfigUtils().payCoin.value;
    formFill.chatAuto = formFill.chatAuto ?? 0;
    Map<String, dynamic> params = formFill.toJson();
    bool isEmpty = false;
    params.keys.toList().forEach((element) {
      if (element == 'transUserLimit' || element == 'payments' || element == 'chatAutoReply' || element == 'transDescription') {
        return;
      }
      if (ObjectUtil.isEmpty(params[element])) {
        isEmpty = true;
      }
    });

    if (isEmpty) {
      UIUtil.showError(LocaleKeys.c2c64.tr);
      return;
    }

    if (ObjectUtil.isEmpty(params['payments'])) {
      UIUtil.showError(LocaleKeys.c2c37.tr);
      return;
    }

    params['side'] = isPurchaseMode ? 'BUY' : 'SELL';
    params['coin'] = 'USDT';

    num minPrice = 10 * num.parse(formFill.price ?? '0'); // formFill.volume ;//OtcConfigUtils().getMinPrice(isPurchaseMode);
    num maxPrice = num.parse(formFill.volume ?? '0') *
        num.parse(formFill.price ?? '0'); //  OtcConfigUtils().getMaxPrice(isPurchaseMode, formFill.price,formFill.volume);

    num maxValue = num.parse(formFill.maxTrade ?? '0');
    num minValue = num.parse(formFill.minTrade ?? '0');

    if (Decimal.parse(formFill.volume ?? '0') > Decimal.parse('$tradeMaxValue') ||
        Decimal.parse(formFill.volume ?? '0') < Decimal.parse('${OtcConfigUtils().minValue}')) {
      UIUtil.showError('${LocaleKeys.c2c60.tr}${OtcConfigUtils().minValue}-$tradeMaxValue');
      return;
    }

    if (minValue < minPrice || minValue > maxPrice || maxValue > maxPrice || maxValue < minPrice) {
      UIUtil.showError('${LocaleKeys.c2c59.tr}$minPrice-$maxPrice');
      return;
    }

    if (minValue > maxValue) {
      UIUtil.showError(LocaleKeys.c2c167.tr);
      return;
    }

    if (maxValue < minValue) {
      UIUtil.showError(LocaleKeys.c2c166.tr);
      return;
    }

    if (ObjectUtil.isEmpty(params['payments'])) {
      UIUtil.showError(LocaleKeys.c2c142.tr);
      return;
    }

    try {
      EasyLoading.show();
      dynamic response = await OtcApi.instance().advertAdd(
          side: params['side'],
          coin: params['coin'],
          volume: params['volume'],
          price: params['price'],
          minTrade: params['minTrade'],
          maxTrade: params['maxTrade'],
          paycoin: params['paycoin'],
          payments: params['payments'],
          transUserLimit: params['transUserLimit'],
          transDescription: params['transDescription'],
          chatAuto: params['chatAuto'],
          chatAutoReply: params['chatAutoReply']);
      EasyLoading.dismiss();
      if (response == null) {
        UIUtil.showSuccess(LocaleKeys.c2c134.tr);
        Get.back();
      }
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
  }

  String get actiontitle => type == 0 ? LocaleKeys.c2c26.tr : LocaleKeys.c2c27.tr;
}
