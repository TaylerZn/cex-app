import 'package:get/get.dart';

import '../controllers/apply_supertrader_states_controller.dart';

class ApplySupertraderStatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplySupertraderStatesController>(
      () => ApplySupertraderStatesController(),
    );
  }
}
