import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CommodityStopTradeTip extends StatelessWidget {
  const CommodityStopTradeTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.colorF5F5F5,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          MyImage(
            'assets/images/contract/icon_warm_toast.svg',
            width: 14.w,
          ),
          4.horizontalSpace,
          Text(
            LocaleKeys.trade33.tr,
            style: AppTextStyle.f_12_400.copyWith(color: AppColor.color666666),
          )
        ],
      ),
    );
  }
}
