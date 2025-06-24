import 'package:get/get.dart';

import '../controllers/binding_verification_controller.dart';

class BindingVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindingVerificationController>(() {
      var type = Get.arguments['type'];
      var verificatioData = Get.arguments['verificatioData'];

      return BindingVerificationController(
        type: type,
        verificatioData: verificatioData,
      );
    });
  }
}
