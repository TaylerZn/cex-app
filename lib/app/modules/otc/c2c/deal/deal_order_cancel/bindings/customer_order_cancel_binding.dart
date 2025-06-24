import 'package:get/get.dart';

import '../controllers/customer_order_cancel_controller.dart';

class CustomerOrderCancelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerOrderCancelController>(
      () => CustomerOrderCancelController(),
    );
  }
}
