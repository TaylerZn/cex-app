import 'package:get/get.dart';

import '../../../assets/assets_overview/controllers/assets_overview_controller.dart';

class AssetsOverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsOverviewController>(
      () => AssetsOverviewController(),
    );
  }
}
