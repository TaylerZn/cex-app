import 'package:get/get.dart';

import '../controllers/entrust_controller.dart';

class EntrustBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EntrustController>(
      () => EntrustController(),
    );
  }
}
