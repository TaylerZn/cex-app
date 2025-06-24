import 'package:get/get.dart';

import '../controllers/commodity_open_order_controller.dart';

class CommodityOpenOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommodityOpenOrderController>(
      () => CommodityOpenOrderController(),
    );
  }
}
