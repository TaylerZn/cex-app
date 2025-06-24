import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../models/contract/res/position_res.dart';
import '../../../../utils/utilities/number_util.dart';
import '../../../markets/market/widgets/market_list_icon.dart';

class AssetContractItem extends StatelessWidget {
  const AssetContractItem({super.key, required this.accountRes});
  final AccountRes accountRes;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MarketIcon(iconName: accountRes.symbol, width: 24.w),
            SizedBox(
              width: 8.w,
            ),
            Text(
              accountRes.symbol,
              style: AppTextStyle.f_16_500.color111111,
            )
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: 164.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.assets14.tr, style: AppTextStyle.f_11_400.colorABABAB),
                    SizedBox(height: 2.h),
                    Text(NumberUtil.mConvert(accountRes.accountBalance, isEyeHide: true, count: 2),
                        style: AppTextStyle.f_14_500.color111111),
                  ],
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.assets15.tr, style: AppTextStyle.f_11_400.colorABABAB),
                SizedBox(height: 2.h),
                Text(NumberUtil.mConvert(accountRes.unRealizedAmount, isEyeHide: true, isRate: null, count: 6),
                    style: AppTextStyle.f_14_500.color111111),
              ],
            )
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 164.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocaleKeys.assets20.tr, style: AppTextStyle.f_11_400.colorABABAB),
                  SizedBox(height: 2.h),
                  Text(
                      NumberUtil.mConvert(
                          accountRes
                              // .totalMargin, // totalMargin ->  totalAmount 字段与web对齐
                              .marginAmount, // totalMargin ->  totalAmount 字段与web对齐 -> accountBalance
                          isEyeHide: true,
                          count: 2),
                      style: AppTextStyle.f_14_500.color111111),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.assets21.tr, style: AppTextStyle.f_11_400.colorABABAB),
                SizedBox(height: 2.h),
                Text(NumberUtil.mConvert(accountRes.canTransferAmount, isEyeHide: true, count: 2),
                    style: AppTextStyle.f_14_500.color111111),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 164.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocaleKeys.other56.tr, style: AppTextStyle.f_11_400.colorABABAB),
                  SizedBox(height: 2.h),
                  Text(NumberUtil.mConvert(accountRes.trialAmount, isEyeHide: true, count: 2),
                      style: AppTextStyle.f_14_500.color111111),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
