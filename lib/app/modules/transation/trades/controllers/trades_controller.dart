import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';

import '../../../../../generated/locales.g.dart';
import '../../immediate_exchange/main/controllers/immediate_exchange_controller.dart';

enum TradeIndexType {
  // 跟单
  follow(0, LocaleKeys.trade1),
  // 标准合约
  standard(1, LocaleKeys.trade4),
  // 永续合约
  contract(2, LocaleKeys.trade5),
  // 闪兑
  immediate(3, LocaleKeys.trade289);

  final int value;
  final String title;
  const TradeIndexType(this.value, this.title);
}

class TradesController extends GetxController {
  static TradesController get to => Get.find();

  Rx<TradeIndexType> tradeIndextype = TradeIndexType.standard.obs;

  /// 0 标准合约 1 永续合约 2 跟单
  void onTabChange(TradeIndexType type) {
    if (type == TradeIndexType.follow) {
      RouteUtil.goTo('/follow-orders');
      return;
    }
    tradeIndextype.value = type;
    if (type == TradeIndexType.immediate) {
      if (Get.isRegistered<ImmediateExchangeController>()) {
        Get.find<ImmediateExchangeController>().formFocusNode.requestFocus();
      }
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
