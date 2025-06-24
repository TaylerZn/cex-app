import 'package:get/get.dart';

import '../controllers/spot_detail_controller.dart';
import '../../price/controllers/spot_price_controller.dart';

class SpotDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpotDetailController>(
      () => SpotDetailController(),
    );
    Get.lazyPut<SpotPriceController>(
      () => SpotPriceController(),
    );
  }
}
