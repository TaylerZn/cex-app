import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/follow_setup_success_controller.dart';

class FollowSetupSuccessView extends GetView<FollowSetupSuccessController> {
  const FollowSetupSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 116.h, bottom: 24.h),
            child: Container(
              width: 84.w,
              height: 84.w,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(32.w)),
              child: ClipOval(
                child: MyImage(
                  'assets/images/my/setting/kyc_ok.png',
                ),
              ),
            ),
          ),
          Text(LocaleKeys.follow65.tr, style: AppTextStyle.f_20_500.color111111),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              LocaleKeys.follow66.tr,
              style: AppTextStyle.f_12_400_15.color999999,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.offAndToNamed(Routes.MY_FOLLOW),
            child: Container(
              width: MediaQuery.of(context).size.width - 32.w,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12.h),
              height: 48.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(48), color: AppColor.color111111),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(LocaleKeys.follow67.tr, style: AppTextStyle.f_16_600.colorWhite),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: MediaQuery.of(context).size.width - 32.w,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12.h),
              height: 48.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(48), border: Border.all(color: AppColor.color111111)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(LocaleKeys.follow68.tr, style: AppTextStyle.f_16_600.color111111),
                ],
              ),
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).padding.bottom)
          SizedBox(
            height: 45.h,
          )
        ],
      )),
    );
  }
}
