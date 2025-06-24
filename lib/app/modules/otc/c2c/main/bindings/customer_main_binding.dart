import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/controllers/customer_my_controller.dart';

import '../controllers/customer_main_controller.dart';

class CustomerMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerMainController>(
      () => CustomerMainController(),
    );
    Get.put(CustomerMyController());

  }
}
