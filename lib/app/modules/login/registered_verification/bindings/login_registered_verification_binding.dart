import 'package:get/get.dart';

import '../controllers/login_registered_verification_controller.dart';

class LoginRegisteredVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRegisteredVerificationController>(() {
      var type = Get.arguments['type'];
      var verificatioData = Get.arguments['verificatioData'];

      return LoginRegisteredVerificationController(
        type: type,
        verificatioData: verificatioData,
      );
    });
  }
}
