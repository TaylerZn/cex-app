import 'package:get/get.dart';

import '../controllers/weal_index_controller.dart';

class WealIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WealIndexController>(
      () => WealIndexController(),
    );
  }
}
