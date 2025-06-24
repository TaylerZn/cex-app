import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ConvertFaqWidget extends StatelessWidget {
  const ConvertFaqWidget({super.key});

  static show() {
    showBSheet(const ConvertFaqWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.colorFFFFFF,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r))),
      padding: EdgeInsets.only(top: 19.h, bottom: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(LocaleKeys.trade315.tr, style: AppTextStyle.f_24_600.color111111)
              .marginSymmetric(horizontal: 16.w), //常见问题
          SizedBox(height: 24.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFAQItem(LocaleKeys.trade316.tr, LocaleKeys.trade317.tr), //
              SizedBox(height: 24.h),
              _buildFAQItem(LocaleKeys.trade318.tr, LocaleKeys.trade319.tr),
              SizedBox(height: 24.h),
              _buildFAQItem(LocaleKeys.trade320.tr, LocaleKeys.trade321.tr),
              SizedBox(height: 24.h),
            ],
          ),
          //加一条分割线
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(color: AppColor.colorECECEC, height: 1.0.h),
              MyButton.outline(
                  text: LocaleKeys.trade322.tr,
                  onTap: () {
                    Get.back();
                  }).marginAll(16.w),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: AppTextStyle.f_15_500.color111111,
        ),
        SizedBox(height: 8.0.h),
        Text(
          answer,
          style: AppTextStyle.f_12_400.color666666,
        ),
      ],
    ).marginSymmetric(horizontal: 16.w);
  }
}
