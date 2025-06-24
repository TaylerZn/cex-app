import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginIndexController>(
      () => LoginIndexController(),
    );
  }
}
