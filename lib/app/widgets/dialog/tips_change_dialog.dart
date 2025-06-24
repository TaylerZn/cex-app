import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/theme/app_color.dart';
import '../../config/theme/app_text_style.dart';
import '../basic/my_button.dart';

class TipsChangeDialog extends StatelessWidget {
  const TipsChangeDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.email,
      required this.okTitle,
      required this.cancelTitle,
      this.onCancel,
      this.onOk,
      this.isContentCenter = false});
  final String title;
  final String content;
  final String email;
  final String okTitle;
  final String cancelTitle;
  final bool isContentCenter;
  final VoidCallback? onOk;
  final VoidCallback? onCancel;

  static show(
      {required String title,
      required String content,
      required String email,
      required String okTitle,
      required String cancelTitle,
      VoidCallback? onOk,
      VoidCallback? onCancel,
      bool isContentCenter = false}) {
    Get.dialog(
      TipsChangeDialog(
        title: title,
        content: content,
        email: email,
        okTitle: okTitle,
        cancelTitle: cancelTitle,
        isContentCenter: isContentCenter,
        onOk: onOk,
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
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColor.colorBackgroundPrimary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        width: 327.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            16.verticalSpace,
            Text(title, style: AppTextStyle.f_20_500.color0C0D0F),
            12.verticalSpace,
            Text(
              content,
              style: AppTextStyle.f_14_400.color0C0D0F,
              textAlign: isContentCenter ? TextAlign.center : TextAlign.start,
            ),
            8.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  email,
                  style: AppTextStyle.f_14_400.colorD29102,
                ),
              ],
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    height: 36.h,
                    borderRadius: BorderRadius.circular(20.h),
                    backgroundColor: AppColor.colorBackgroundPrimary,
                    text: cancelTitle,
                    border: Border.all(
                      width: 1.w,
                      color: AppColor.colorECECEC,
                    ),
                    textStyle: AppTextStyle.f_14_600,
                    color: AppColor.color111111,
                    onTap: () {
                      Get.back();
                      onCancel?.call();
                    },
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: MyButton(
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
                ),
              ],
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
