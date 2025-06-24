import 'package:get/get.dart';

import '../controllers/commodity_history_order_controller.dart';

class CommodityHistoryOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommodityHistoryOrderController>(
      () => CommodityHistoryOrderController(),
    );
  }
}
