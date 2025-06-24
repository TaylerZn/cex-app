import 'package:get/get.dart';

import '../controllers/login_forgot_controller.dart';

class LoginForgotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginForgotController>(
      () => LoginForgotController(),
    );
  }
}
