import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/models/price_type.dart';

import '../../../../models/contract/res/user_config_info.dart';

class OperateState {
  /// 可开
  final RxnNum canOpenAmount = RxnNum(null);

  /// 可平多
  final RxnNum canCloseMoreAmount = RxnNum(null);

  /// 可平空
  final RxnNum canCloseEmptyAmount = RxnNum(null);

  /// 保证金
  final RxnNum margin = RxnNum(null);

  /// 当前合约用户配置信息
  Rxn<UserConfigInfo> userConfig = Rxn<UserConfigInfo>();

  RxDouble amountPercent = 0.0.obs;

  /// 可用余额
  RxNum availableBalance = RxNum(0);

  /// 止盈价格类型
  var stopWinPriceType = StopWinLosePriceType.lastPrice.obs;

  /// 止损价格类型
  var stopLossPriceType = StopWinLosePriceType.lastPrice.obs;

  void reset() {
    canOpenAmount.value = null;
    canCloseMoreAmount.value = null;
    canCloseEmptyAmount.value = null;
    margin.value = null;
  }
}
