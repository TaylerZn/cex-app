import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_deposit/controllers/assets_deposit_controller.dart';

class AssetsDepositBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsDepositController>(
      () => AssetsDepositController(),
    );
  }
}
