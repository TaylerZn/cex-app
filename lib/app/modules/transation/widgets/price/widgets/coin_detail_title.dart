import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class CoinDetailTitle extends StatelessWidget {
  const CoinDetailTitle({
    super.key,
    required this.onTap,
    required this.title,
    this.subTitle,
  });

  final VoidCallback onTap;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.color111111,
                fontWeight: FontWeight.w700),
          ),
          if (subTitle != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              margin: EdgeInsets.only(left: 6.w),
              decoration: ShapeDecoration(
                color: AppColor.colorF2F2F2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                subTitle!,
                style: TextStyle(
                  color: AppColor.color4D4D4D,
                  fontSize: 10.sp,
                  fontFamily: 'Ark Sans SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20.sp,
            color: AppColor.color111111,
          ),
        ],
      ),
    );
  }
}
