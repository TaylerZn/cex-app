import 'package:get/get.dart';

import '../controllers/customer_index_controller.dart';

class CustomerIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerIndexController>(
      () => CustomerIndexController(),
    );
  }
}
