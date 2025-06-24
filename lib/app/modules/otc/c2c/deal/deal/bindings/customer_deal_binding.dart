import 'package:get/get.dart';

import '../controllers/customer_deal_controller.dart';

class CustomerDealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerDealController>(
      () => CustomerDealController(),
    );
  }
}
