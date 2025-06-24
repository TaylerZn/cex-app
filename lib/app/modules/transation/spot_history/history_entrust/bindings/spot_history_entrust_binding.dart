import 'package:get/get.dart';

import '../controllers/spot_history_entrust_controller.dart';

class SpotHistoryEntrustBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpotHistoryEntrustController>(
      () => SpotHistoryEntrustController(),
    );
  }
}
