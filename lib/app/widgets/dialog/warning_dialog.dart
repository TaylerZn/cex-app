import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/theme/app_color.dart';
import '../../config/theme/app_text_style.dart';
import '../basic/my_button.dart';
import '../basic/my_image.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog(
      {super.key,
      required this.title,
      required this.icon,
      required this.okTitle,
      this.cancelTitle,
      this.onOk,
      this.onCancel});

  final String title;
  final String icon;
  final String okTitle;
  final String? cancelTitle;
  final VoidCallback? onOk;
  final VoidCallback? onCancel;

  static show(
      {required String title,
      required String icon,
      required String okTitle,
      VoidCallback? onOk,
      String? cancelTitle,
      VoidCallback? onCancel}) {
    Get.dialog(
      WarningDialog(
        title: title,
        icon: icon,
        okTitle: okTitle,
        onOk: onOk,
        cancelTitle: cancelTitle,
        onCancel: onCancel,
      ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            20.verticalSpace,
            MyImage(
              icon,
              width: 68.w,
            ),
            12.verticalSpace,
            Text(
              title,
              style: AppTextStyle.f_14_400.colorTextPrimary,
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            MyButton(
              height: 36.h,
              borderRadius: BorderRadius.circular(20.h),
              backgroundColor: AppColor.colorBackgroundInversePrimary,
              text: okTitle,
              textStyle: AppTextStyle.f_14_600.colorTextInversePrimary,
              onTap: () {
                Get.back();
                onOk?.call();
              },
            ),
            if (cancelTitle != null)
              MyButton(
                height: 36.h,
                backgroundColor: AppColor.colorAlwaysWhite,
                text: cancelTitle!,
                textStyle: AppTextStyle.f_14_600,
                color: AppColor.colorTextPrimary,
                onTap: () {
                  Get.back();
                  onCancel?.call();
                },
              ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
