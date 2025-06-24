import 'package:get/get.dart';

import '../controllers/customer_my_controller.dart';

class CustomerMyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomerMyController());
  }
}
