import 'package:get/get.dart';

import '../controllers/customer_order_wait_controller.dart';

class CustomerOrderWaitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerOrderWaitController>(
      () => CustomerOrderWaitController(),
    );
  }
}
