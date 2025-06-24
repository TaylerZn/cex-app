import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/app/widgets/dialog/dialog_topWidget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

Future<bool?> otcJumpMercuryBottomDialog(context) async {
  return showBSheet(Column(
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(16.w, 34.h, 16.w, 0),
        child: Column(
          children: [
            dialogTopWidget(LocaleKeys.b2c26.tr, LocaleKeys.b2c27.tr),
            Container(
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(top: 24.h),
              decoration: BoxDecoration(
                  color: AppColor.colorF5F5F5,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(width: 1, color: AppColor.colorEEEEEE)),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.b2c28.tr,
                    style: AppTextStyle.f_15_500,
                  ),
                  8.verticalSpace,
                  Text(
                    LocaleKeys.b2c29.tr,
                    style: AppTextStyle.f_12_400_15.color999999,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      20.verticalSpace,
      Container(
          padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyButton(
                height: 48.w,
                text: LocaleKeys.public1.tr,
                goIcon: true,
                onTap: () async {
                  Get.back(result: true);
                },
              ),
            ],
          ))
    ],
  ));
}
