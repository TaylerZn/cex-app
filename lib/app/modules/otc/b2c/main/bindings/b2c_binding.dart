import 'package:get/get.dart';

import '../controllers/b2c_controller.dart';

class B2cBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<B2cController>(
      () => B2cController(),
    );
  }
}
