import 'package:get/get.dart';

import '../controllers/follow_setup_controller.dart';

class FollowSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowSetupController>(
      () => FollowSetupController(),
    );
  }
}
