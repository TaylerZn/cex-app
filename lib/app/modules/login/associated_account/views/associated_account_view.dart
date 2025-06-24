import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/login/associated_account/controllers/associated_account_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssociatedAccountView extends GetView<AssociatedAccountController> {
  const AssociatedAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    var res = Get.arguments;
    return Scaffold(
      appBar: AppBar(leading: const MyPageBackWidget(), elevation: 0),
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
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.w),
                child: Text(
                  LocaleKeys.user334.trArgs([controller.type.value]),
                  style: AppTextStyle.f_13_400.color8E8E92,
                ),
              ),
            ),
            Obx(
              () => Text(
                controller.type.value == "Telegram"
                    ? ""
                    : controller.data.value.accountMask(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppColor.colorAbnormal,
                ),
              ),
            ),
            24.verticalSpace,
            MyButton(
              height: 48.w,
              text: LocaleKeys.user335.tr,
              onTap: () {
                Get.toNamed(Routes.ASSOCIATED_HAS_ACCOUNT,
                    arguments: Get.arguments);
              },
            ),
            16.verticalSpace,
            MyButton(
              height: 48.w,
              text: LocaleKeys.user336.tr,
              color: AppColor.color111111,
              backgroundColor: AppColor.colorWhite,
              border: Border.all(width: 1.w, color: AppColor.colorECECEC),
              onTap: () {
                Get.toNamed(Routes.LOGIN_REGISTERED, arguments: Get.arguments);
              },
            ),
          ],
        ),
      ),
    );
  }
}
