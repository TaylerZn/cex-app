import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

import '../../../../config/theme/app_color.dart';

class SuffixDownButton extends StatelessWidget {
  const SuffixDownButton({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 1,
          height: 12.h,
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: const BoxDecoration(
            color: AppColor.colorDDDDDD,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 40.h,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyle.f_12_400.colorTextPrimary,
                ),
                8.horizontalSpace,
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 14.sp,
                  color: AppColor.color666666,
                ),
                4.horizontalSpace,
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SuffixAddSubButton extends StatelessWidget {
  const SuffixAddSubButton(
      {super.key, required this.onAddTap, required this.onSubTap});

  final VoidCallback onAddTap;
  final VoidCallback onSubTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton(
          title: '-',
          onTap: onSubTap,
        ),
        Container(
          width: 1.w,
          height: 12.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: const BoxDecoration(
            color: AppColor.colorDDDDDD,
          ),
        ),
        _buildButton(
          title: '+',
          onTap: onAddTap,
        ),
      ],
    );
  }

  _buildButton({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 40.h,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: AppColor.color111111,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
