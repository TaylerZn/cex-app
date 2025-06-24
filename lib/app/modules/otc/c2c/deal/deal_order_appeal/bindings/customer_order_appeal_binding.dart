import 'package:get/get.dart';

import '../controllers/customer_order_appeal_controller.dart';

class CustomerOrderAppealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerOrderAppealController>(
      () => CustomerOrderAppealController(),
    );
  }
}
