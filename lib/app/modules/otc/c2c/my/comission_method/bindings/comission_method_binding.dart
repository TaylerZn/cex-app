import 'package:get/get.dart';

import '../controllers/comission_method_controller.dart';

class ComissionMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComissionMethodController>(
      () => ComissionMethodController(),
    );
  }
}
