import 'package:get/get.dart';

import '../controllers/comission_payment_list_controller.dart';

class ComissionPaymentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComissionPaymentListController>(
      () => ComissionPaymentListController(),
    );
  }
}
