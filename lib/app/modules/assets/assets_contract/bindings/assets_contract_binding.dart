import 'package:get/get.dart';

import '../../../assets/assets_contract/controllers/assets_contract_controller.dart';

class AssetsContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsContractController>(
      () => AssetsContractController(),
    );
  }
}
