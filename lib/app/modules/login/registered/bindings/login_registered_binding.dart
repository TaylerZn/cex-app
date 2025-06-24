import 'package:get/get.dart';

import '../controllers/login_registered_controller.dart';

class LoginRegisteredBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginRegisteredController>(
      LoginRegisteredController(),
    );
  }
}
