import 'package:get/get.dart';

import '../controllers/customer_user_controller.dart';

class CustomerUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerUserController>(
      () => CustomerUserController(),
    );
  }
}
