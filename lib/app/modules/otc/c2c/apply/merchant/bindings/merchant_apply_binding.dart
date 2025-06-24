import 'package:get/get.dart';

import '../controllers/merchant_apply_controller.dart';

class MerchantApplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantApplyController>(
      () => MerchantApplyController(),
    );
  }
}
