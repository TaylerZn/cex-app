import 'package:get/get.dart';

import '../controllers/my_follow_controller.dart';

class MyFollowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFollowController>(() => MyFollowController());
  }
}
