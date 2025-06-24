import 'package:get/get.dart';

import '../controllers/customer_order_controller.dart';

class CustomerOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerOrderController>(
      () => CustomerOrderController(),
    );
  }
}
