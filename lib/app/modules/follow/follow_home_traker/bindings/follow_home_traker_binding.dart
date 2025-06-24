import 'package:get/get.dart';

import '../controllers/follow_home_traker_controller.dart';

class FollowHomeTrakerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowHomeTrakerController>(
      () => FollowHomeTrakerController(),
    );
  }
}
