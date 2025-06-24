import 'package:get/get.dart';

import '../controllers/system_notify_list_controller.dart';

class SystemNotifyListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SystemNotifyListController>(
      () => SystemNotifyListController(),
    );
  }
}
