import 'package:get/get.dart';

import '../../../assets/assets_spots/controllers/assets_spots_controller.dart';

class AssetsSpotsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsSpotsController>(
      () => AssetsSpotsController(),
    );
  }
}
