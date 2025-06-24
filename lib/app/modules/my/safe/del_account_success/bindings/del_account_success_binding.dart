import 'package:get/get.dart';

import '../controllers/del_account_success_controller.dart';

class DelAccountSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DelAccountSuccessController>(
      () => DelAccountSuccessController(),
    );
  }
}
