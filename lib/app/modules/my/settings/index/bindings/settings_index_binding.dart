import 'package:get/get.dart';

import '../controllers/settings_index_controller.dart';

class MySettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySettingsController>(
      () => MySettingsController(),
    );
  }
}
