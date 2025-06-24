import 'package:get/get.dart';

import '../controllers/my_take_block_controller.dart';

class MyTakeBlockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTakeBlockController>(
      () => MyTakeBlockController(),
    );
  }
}
