import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class FilterDateTimeButton extends StatelessWidget {
  const FilterDateTimeButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 24.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: AppColor.colorEEEEEE,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: MyImage(
          'assets/images/commodity/filter.svg',
          width: 13.w,
          height: 13.h,
        ),
      ),
    );
  }
}
