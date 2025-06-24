import 'package:get/get.dart';

import '../controllers/currency_select_controller.dart';

class B2cCurrencySelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<B2cCurrencySelectController>(
      () => B2cCurrencySelectController(),
    );
  }
}
