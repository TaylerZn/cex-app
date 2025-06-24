import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_apply_info.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'apply_index.dart';
import 'controllers/customer_apply_controller.dart';

extension ApplyIndexViewSub on ApplyIndexView {
  Widget buildBottomContent() {
    final controller = Get.find<CustomerApplyController>();
    switch (controller.applyStage) {
      case 0:
        {
          return Column(
            children: [
              InkWell(
                onTap: () async {
                  await controller.performCase();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${LocaleKeys.c2c76.tr}',
                        style: AppTextStyle.f_12_400.colorFFFFFF),
                    Row(
                      children: [
                        Visibility(
                            visible: controller.applyInfo?.formFilled ?? false,
                            child: MyImage('otc/c2c/selected_icon'.svgAssets(),
                                width: 14.w, height: 14.w)),
                        Visibility(
                            visible: controller.applyInfo?.formFilled == false,
                            child: Row(
                              children: [
                                Text(LocaleKeys.c2c78.tr,
                                    style: AppTextStyle.f_12_400.color7E7E7E),
                                8.horizontalSpace,
                                MyImage('otc/c2c/right_arrow'.svgAssets())
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                  onTap: () {
                    if (controller.applyInfo?.otcStatus ==
                        OTCApplyStatus.payDeposit) {
                      controller.payDeposit(0);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocaleKeys.c2c77.tr,
                          style: controller.applyInfo?.formFilled == true
                              ? AppTextStyle.f_12_400.colorFFFFFF
                              : AppTextStyle.f_12_400.color7E7E7E),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                              visible:
                                  controller.applyInfo?.depositPayed ?? false,
                              child: MyImage(
                                  'otc/c2c/selected_icon'.svgAssets(),
                                  width: 14.w,
                                  height: 14.w)),
                          Visibility(
                              visible:
                                  (controller.applyInfo?.formFilled ?? false) &&
                                      controller.applyInfo?.marginStatus == 0,
                              child: Row(
                                children: [
                                  Text(LocaleKeys.c2c80.tr,
                                      style: AppTextStyle.f_12_400.color7E7E7E),
                                  8.horizontalSpace,
                                  MyImage('otc/c2c/right_arrow'.svgAssets())
                                ],
                              ))
                        ],
                      )
                    ],
                  )),
            ],
          );
        }
      case 1:
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.c2c81.tr,
                  style: AppTextStyle.f_12_400.colorFFFFFF),
              SizedBox(height: 16.h),
              Text(LocaleKeys.c2c82.tr,
                  style: AppTextStyle.f_12_400.colorEEEEEE),
            ],
          );
        }
      case 2:
        {
          return DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(10.r),
            dashPattern: [5, 3],
            color: Colors.white.withOpacity(0.2),
            strokeWidth: 1,
            strokeCap: StrokeCap.square,
            child: ClipRRect(
              //  borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 47.h,
                  width: 327.w,
                  color: AppColor.color1A1A1A,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocaleKeys.c2c83.tr,
                          style: AppTextStyle.f_12_600.colorFFFFFF),
                      Row(
                        children: [
                          MarketIcon(iconName: 'USDT', width: 16.w),
                          4.w.horizontalSpace,
                          Text(
                              '${controller.applyInfo?.amount} ${controller.applyInfo?.coinSymbol}',
                              style: AppTextStyle.f_12_600.colorFFFFFF)
                        ],
                      ),
                    ],
                  )
                  // color: Colors.amber,
                  ),
            ),
          );
        }
    }
    return SizedBox();
  }

  Widget buildAction() {
    final controller = Get.find<CustomerApplyController>();

    if (controller.applyInfo?.otcStatus == OTCApplyStatus.verifySucces ||
        controller.applyInfo?.otcStatus == OTCApplyStatus.revoking) {
      return Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  height: 1,
                  margin: EdgeInsets.only(left: 100.w),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, AppColor.colorABABAB])))),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 43.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('otc/c2c/gradient_bg'.pngAssets()))),
                child: Row(
                  children: [
                    SizedBox(width: 29.w),
                    MyImage(
                      'otc/c2c/verify_emblem'.svgAssets(),
                      width: 24.r,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                        child: GradientText(
                      LocaleKeys.c2c84.tr,
                      style: AppTextStyle.f_14_600,
                      gradientDirection: GradientDirection.ltr,
                      colors: [AppColor.colorFFFFFF, AppColor.color999999],
                    ))
                  ],
                ),
              )),
          Container(
            height: 110.h,
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 16.h),
                controller.applyInfo?.otcStatus == OTCApplyStatus.revoking
                    ? Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.r)),
                            border: Border.all(color: AppColor.color60ffff)),
                        width: 327.w,
                        height: 48.h,
                        child: Text(LocaleKeys.c2c74.tr,
                            style: AppTextStyle.f_14_600.color7E7E7E),
                      )
                    : MyButton(
                        width: 327.w,
                        backgroundColor: AppColor.color111111,
                        color: AppColor.colorWhite,
                        border: Border.all(
                          color: AppColor.colorWhite,
                        ),
                        goIconColor: AppColor.colorWhite,
                        height: 44.w,
                        goIcon: true,
                        text: LocaleKeys.c2c85.tr,
                        onTap: () async {
                          controller.payDeposit(1);
                        },
                      )
              ],
            ),
          )
        ],
      );
    }
    ;

    Widget content() {
      if (controller.applyInfo?.otcStatus == OTCApplyStatus.verifying ||
          controller.applyInfo?.otcStatus == OTCApplyStatus.revoking) {
        return Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  border: Border.all(color: AppColor.color60ffff)),
              width: 327.w,
              height: 48.h,
              child: Text(LocaleKeys.c2c74.tr,
                  style: AppTextStyle.f_14_600.color7E7E7E),
            ));
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            color: AppColor.colorLineColor,
            height: 1,
          ),
          SizedBox(height: 16.h),
          MyButton(
            width: 327.w,
            backgroundColor: AppColor.colorWhite,
            color: AppColor.color111111,
            goIconColor: AppColor.color111111,
            height: 44.h,
            goIcon: true,
            text: controller.applyInfo?.otcStatus.title ??
                OTCApplyStatus.fillForm.title,
            onTap: () async {
              controller.performCase();
            },
          )
        ],
      );
    }

    return Container(
      height: 110.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          content()
          //  30.h.verticalSpace
        ],
      ),
    );
  }
}
