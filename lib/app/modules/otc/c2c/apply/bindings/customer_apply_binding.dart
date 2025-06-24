import 'package:get/get.dart';

import '../controllers/customer_apply_controller.dart';

class CustomerApplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerApplyController>(
      () => CustomerApplyController(),
    );
  }
}
