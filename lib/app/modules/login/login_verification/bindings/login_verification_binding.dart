import 'package:get/get.dart';

import '../controllers/login_verification_controller.dart';

class LoginVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginVerificationController>(() {
      var verificatioData = Get.arguments['verificatioData'];
      // 用于三方登录验证
      var thirdType = Get.arguments['third_type'];
      var thirdData = Get.arguments['third_data'];

      return LoginVerificationController(
        verificatioData: verificatioData,
        thirdType: thirdType,
        thirdData: thirdData,
      );
    });
  }
}
