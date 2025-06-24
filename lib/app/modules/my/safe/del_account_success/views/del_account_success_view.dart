import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/my/safe/del_account_success/controllers/del_account_success_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class DelAccountSuccessView extends GetView<DelAccountSuccessController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DelAccountSuccessController>(builder: (controller) {
      return MySystemStateBar(
          color: SystemColor.black,
          child: Scaffold(
              bottomNavigationBar: Container(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w,
                    16.h + MediaQuery.of(context).viewPadding.bottom),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        height: 48.w,
                        text: LocaleKeys.public1.tr,
                        color: Colors.white,
                        goIcon: true,
                        backgroundColor: AppColor.color111111,
                        onTap: () async {
                          controller.onSubmit();
                        })
                  ],
                ),
              ),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage(
                      'my/del_account_success'.svgAssets(),
                      width: 84.w,
                      height: 84.w,
                    ),
                    25.verticalSpace,
                    Text(
                      LocaleKeys.user131.tr,
                      style: AppTextStyle.f_20_600,
                    ),
                  ],
                ),
              )));
    });
  }
}
