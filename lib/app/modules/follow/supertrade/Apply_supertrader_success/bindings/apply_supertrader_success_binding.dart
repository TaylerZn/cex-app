import 'package:get/get.dart';

import '../controllers/apply_supertrader_success_controller.dart';

class ApplySupertraderSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplySupertraderSuccessController>(
      () => ApplySupertraderSuccessController(),
    );
  }
}
