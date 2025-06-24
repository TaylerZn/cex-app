import 'package:get/get.dart';

import '../controllers/commodity_price_controller.dart';

class CommodityPriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommodityPriceController>(
      () => CommodityPriceController(),
    );
  }
}
