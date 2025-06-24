import 'package:get/get.dart';

import '../controllers/follow_my_star_controller.dart';

class FollowMyStarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowMyStarController>(
      () => FollowMyStarController(),
    );
  }
}
