import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/app_color.dart';

Widget MyOutLineButton(
    {required String title,
    required VoidCallback onTap,
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? style,
    double? width,
    double? height}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: width,
      height: height ?? 48.h,
      padding: padding,
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: AppColor.colorBorderStrong, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: style ??
            TextStyle(
              fontSize: 16.sp,
              color: AppColor.color111111,
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
  );
}
