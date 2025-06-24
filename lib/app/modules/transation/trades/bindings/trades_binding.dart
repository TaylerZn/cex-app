import 'package:get/get.dart';

import '../controllers/trades_controller.dart';

class TradesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TradesController>(
      () => TradesController(),
      fenix: true,
    );
  }
}
