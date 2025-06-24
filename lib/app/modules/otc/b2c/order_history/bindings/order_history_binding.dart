import 'package:get/get.dart';

import '../controllers/order_history_controller.dart';

class B2cOrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<B2cOrderHistoryController>(
      () => B2cOrderHistoryController(),
    );
  }
}
