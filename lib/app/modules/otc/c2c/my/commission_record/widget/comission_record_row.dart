import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_out_line_button.dart';
import 'package:nt_app_flutter/app/widgets/dialog/confirm_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../../models/otc/c2c/advert_model.dart';

class ComissionRecordRow extends StatelessWidget {
  final Function? onTap;
  final DataList? data;
  const ComissionRecordRow({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.colorEEEEEE),
          borderRadius: BorderRadius.all(
            Radius.circular(6.r),
          ),
        ),
        child: Column(
          children: [
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                        data?.isPurchase == true
                            ? LocaleKeys.b2c8.tr
                            : LocaleKeys.c2c13.tr,
                        style: data?.isPurchase == true
                            ? AppTextStyle.f_14_500.upColor
                            : AppTextStyle.f_14_500.downColor),
                    4.horizontalSpace,
                    Text(data?.coin ?? 'USDT', style: AppTextStyle.f_14_500)
                  ],
                ),
                MyOutLineButton(
                    height: 21.h,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    title: LocaleKeys.c2c25.tr,
                    style: AppTextStyle.f_10_400,
                    onTap: () {
                      Get.dialog(ConfirmDialog(
                          title: LocaleKeys.c2c46.tr,
                          confirmCallback: () {
                            onTap?.call();
                          }));
                    })
              ],
            ),
            16.verticalSpace,
            Container(height: 1.h, color: AppColor.colorEEEEEE),
            16.verticalSpace,
            firstList(),
            6.verticalSpace,
            Container(height: 1.h, color: AppColor.colorEEEEEE),
            16.verticalSpace,
            secondList(),
            6.verticalSpace,
          ],
        ));
  }

  Widget firstList() {
    Map<String, dynamic> params = {
      LocaleKeys.c2c14.tr:
          '${data?.price.toString().removeInvalidZero()} ${data?.paycoinTrade}',
      LocaleKeys.c2c15.tr: '${data?.volume} ${data?.coin ?? 'USDT'}',
      LocaleKeys.c2c16.tr:
          '${data?.paycoinSymbol}${data?.minTrade.toString().removeInvalidZero()} - ${data?.paycoinSymbol}${data?.maxTrade.toString().removeInvalidZero()}',
      LocaleKeys.c2c17.tr: '${data?.createTime}'
    };
    List<Widget> children = params.keys
        .toList()
        .map((e) => Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e, style: AppTextStyle.f_12_400.color666666),
                  Text(
                    params[e],
                    style: AppTextStyle.f_12_400.color333333,
                  )
                ],
              ),
            ))
        .toList();
    return Column(children: children);
  }

  Widget secondList() {
    Map<String, dynamic> params = {
      LocaleKeys.c2c22.tr:
          '${data?.sell.toString().removeInvalidZero()} ${data?.coin}',
      LocaleKeys.c2c23.tr:
          '${data?.stock.toString().removeInvalidZero()} ${data?.coin}',
      LocaleKeys.c2c24.tr:
          '${data?.paycoinSymbol}${data?.payAmount.toString().removeInvalidZero()}'
    };
    if (data?.isPurchase == false) {
      params = {
        LocaleKeys.c2c176.tr:
            '${data?.sell.toString().removeInvalidZero()} ${data?.coin}',
        LocaleKeys.c2c19.tr:
            '${data?.stock.toString().removeInvalidZero()} ${data?.coin}',
        LocaleKeys.c2c20.tr:
            '${data?.paycoinSymbol}${data?.payAmount.toString().removeInvalidZero()}'
      };
    }
    List<Widget> children = params.keys
        .toList()
        .map((e) => Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e, style: AppTextStyle.f_12_400.color666666),
                  Text(params[e], style: AppTextStyle.f_12_400.color333333)
                ],
              ),
            ))
        .toList();
    return Column(children: children);
  }
}
