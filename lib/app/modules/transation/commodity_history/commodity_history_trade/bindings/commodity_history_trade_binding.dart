import 'package:get/get.dart';

import '../controllers/commodity_history_trade_controller.dart';

class CommodityHistoryTradeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommodityHistoryTradeController>(
      () => CommodityHistoryTradeController(),
    );
  }
}
