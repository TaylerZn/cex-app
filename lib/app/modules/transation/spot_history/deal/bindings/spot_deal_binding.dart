import 'package:get/get.dart';

import '../controllers/spot_deal_controller.dart';

class SpotDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpotDealController>(
      () => SpotDealController(),
    );
  }
}
