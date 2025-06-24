import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_text_style.dart';

class MarketTitleWidget extends StatelessWidget {
  const MarketTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.markets16.tr,
            style: AppTextStyle.f_12_400.copyWith(
              color: AppColor.color999999,
            ),
          ),
          const Spacer(),
          Text(
            LocaleKeys.markets18.tr,
            style: AppTextStyle.f_12_400.copyWith(
              color: AppColor.color999999,
            ),
          ),
          12.horizontalSpace,
          Container(
            width: 70.w,
            alignment: Alignment.centerRight,
            child: Text(
              LocaleKeys.markets19.tr,
              style: AppTextStyle.f_12_400.copyWith(
                color: AppColor.color999999,
              ),
            ),
          )
        ],
      ),
    );
  }
}
