import 'package:get/get.dart';

import '../controllers/my_take_manage_controller.dart';

class MyTakeManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTakeManageController>(
      () => MyTakeManageController(),
    );
  }
}
