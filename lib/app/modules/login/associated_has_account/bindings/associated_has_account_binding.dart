import 'package:get/get.dart';

import '../controllers/associated_has_account_controller.dart';

class AssociatedHasAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssociatedHasAccountController>(
      () => AssociatedHasAccountController(),
    );
  }
}
