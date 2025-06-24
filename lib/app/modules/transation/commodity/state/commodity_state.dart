import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../models/commodity/res/commodity_open_status.dart';
import '../../../../models/contract/res/funding_rate.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../models/contract/res/user_config_info.dart';
import '../../../../widgets/components/transaction/transaction_switch_button.dart';
import '../../contract/models/price_type.dart';

class CommodityState {
  final Rxn<FundingRate> fundingRate = Rxn<FundingRate>();
  final switchState = TransactionSwitchButtonValue.left.obs;
  final commondityBalance = '-- USDT'.obs;
  final RxBool isMarketOrder = true.obs; //是否为市价单
  final amountUnits = ['BTC', 'USDT'].obs;
  final amountUnitIndex = 0.obs;
  final percent = 0.0.obs;

  /// 是否是止盈止损
  final isStopLoss = false.obs;

  /// 止盈价格类型
  var stopWinPriceType = StopWinLosePriceType.lastPrice.obs;

  /// 止损价格类型
  var stopLossPriceType = StopWinLosePriceType.lastPrice.obs;

  final Rx<String> canOpenAmount = '--'.obs;
  final Rx<String> canCloseMoreAmount = '--'.obs;
  final Rx<String> canCloseEmptyAmount = '--'.obs;
  final RxnNum margin = RxnNum();

  /// 可用余额
  final RxNum availableBalance = RxNum(0);

  /// 开市时间
  Rxn<CommodityOpenStatus> openStatus = Rxn<CommodityOpenStatus>();

  Rxn<ContractInfo> contractInfo = Rxn<ContractInfo>();

  /// 当前合约用户配置信息
  Rxn<UserConfigInfo> userConfig = Rxn<UserConfigInfo>();

  /// 用于退出登陆重置状态
  reset() {
    commondityBalance.value = '-- USDT';
    canOpenAmount.value = '--';
    canCloseMoreAmount.value = '--';
    canCloseEmptyAmount.value = '--';
    margin.value = null;
    availableBalance.value = 0;
  }
}
