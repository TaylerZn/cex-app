import 'package:get/get.dart';

import '../controllers/sales_comission_controller.dart';

class SalesComissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesComissionController>(
      () => SalesComissionController(),
    );
  }
}
