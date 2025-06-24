import 'package:get/get.dart';

import '../controllers/exchange_rate_controller.dart';

class MySettingsUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySettingsUserController>(
      () => MySettingsUserController(),
    );
  }
}
