import 'package:get/get.dart';

import '../controllers/commodity_detail_controller.dart';

class CommodityDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommodityDetailController>(
      () => CommodityDetailController(),
    );
  }
}
