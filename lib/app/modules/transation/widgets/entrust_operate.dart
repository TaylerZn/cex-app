import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';

class EntrustOperate extends StatelessWidget {
  const EntrustOperate(
      {super.key,
      required this.isHideOther,
      required this.onHideOther,
      required this.onOneKeyClose});
  final bool isHideOther;
  final VoidCallback onHideOther;
  final VoidCallback onOneKeyClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorBorderGutter,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onHideOther,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyImage(
                  isHideOther
                      ? 'assets/images/contract/check_box_rounded.svg'
                      : 'assets/images/contract/check_box.svg',
                  width: 12.w,
                ),
                2.horizontalSpace,
                Text(
                  LocaleKeys.trade199.tr,
                  style: AppTextStyle.f_12_400.color999999,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onOneKeyClose,
            child: Container(
              height: 24.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: AppColor.colorBorderStrong,
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.trade57.tr,
                style: AppTextStyle.f_12_500.colorTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
