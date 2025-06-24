import 'package:get/get.dart';

import '../controllers/communnity_notify_controller.dart';

class CommunnityNotifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunnityNotifyController>(
      () => CommunnityNotifyController(),
    );
  }
}
