import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_out_line_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/withdrawal_index_controller.dart';

class MySafeC2CWithdrawal extends GetView<MySafeC2CWithdrawallController> {
  final int verifCount;
  final bool c2cStyle;
  const MySafeC2CWithdrawal(
      {super.key, this.verifCount = 2, this.c2cStyle = false});

  @override
  Widget build(BuildContext context) {
    Get.put(MySafeC2CWithdrawallController(verifCount: verifCount));
    return GetBuilder<MySafeC2CWithdrawallController>(builder: (controller) {
      return GetBuilder<UserGetx>(builder: (userGetx) {
        return SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                200.w,
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            LocaleKeys.user182.tr,
                            style: AppTextStyle.f_24_600,
                          ),
                        ),
                      ],
                    ),
                    6.verticalSpace,
                    Text(
                      LocaleKeys.user183.tr,
                      style: AppTextStyle.f_12_500.color999999,
                    ),
                    20.verticalSpace,
                    Text(
                      '${controller.currentIndex}/$verifCount',
                      style: AppTextStyle.f_28_600,
                    ),
                    28.verticalSpace,
                    box2faWidget(Ver2FAEnum.mobile, controller.smsCode,
                        userGetx.isMobileVerify),
                    SizedBox(
                      height: 16.w,
                    ),
                    box2faWidget(Ver2FAEnum.google, controller.googleCode,
                        userGetx.isGoogleVerify),
                  ],
                ))),
                Visibility(
                    visible: true,
                    child: Column(
                      children: [
                        MyOutLineButton(
                            title: LocaleKeys.trade210.tr,
                            onTap: () {
                              Get.back();
                            }),
                      ],
                    ))
              ],
            ));
      });
    });
  }

  box2faWidget(type, String code, bool isVerify) {
    var isCode = code != '';
    return InkWell(
      onTap: () {
        controller.verificationGo(type);
      },
      child: Container(
        height: 76.h,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColor.colorECECEC),
            borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Expanded(
                child: Text(
              Ver2FAEnum.getTypeName(type),
              style: AppTextStyle.f_16_500,
            )),
            isVerify
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(LocaleKeys.user184.tr,
                        style: AppTextStyle.f_14_500.colorABABAB),
                  ),
            MyImage(
              (isCode ? 'default/selected' : 'default/go').svgAssets(),
              width: 16.w,
              height: 16.w,
            )
          ],
        ),
      ),
    );
  }
}
