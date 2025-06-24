import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/price/controllers/contract_price_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/price_detail_view.dart';

import '../../../../../models/contract/res/public_info.dart';

class ContractPriceView extends GetView<ContractPriceController> {
  const ContractPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContractDataStoreController>(
      id: controller.contractInfo?.subSymbol ?? '',
      builder: (logic) {
        ContractInfo contractInfo = logic.getContractInfoByContractId(
                controller.contractInfo?.id ?? 0) ??
            controller.contractInfo!;
        controller.detailState.contractInfo.value = contractInfo;
        return PriceDetailView(
          detailState: controller.detailState,
          onTabChanged: controller.onTabChanged,
          onSubTimeChanged: controller.onSubTimeChanged,
          onMainStateChanged: controller.onMainStateChanged,
          onSecondaryStateChanged: controller.onSecondaryStateChanged,
          onLoadMore: controller.onLoadMore,
        );
      },
    );
  }
}
