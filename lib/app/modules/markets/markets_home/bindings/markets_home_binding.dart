import 'package:get/get.dart';

import '../controllers/markets_home_controller.dart';

class MarketsHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketsHomeController>(
      () => MarketsHomeController(),
    );
  }
}
