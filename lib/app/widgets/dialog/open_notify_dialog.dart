import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class OpenNotifyDialog extends StatelessWidget {
  const OpenNotifyDialog({super.key});

  static show() {
    Get.dialog(
      const OpenNotifyDialog(),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.colorBackgroundPrimary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        width: 280.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.verticalSpace,
            MyImage(
              'assets/images/trade/open_notify.svg',
              width: 60.w,
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.trade362.tr,
              style: AppTextStyle.f_16_600.colorTextPrimary,
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.trade383.tr,
              style: AppTextStyle.f_12_400.colorTextSecondary,
            ),
            20.verticalSpace,
            MyButton(
              height: 36.h,
              borderRadius: BorderRadius.circular(20.h),
              backgroundColor: AppColor.colorBackgroundInversePrimary,
              text: LocaleKeys.trade364.tr,
              textStyle: AppTextStyle.f_14_600.colorTextInversePrimary,
              onTap: () {
                AppSettings.openAppSettings(type: AppSettingsType.notification);
                Get.back();
              },
            ),
            4.verticalSpace,
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 36.h,
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.public2.tr,
                  style: AppTextStyle.f_14_600.colorTextDescription,
                ),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
