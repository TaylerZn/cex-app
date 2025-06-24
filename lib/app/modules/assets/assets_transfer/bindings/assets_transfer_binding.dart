import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_contract/controllers/assets_contract_controller.dart';

import '../controllers/assets_transfer_controller.dart';

class AssetsTransferBinding extends Bindings {
  @override
  void dependencies() {
    int defaultFrom = Get.arguments['from'];
    int defaultTo = Get.arguments['to'];
    Get.lazyPut<AssetsTransferController>(
      () => AssetsTransferController(from: defaultFrom.obs, to: defaultTo.obs),
    );
    Get.lazyPut<AssetsContractController>(() => AssetsContractController());
  }
}
