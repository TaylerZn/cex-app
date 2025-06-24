import 'package:get/get.dart';

import '../controllers/my_take_parting_controller.dart';

class MyTakePartingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTakePartingController>(
      () => MyTakePartingController(),
    );
  }
}
