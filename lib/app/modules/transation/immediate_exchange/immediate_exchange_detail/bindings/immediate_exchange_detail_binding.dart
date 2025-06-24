import 'package:get/get.dart';

import '../controllers/immediate_exchange_detail_controller.dart';

class ImmediateExchangeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImmediateExchangeDetailController>(
      () => ImmediateExchangeDetailController(),
    );
  }
}
