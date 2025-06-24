import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/Apply_supertrader_states/controllers/apply_supertrader_states_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class ApplySupertradeStatesBottomButton extends StatelessWidget {
  const ApplySupertradeStatesBottomButton(
      {super.key, required this.controller});
  final ApplySupertraderStatesController controller;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: controller.states == null
            ? const SizedBox()
            : controller.states! < 0
                ? DecoratedBox(
                    decoration: const BoxDecoration(color: Color(0xFF0B0C0F)),
                    child: GestureDetector(
                      onTap: () {
                        if (controller.isSuccess && controller.states == -1) {
                          controller.tradeApply();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 16.h,
                            bottom:
                                16.h + MediaQuery.of(context).padding.bottom,
                            right: 24.w,
                            left: 24.w),
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        height: 48.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: controller.states == -1
                                ? (controller.isSuccess
                                    ? AppColor.colorWhite
                                    : const Color(0XFF222222))
                                : const Color(0XFF222222)),
                        alignment: Alignment.center,
                        child: controller.states == -1
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    controller.states == -1
                                        ? LocaleKeys.follow288.tr
                                        : LocaleKeys.follow289.tr,
                                    style: AppTextStyle.f_16_500.copyWith(
                                        color: controller.states == -1
                                            ? (controller.isSuccess
                                                ? AppColor.color111111
                                                : AppColor.colorWhite)
                                            : AppColor.colorWhite),
                                  ),
                                  MyImage('flow/follow_setup_arrow'.svgAssets(),
                                      height: 24.r,
                                      width: 24.r,
                                      color: controller.isSuccess
                                          ? AppColor.color111111
                                          : AppColor.colorWhite),
                                ],
                              )
                            : Text(
                                LocaleKeys.follow289.tr,
                                style: AppTextStyle.f_16_500
                                    .copyWith(color: AppColor.colorWhite),
                              ),
                      ),
                    ),
                  )
                : DecoratedBox(
                    decoration: const BoxDecoration(color: Color(0xFF0B0C0F)),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 16.h,
                          bottom: 16.h + MediaQuery.of(context).padding.bottom,
                          right: 24.w,
                          left: 24.w),
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      height: 48.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0XFF222222)),
                      alignment: Alignment.center,
                      child: Text(
                        controller.btnStr,
                        style: AppTextStyle.f_16_500.colorWhite,
                      ),
                    ),
                  ));
  }
}
