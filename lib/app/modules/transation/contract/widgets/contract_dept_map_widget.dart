import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_depth_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/depth_map_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

//永续合约盘口
class ContractDeptMapWidget extends StatelessWidget {
  const ContractDeptMapWidget({
    super.key,
    required this.onValueChanged,
    required this.height,
  });

  final ValueChanged<DepthEntity?> onValueChanged;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContractDepthController>(
      global: true,
      builder: (controller) {
        return GetBuilder<ContractDataStoreController>(
            id: controller.contractInfo?.subSymbol ?? '',
            builder: (logic) {
              ContractInfo? contractInfo = logic.getContractInfoBySubSymbol(
                  controller.contractInfo?.subSymbol ?? '');
              return DepthMapWidget(
                onValueChanged: onValueChanged,
                price: controller.contractInfo?.symbol.symbolLast() ?? '--',
                amount: controller.contractInfo?.symbol.symbolFirst() ?? '--',
                height: height,
                onChangePrecision: (value) {
                  controller.changePrecision(value);
                },
                precisionList: controller.precisionList,
                precision: controller.precision,
                amountPrecision:
                    controller.contractInfo?.multiplier.numDecimalPlaces() ?? 2,
                buyAskType: controller.buyAskType,
                onChangeBuyAskType: (value) {
                  controller.buyAskType = value;
                  controller.update();
                },
                asks: controller.asks,
                buys: controller.buys,
                askMaxVol: controller.askMaxVol,
                buyMaxVol: controller.buyMaxVol,
                fundingRate: controller.fundingRate,
                closePrice: contractInfo?.close ?? '--',
                color: contractInfo?.priceColor ?? AppColor.colorBlack,
              );
            });
      },
    );
  }
}
