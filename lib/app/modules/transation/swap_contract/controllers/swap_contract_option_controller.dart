import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/favorite/contract_favorite_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';

import '../../../../global/dataStore/contract_data_store_controller.dart';
import '../../../../models/contract/res/public_info.dart';

class SwapContractOptionController extends GetxController {
  static SwapContractOptionController get to => Get.find();

  List<ContractInfo> contractList = [];

  @override
  void onInit() {
    super.onInit();
    Bus.getInstance().on(EventType.refreshContractOption, (data) {
      _getAllOptionContract();
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    if (ContractDataStoreController.to.contractList.isEmpty) {
      await Future.wait([
        ContractDataStoreController.to.fetchPublicInfo(),
        ContractOptionController.to.fetchOptionContractIdList()
      ]);
    }
    _getAllOptionContract();
  }

  _getAllOptionContract() {
    contractList = ContractDataStoreController.to.contractList
        .where((element) =>
            ContractOptionController.to.optionContractList.contains(element.id))
        .toList();
    update();
  }

  search(String keyword) {
    if (keyword.isEmpty) {
      _getAllOptionContract();
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
