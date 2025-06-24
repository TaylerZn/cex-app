import 'package:get/get.dart';

import '../controllers/login_forgot_pwd_controller.dart';

class LoginForgotPwdBinding extends Bindings {
  @override
  void dependencies() {
    var type = Get.arguments['type'];
    var verificatioData = Get.arguments['verificatioData'];
    Get.put<LoginForgotPwdController>(
      LoginForgotPwdController(
        type: type,
        verificatioData: verificatioData,
      ),
    );
  }
}
