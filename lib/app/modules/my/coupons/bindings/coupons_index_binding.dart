import 'package:get/get.dart';

import '../controllers/coupons_index_controller.dart';

class CouponsIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponsIndexController>(
      () => CouponsIndexController(),
    );
  }
}
