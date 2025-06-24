import 'package:get/get.dart';

import '../controllers/follow_member_controller.dart';

class FollowMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowMemberController>(
      () => FollowMemberController(),
    );
  }
}
