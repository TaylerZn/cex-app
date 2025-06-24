import 'package:get/get.dart';

import '../controllers/login_registered_pwd_controller.dart';

class LoginRegisteredPwdBinding extends Bindings {
  @override
  void dependencies() {
    var type = Get.arguments['type'];
    var verificatioData = Get.arguments['verificatioData'];
    Get.put<LoginRegisteredPwdController>(
      LoginRegisteredPwdController(
        type: type,
        verificatioData: verificatioData,
      ),
    );
  }
}
