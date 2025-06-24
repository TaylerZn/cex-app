import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/apply_supertrader_success_controller.dart';

class ApplySupertraderSuccessView
    extends GetView<ApplySupertraderSuccessController> {
  const ApplySupertraderSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 116.h, bottom: 24.h),
              child: Container(
                width: 84.w,
                height: 84.w,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(32.w)),
                child: ClipOval(
                  child: MyImage(
                    'assets/images/my/setting/kyc_ok.png',
                  ),
                ),
              ),
            ),
            Text(
              LocaleKeys.follow292.tr,
              style: AppTextStyle.f_20_500.color111111,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Text(
                LocaleKeys.follow293.tr,
                style: AppTextStyle.f_12_400_15.color999999,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.back();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 48.w,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12.h),
                height: 48.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColor.color111111),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(LocaleKeys.public1.tr,
                        style: AppTextStyle.f_16_600.colorWhite),
                    MyImage('flow/follow_setup_arrow'.svgAssets(),
                        height: 24.r, width: 24.r, color: AppColor.colorWhite),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 45.h,
            )
          ],
        )),
      ),
    );
  }
}
