import 'package:get/get.dart';

import '../controllers/my_safe_controller.dart';

class MySafeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeController>(
      () => MySafeController(),
    );
  }
}
