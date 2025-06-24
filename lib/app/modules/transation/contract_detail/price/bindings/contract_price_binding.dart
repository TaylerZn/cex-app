
import 'package:get/get.dart';

import '../controllers/contract_price_controller.dart';

class ContractPriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractPriceController>(
      () => ContractPriceController(),
    );
  }
}