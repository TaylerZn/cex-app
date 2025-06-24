import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/components/country_area_prefixIcon.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/associated_has_account_controller.dart';

class AssociatedHasAccountView extends GetView<AssociatedHasAccountController> {
  const AssociatedHasAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        elevation: 0,
        toolbarHeight: 44.w,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            Text(
              LocaleKeys.user333.tr,
              style: AppTextStyle.f_28_600,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.w),
              child: Text(
                LocaleKeys.user337.tr,
                style: AppTextStyle.f_13_400.color8E8E92,
              ),
            ),
            54.verticalSpace,
            Obx(() {
              return MyTextFieldWidget(
                height: 48.w,
                prefix: controller.isMobile.value
                    ? const CountryAreaPrefixIconWidget()
                    : null,
                controller: controller.accountControll,
                hintText: LocaleKeys.user7.tr,
                focusNode: controller.focusNode1,
                backGroundColor: AppColor.colorF4F6F8,
                enabledBorderColor: AppColor.colorF4F6F8,
                onTap: () {
                  if (controller.focusNode2.hasFocus) {
                    controller.focusNode2.unfocus();
                  }
                  Future.delayed(50.milliseconds, () {
                    controller.focusNode1.requestFocus();
                  });
                },
              );
            }),
            12.verticalSpace,
            Obx(() {
              return MyTextFieldWidget(
                height: 48.w,
                controller: controller.passwordControll,
                hintText: LocaleKeys.user8.tr,
                obscureText: !controller.passwordBool.value,
                focusNode: controller.focusNode2,
                backGroundColor: AppColor.colorF4F6F8,
                enabledBorderColor: AppColor.colorF4F6F8,
                onTap: () {
                  if (controller.focusNode1.hasFocus) {
                    controller.focusNode1.unfocus();
                  }
                  Future.delayed(50.milliseconds, () {
                    controller.focusNode2.requestFocus();
                  });
                },
                suffixIcon: GestureDetector(
                  //GestureDetector点击区域撑满
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      controller.passwordBool.value
                          ? MyImage(
                              'default/eyes_open'.svgAssets(),
                              width: 24.w,
                              color: AppColor.color4D4D4D,
                            )
                          : MyImage(
                              'default/eyes_close'.svgAssets(),
                              width: 24.w,
                              color: AppColor.color4D4D4D,
                            ),
                      13.horizontalSpace
                    ],
                  ),
                  onTap: () {
                    controller.passwordBool.toggle();
                  },
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.only(top: 16.w, bottom: 30.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      Get.toNamed(Routes.LOGIN_FORGOT);
                    },
                    child: Text(
                      LocaleKeys.user10.tr,
                      style: AppTextStyle.f_12_400.color666666,
                    ),
                  ),
                ],
              ),
            ),
            MyButton(
              height: 48.w,
              text: LocaleKeys.public3.tr,
              onTap: () {
                controller.loginAndBinding();
              },
            ),
          ],
        ),
      ),
    );
  }
}
