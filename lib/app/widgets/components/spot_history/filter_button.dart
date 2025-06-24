import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../config/theme/app_color.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        height: 24.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: AppColor.colorEEEEEE,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyle.f_12_500.color333333,
            ),
            SizedBox(width: 6.w),
            MyImage(
              'assets/images/trade/entrust_filter_arrow.svg',
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
