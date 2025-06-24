import 'package:get/get.dart';

import '../controllers/spot_price_controller.dart';

class PriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpotPriceController>(
      () => SpotPriceController(),
    );
  }
}
