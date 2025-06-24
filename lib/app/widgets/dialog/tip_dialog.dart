import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/theme/app_color.dart';
import '../../config/theme/app_text_style.dart';
import '../basic/my_button.dart';

class TipsDialog extends StatelessWidget {
  const TipsDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.okTitle,
      this.isContentCenter = false});
  final String title;
  final String content;
  final String okTitle;
  final bool isContentCenter;

  static show(
      {required String title,
      required String content,
      required String okTitle,
      bool isContentCenter = false}) {
    Get.dialog(
      TipsDialog(
        title: title,
        content: content,
        okTitle: okTitle,
        isContentCenter: isContentCenter,
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
        width: 280.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            20.verticalSpace,
            Text(title, style: AppTextStyle.f_16_600.colorTextPrimary),
            12.verticalSpace,
            Text(
              content,
              style: AppTextStyle.f_14_400.colorTextPrimary,
              textAlign: isContentCenter ? TextAlign.center : TextAlign.start,
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
              },
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
