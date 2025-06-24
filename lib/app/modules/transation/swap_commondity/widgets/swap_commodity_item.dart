import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';

import '../../../../models/contract/res/public_info.dart';
import '../../swap_contract/widgets/contract_item.dart';

class SwapCommodityItem extends StatelessWidget {
  const SwapCommodityItem({super.key, required this.contractInfo});

  final ContractInfo contractInfo;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommodityDataStoreController>(
        id: contractInfo.subSymbol,
        builder: (logic) {
          ContractInfo model = logic.getContractInfoBySubSymbol(contractInfo.subSymbol) ?? contractInfo;
          return ContractItem(model: model,onTap: () => Get.back(result: model),);
        });
  }
}
