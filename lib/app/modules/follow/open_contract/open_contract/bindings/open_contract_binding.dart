import 'package:get/get.dart';

import '../controllers/open_contract_controller.dart';

class OpenContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpenContractController>(
      () => OpenContractController(),
    );
  }
}
