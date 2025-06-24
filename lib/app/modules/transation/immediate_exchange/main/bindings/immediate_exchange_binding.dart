import 'package:get/get.dart';

import '../controllers/immediate_exchange_controller.dart';

class ImmediateExchangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImmediateExchangeController>(
      () => ImmediateExchangeController(),
    );
  }
}
