
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:k_chart/entity/depth_entity.dart';

import '../../../models/contract/res/funding_rate.dart';
import '../contract/controllers/contract_depth_controller.dart';

enum BuyAskType {
  buy,
  ask,
  all,
}

Map<BuyAskType, String> buyAskTypeMap = {
  BuyAskType.buy: 'assets/images/contract/buy_only.svg',
  BuyAskType.ask: 'assets/images/contract/sell_only.svg',
  BuyAskType.all: 'assets/images/contract/buy_sell.svg',
};

mixin DepthController {
  BuyAskType buyAskType = BuyAskType.all;
  /// 精度
  num precision = 0.1;
  /// 精度列表
  List<num> precisionList = [0.01, 0.1,1];
  /// 卖盘
  List<DepthEntity> asks = [];
  /// 买盘
  List<DepthEntity> buys = [];
  Rxn<FundingRate> fundingRate = Rxn();
  /// 买盘最大深度
  num buyMaxVol = 1;
  /// 买盘最大价格
  num buyMaxPrice = 1;
  /// 卖盘最大深度
  num askMaxVol = 1;
  /// 卖盘最大价格
  num askMaxPrice = 1;

  num get firstPrecision => precisionList.first;

}