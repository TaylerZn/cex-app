import 'package:get/get.dart';

import '../controllers/my_take_controller.dart';

class MyTakeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTakeController>(
      () => MyTakeController(),
    );
  }
}
