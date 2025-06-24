import 'package:get/get.dart';

import '../controllers/assistance_controller.dart';

class AssistanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AssistanceController>(
      AssistanceController(),
    );

  }
}
