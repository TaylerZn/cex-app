import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/login/associated_account/controllers/associated_account_controller.dart';

class AssociatedAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssociatedAccountController>(
      () => AssociatedAccountController(),
    );
  }
}
