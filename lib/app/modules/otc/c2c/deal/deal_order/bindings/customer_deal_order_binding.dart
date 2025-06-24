import 'package:get/get.dart';

import '../controllers/customer_deal_order_controller.dart';

class CustomerDealOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerDealOrderController>(
      () => CustomerDealOrderController(),
    );
  }
}
