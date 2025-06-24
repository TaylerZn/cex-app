import 'package:get/get.dart';

import '../controllers/my_take_shield_controller.dart';

class MyTakeShieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTakeShieldController>(
      () => MyTakeShieldController(),
    );
  }
}
