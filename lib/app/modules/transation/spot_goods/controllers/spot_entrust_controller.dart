import 'dart:async';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../api/spot_goods/spot_goods_api.dart';
import '../../../../getX/user_Getx.dart';
import '../../../../models/spot_goods/spot_order_res.dart';
import '../../../../utils/utilities/ui_util.dart';

class SpotEntrustController extends GetxController {
  static SpotEntrustController get to => Get.find<SpotEntrustController>();

  RxList<SpotOrderInfo> dataList = RxList();
  final isHideOther = false.obs;
  Timer? timer;
  MarketInfoModel? marketInfoModel;

  @override
  void onInit() {
    super.onInit();
    Bus.getInstance().on(EventType.login, (data) {
      fetchData();
    });
  }

  void onHideOther() {
    isHideOther.toggle();
    fetchData();
  }

  Future<void> onOneKeyClose() async {
    try {
      await SpotGoodsApi.instance().cancelAllOrder();
      UIUtil.showToast(LocaleKeys.trade62.tr);
    } catch (e) {
      UIUtil.showToast(LocaleKeys.trade63.tr);
    }
  }

  changeMarketInfo(MarketInfoModel marketInfoModel) {
    this.marketInfoModel = marketInfoModel;
    fetchData();
  }

  @override
  void onClose() {
    timer?.cancel();
    timer = null;
    super.onClose();
  }

  fetchData() async {
    if (!UserGetx.to.isLogin) return;
    timer?.cancel();
    _fetchEntrust();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!UserGetx.to.isLogin) {
        timer.cancel();
        return;
      }
      _fetchEntrust();
    });
  }

  _fetchEntrust() async {
    try {
      /// 隐藏其他合约只显示传contractId
      String? symbol = isHideOther.value ? marketInfoModel?.symbol : null;
      final res = await SpotGoodsApi.instance().orderListNew(
        null,
        null,
        1,
        100,
        symbol,
      );
      dataList.clear();
      dataList.assignAll(res.orderList ?? []);
    } catch (e) {
      Get.log('error when _fetchEntrust: $e');
    }
  }
}
