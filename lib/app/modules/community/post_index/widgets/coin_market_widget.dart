import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class CoinMarketWidget extends StatelessWidget {
  const CoinMarketWidget({super.key, required this.contractInfo});

  final ContractInfo contractInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToCommodityKline(contractInfo: contractInfo);
      },
      child: GetBuilder<CommodityDataStoreController>(
        id: contractInfo.subSymbol,
        builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.w),
            decoration: BoxDecoration(
              color: AppColor.colorF5F5F5,
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${contractInfo.firstName}${contractInfo.secondName}',
                  style: AppTextStyle.f_11_500.colorTextSecondary,
                ),
                Text(
                  ' ${contractInfo.roseStr}',
                  style: AppTextStyle.f_11_500.copyWith(
                    color: contractInfo.backColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
