import 'package:get/get.dart';

import '../controllers/customer_handle_controller.dart';

class CustomerOrderHandleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerOrderHandleController>(
      () => CustomerOrderHandleController(),
    );
  }
}
