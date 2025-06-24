import 'package:get/get.dart';

import '../controllers/del_account_controller.dart';

class DelAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DelAccountController>(
      () => DelAccountController(),
    );
  }
}
