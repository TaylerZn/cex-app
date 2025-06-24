import 'package:get/get.dart';

import '../controllers/customer_toc_controller.dart';

class CustomerTocBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerTocController>(
      () => CustomerTocController(),
    );
  }
}
