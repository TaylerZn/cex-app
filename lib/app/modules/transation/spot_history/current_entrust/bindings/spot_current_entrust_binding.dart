import 'package:get/get.dart';

import '../controllers/spot_current_entrust_controller.dart';

class SpotCurrentEntrustBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpotCurrentEntrustController>(
      () => SpotCurrentEntrustController(),
    );
  }
}
