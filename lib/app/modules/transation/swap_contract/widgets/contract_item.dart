import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';

import '../../../../config/theme/app_text_style.dart';
import '../../../markets/market/widgets/market_list_icon.dart';

class ContractItem extends StatelessWidget {
  const ContractItem({super.key, required this.model, required this.onTap});

  final ContractInfo model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 54.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MarketIcon(
              iconName: model.base.toUpperCase(),
              width: 24.w,
            ).marginOnly(right: 8.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        model.firstName,
                        style: AppTextStyle.f_14_600.colorTextPrimary,
                      ),
                      Text(
                        model.secondName,
                        style: AppTextStyle.f_12_400.colorTextTips,
                      ),
                      4.horizontalSpace,

                      /// 只有永续合约才有标识
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.colorF1F1F1,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          model.getContractType,
                          style: AppTextStyle.f_10_500.color4D4D4D,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Text(
                      model.volStr,
                      style: AppTextStyle.f_11_400.colorTextTips.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            // const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  model.priceStr,
                  textAlign: TextAlign.right,
                  style: AppTextStyle.f_15_600.colorTextPrimary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    model.desPriceStr,
                    textAlign: TextAlign.right,
                    style: AppTextStyle.f_11_400.colorTextTips,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 12.w,
            ),
            Container(
              width: 70.w,
              height: 32.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: model.backColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              child: Text(
                model.roseStr,
                textAlign: TextAlign.center,
                style: AppTextStyle.f_14_500.colorAlwaysWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
