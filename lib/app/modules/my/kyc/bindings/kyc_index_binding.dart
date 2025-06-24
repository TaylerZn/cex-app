import 'package:get/get.dart';

import '../controllers/kyc_index_controller.dart';

class KycIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KycIndexController>(
      () => KycIndexController(),
    );
  }
}
