import 'package:get/get.dart';

import '../controllers/follow_taker_list_controller.dart';

class FollowTakerListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowTakerListController>(
      () => FollowTakerListController(),
    );
  }
}
