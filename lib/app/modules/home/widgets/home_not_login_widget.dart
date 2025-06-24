import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_text_style.dart';
import '../../../getX/user_Getx.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/basic/my_button.dart';

class HomeNotLoginWidget extends StatelessWidget {
  const HomeNotLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/json/air.json', width: 250.w, height: 250.w),
        Text(
          LocaleKeys.public71.tr,
          style: AppTextStyle.f_16_600.colorTextSecondary,
          textAlign: TextAlign.center,
        ),
        8.verticalSpaceFromWidth,
        Text(
          LocaleKeys.public72.tr,
          style: AppTextStyle.f_13_400.colorTextDescription,
          textAlign: TextAlign.center,
        ),
        28.verticalSpaceFromWidth,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyButton(
              backgroundColor: AppColor.colorBackgroundTertiary,
              minWidth: 165.5.w,
              height: 36.w,
              borderRadius: BorderRadius.circular(60.w),
              text: LocaleKeys.public69.tr,
              color: AppColor.colorTextSecondary,
              textStyle: AppTextStyle.f_14_600,
              onTap: () {
                Get.toNamed(Routes.LOGIN_REGISTERED);
              },
            ),
            MyButton(
              minWidth: 165.5.w,
              height: 36.w,
              backgroundColor: AppColor.colorBackgroundInversePrimary,
              borderRadius: BorderRadius.circular(60.w),
              text: LocaleKeys.user6.tr,
              textStyle: AppTextStyle.f_14_600,
              onTap: () {
                UserGetx.to.goIsLogin();
              },
            ),
          ],
        ),
        // 12.verticalSpaceFromWidth,
      ],
    );
  }
}
