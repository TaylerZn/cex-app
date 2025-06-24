import 'package:get/get.dart';

import '../controllers/follow_setup_success_controller.dart';

class FollowSetupSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowSetupSuccessController>(
      () => FollowSetupSuccessController(),
    );
  }
}
