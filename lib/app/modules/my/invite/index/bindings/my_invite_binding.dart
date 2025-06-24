import 'package:get/get.dart';

import '../controllers/my_invite_controller.dart';

class MeInviteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeInviteController>(
      () => MeInviteController(),
    );
  }
}
