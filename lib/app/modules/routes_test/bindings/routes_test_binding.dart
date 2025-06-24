import 'package:get/get.dart';

import '../controllers/routes_test_controller.dart';

class RoutesTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoutesTestController>(
      () => RoutesTestController(),
    );
  }
}
