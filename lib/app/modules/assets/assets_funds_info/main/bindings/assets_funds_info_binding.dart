import 'package:get/get.dart';

import '../controllers/assets_funds_info_controller.dart';

class AssetsFundsInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsFundsInfoController>(
      () => AssetsFundsInfoController(),
    );
  }
}
