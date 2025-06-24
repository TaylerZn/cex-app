import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/app_color.dart';

class TitleSelectedWidget extends StatelessWidget {
  const TitleSelectedWidget(
      {super.key,
      required this.title,
      required this.width,
      required this.value,
      this.onTap,
      this.canPop = true});

  final String title;
  final double width;
  final String value;
  final VoidCallback? onTap;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColor.color666666,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          10.verticalSpace,
          Container(
            height: 44.h,
            width: width,
            decoration: ShapeDecoration(
              color: AppColor.colorF4F4F4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: AppColor.color666666,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (canPop)
                  Container(
                    width: 36.w,
                    height: 44.h,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 16.sp,
                      color: AppColor.color111111,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
