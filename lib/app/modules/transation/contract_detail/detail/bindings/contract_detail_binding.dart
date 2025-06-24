import 'package:get/get.dart';

import '../controllers/contract_detail_controller.dart';

class ContractDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractDetailController>(
      () => ContractDetailController(),
    );
  }
}
