import 'package:get/get.dart';

import '../controllers/third_account_controller.dart';

class ThirdAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThirdAccountController>(
      () => ThirdAccountController(),
    );
  }
}
