import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_funds/controllers/assets_funds_controller.dart';

class AssetsFundsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsFundsController>(
      () => AssetsFundsController(),
    );
  }
}
