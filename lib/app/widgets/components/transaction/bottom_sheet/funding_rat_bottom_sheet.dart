import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/funding_rate.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../my_out_line_button.dart';
import 'bottom_sheet_util.dart';

class FundingRatBottomSheet extends StatelessWidget {
  const FundingRatBottomSheet({
    super.key,
    required this.fundingRate,
    required this.period,
  });

  // 资金费率
  final FundingRate fundingRate;

  // 周期
  final int period;

  static show({required FundingRate fundingRate, required int period}) {
    showBSheet(
      FundingRatBottomSheet(
        period: period,
        fundingRate: fundingRate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            Text(
              LocaleKeys.trade88.tr,
              style: AppTextStyle.f_20_600.color111111,
            ),
            24.verticalSpace,
            _buildTitleCount(title: LocaleKeys.trade206.tr, desc: '$period H'),
            _buildTitleCount(
              title: LocaleKeys.trade207.tr,
              desc:
                  fundingRate.currentFundRate == null ? '--' : '${((fundingRate.currentFundRate ?? 0) * 100).toPrecision(5)}% / ${((fundingRate.nextFundRate ?? 0) * 100 * 3).toPrecision(5)}%',
            ),
            _buildTitleCount(
              title: LocaleKeys.trade208.tr,
              desc:
                 fundingRate.nextFundRate == null ? '--' : '${((fundingRate.nextFundRate ?? 0) * 100).toPrecision(5)}% / ${((fundingRate.nextFundRate ?? 0) * 100 * 3).toPrecision(5)}%',
            ),
            12.verticalSpace,
            Divider(
              height: 1.h,
              color: AppColor.colorF5F5F5,
            ),
            12.verticalSpace,
            Text(
              LocaleKeys.trade209.tr,
              style: AppTextStyle.f_12_400.color999999,
              maxLines: 5,
            ),
          ],
        ).marginSymmetric(horizontal: 16.w),
        27.verticalSpace,
        Divider(
          height: 1.h,
          color: AppColor.colorF5F5F5,
        ),
        MyOutLineButton(
          title: LocaleKeys.trade210.tr,
          onTap: () {
            Get.back();
          },
        ).marginSymmetric(vertical: 16.h),
      ],
    );
  }
}

Widget _buildTitleCount(
    {required String title, required String desc, Color? color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: AppTextStyle.f_11_400.color666666,
      ),
      Text(
        desc,
        textAlign: TextAlign.right,
        style: AppTextStyle.f_13_500.color333333,
      )
    ],
  ).marginSymmetric(vertical: 6.h);
}
