import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';

class TitleDetailButton extends StatelessWidget {
  const TitleDetailButton(
      {super.key,
      required this.title,
      this.detail,
      required this.bgColor,
      required this.onTap,
      this.height});

  final String title;
  final String? detail;
  final Color bgColor;
  final VoidCallback onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (UserGetx.to.goIsLogin()) {
          onTap();
        }
      },
      child: Container(
        height: height ?? 34.h,
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        alignment: Alignment.center,
        child: GetBuilder<UserGetx>(builder: (logic) {
          return Text(
            UserGetx.to.isLogin ? title : LocaleKeys.user9.tr,
            textAlign: TextAlign.center,
            style: AppTextStyle.f_14_600.copyWith(
              color: AppColor.colorWhite,
            ),
          );
        }),
      ),
    );
  }
}
