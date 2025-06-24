import 'package:get/get.dart';

import '../controllers/appeal_controller.dart';

class AppealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppealController>(() {
      return AppealController(complainId: Get.arguments);
    });
  }
}
