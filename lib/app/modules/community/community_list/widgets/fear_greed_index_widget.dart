import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/community/widget/bomttom_dialog.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../global/dataStore/commodity_data_store_controller.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../utils/utilities/contract_util.dart';

class FearGreedIndexWidget extends StatelessWidget {
  final VoidCallback onTapCallback;
  final num index;

  const FearGreedIndexWidget(
      {super.key, required this.onTapCallback, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              BottomDialog.show(
                  title: LocaleKeys.community44.tr,
                  content: LocaleKeys.community131.tr);
            },
            child: Row(
              children: [
                Text(LocaleKeys.community44.tr, //恐惧和贪婪指数
                    style: AppTextStyle.f_15_600.colorTextPrimary),
                Padding(
                  padding: EdgeInsets.only(left: 2.w, top: 1.w),
                  child: MyImage(
                    'community/exclamation_mark'.svgAssets(),
                    width: 14.w,
                    height: 14.w,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              // Add your onTap functionality here
              onTapCallback();
              _jumpTrade();
            },
            child: Center(
              child: Text(
                LocaleKeys.community45.tr, //立即交易
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.colorAbnormal, // Hex color code for EAAD36
                  // Add other text style properties as needed
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 跳转到BTC行情页
  void _jumpTrade() {
    // ContractInfo? contractInfo =
    //     ContractDataStoreController.to.getContractInfoByContractId(1);
    // goToTrade(1, contractInfo: contractInfo);
    ContractInfo? contractInfo =
        CommodityDataStoreController.to.getContractInfoByContractId(1);
    goToCommodityKline(contractInfo: contractInfo!);
  }
}
