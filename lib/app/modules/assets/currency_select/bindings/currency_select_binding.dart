import 'package:get/get.dart';

import '../controllers/currency_select_controller.dart';

class CurrencySelectBinding extends Bindings {
  @override
  void dependencies() {
    var type = Get.arguments['type'];
    Get.lazyPut<CurrencySelectController>(
      () => CurrencySelectController(type: type),
    );
  }
}
