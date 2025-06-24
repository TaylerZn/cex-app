import 'package:get/get.dart';

import '../controllers/my_settings_user_controller.dart';

class MySettingsUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySettingsUserController>(
      () => MySettingsUserController(),
    );
  }
}
