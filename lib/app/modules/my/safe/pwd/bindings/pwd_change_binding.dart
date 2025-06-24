import 'package:get/get.dart';

import '../controllers/pwd_change_controller.dart';

class MySafePwdChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MySafePwdChangeController>(
      MySafePwdChangeController(),
    );
  }
}
