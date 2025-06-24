import 'package:get/get.dart';

import '../controllers/me_index_controller.dart';

class MeIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeIndexController>(
      () => MeIndexController(),
    );
  }
}
