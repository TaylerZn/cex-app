import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';

import '../../../../models/contract/res/public_info.dart';

class SwapContractAllController extends GetxController {
  static SwapContractAllController get to => Get.find();

  List<ContractInfo> contractList = [];

  @override
  Future<void> onReady() async {
    super.onReady();
    if (ContractDataStoreController.to.contractList.isEmpty) {
      await ContractDataStoreController.to.fetchPublicInfo();
    }
    _getAllContract();
  }

  _getAllContract() {
    contractList = ContractDataStoreController.to.contractList;
    update();
  }

  search(String keyword) {
    if (keyword.isEmpty) {
      _getAllContract();
      return;
    }
    List<ContractInfo> temp = List.from(contractList);
    contractList = temp
        .where((element) =>
            element.subSymbol.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    update();
  }
}
