import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class SelectionButton extends StatelessWidget {
  const SelectionButton(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.onTap,
      required this.decoration,
      required this.onTipsTap});

  final double height;
  final double width;
  final String text;
  final BoxDecoration decoration;
  final VoidCallback? onTap;
  final VoidCallback? onTipsTap;

  factory SelectionButton.outline(
      {required double height,
      required double width,
      required String text,
      required VoidCallback onTap}) {
    return SelectionButton(
      height: height,
      width: width,
      text: text,
      onTap: onTap,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: AppColor.colorBorderStrong,
          width: 1,
        ),
      ),
      onTipsTap: null,
    );
  }

  factory SelectionButton.normal(
      {required double height,
      required double width,
      required String text,
      VoidCallback? onTap}) {
    return SelectionButton(
      height: height,
      width: width,
      text: text,
      onTap: onTap,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: AppColor.colorF5F5F5,
      ),
      onTipsTap: null,
    );
  }

  factory SelectionButton.tips({
    required double height,
    required double width,
    required String text,
    required VoidCallback onTap,
    required VoidCallback onTipsTap,
  }) {
    return SelectionButton(
      height: height,
      width: width,
      text: text,
      onTap: onTap,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: AppColor.colorBackgroundInput,
      ),
      onTipsTap: onTipsTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8.w, right: 4.w),
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onTipsTap != null)
              InkWell(
                onTap: onTipsTap,
                child: Container(
                  width: 12.sp,
                  height: height,
                  margin: EdgeInsets.only(right: 4.w),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.info,
                    color: AppColor.color999999,
                    size: 12.sp,
                  ),
                ),
              ),
            Text(
              text,
              style: AppTextStyle.f_12_500.colorTextSecondary,
            ),
            const Spacer(),
            if (onTap != null)
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 14.sp,
                color: AppColor.color666666,
              ),
          ],
        ),
      ),
    );
  }
}
