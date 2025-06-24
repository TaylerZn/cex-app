import 'package:get/get.dart';

import '../controllers/assets_spots_info_controller.dart';

class AssetsSpotsHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsSpotsHistoryController>(
      () => AssetsSpotsHistoryController(),
    );
  }
}
