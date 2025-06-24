import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/theme/app_color.dart';
import '../../config/theme/app_text_style.dart';
import '../basic/my_button.dart';
import '../basic/my_image.dart';

class WarningWithImgDialog extends StatelessWidget {
  const WarningWithImgDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.icon,
      required this.okTitle,
      this.cancelTitle,
      this.onOk,
      this.onCancel});

  final String title;
  final Widget content;
  final String icon;
  final String okTitle;
  final String? cancelTitle;
  final VoidCallback? onOk;
  final VoidCallback? onCancel;

  static show(
      {required String title,
      required Widget content,
      required String icon,
      required String okTitle,
      VoidCallback? onOk,
      String? cancelTitle,
      VoidCallback? onCancel}) {
    Get.dialog(
      WarningWithImgDialog(
        title: title,
        content: content,
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
              width: 80.w,
            ),
            12.verticalSpace,
            Text(
              title,
              style: AppTextStyle.f_20_500.colorTextPrimary,
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,
            content,
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
