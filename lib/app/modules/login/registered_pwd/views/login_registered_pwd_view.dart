import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import '../controllers/login_registered_pwd_controller.dart';

class LoginRegisteredPwdView extends GetView<LoginRegisteredPwdController> {
  const LoginRegisteredPwdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginRegisteredPwdController>(builder: (controller) {
      return MySystemStateBar(
        child: Scaffold(
          appBar: AppBar(leading: const MyPageBackWidget(), elevation: 0),
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30.w, 16.w, 30.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      LocaleKeys.user21.tr,
                      style: TextStyle(
                          height: 1,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    Text(
                      LocaleKeys.user22.tr,
                      style: TextStyle(
                          height: 1,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.colorABABAB),
                    ),

                    SizedBox(
                      height: 30.w,
                    ),

                    oncePs(), //密码输入
                    SizedBox(
                      height: 20.w,
                    ),
                    onceAgainPs(), //再次密码输入
                    SizedBox(
                      height: 20.w,
                    ),
                    inviteWidget(),
                    SizedBox(
                      height: 30.w,
                    ),
                    MyButton(
                      width: 315.w,
                      height: 48.w,
                      text: LocaleKeys.user28.tr,
                      onTap: () async {
                        controller.onSubmit();
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      );
    });
  }

  Widget oncePs() {
    return MyTextFieldWidget(
      controller: controller.passwordController,
      hintText: LocaleKeys.user29.tr,
      obscureText: !controller.passwordBool,
      inputFormatters: [],
      suffixIcon: controller.passwordController.text.isNotEmpty
          ? GestureDetector(
              //GestureDetector点击区域撑满
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 10.w,
                child: Align(
                    alignment: Alignment.center,
                    child: controller.passwordBool
                        ? MyImage(
                            'default/eyes_open'.svgAssets(),
                            width: 20.w,
                            color: AppColor.color4D4D4D,
                          )
                        : MyImage(
                            'default/eyes_close'.svgAssets(),
                            width: 20.w,
                            color: AppColor.color4D4D4D,
                          )),
              ),
              onTap: () {
                controller.passwordBool = !controller.passwordBool;
                controller.update();
              },
            )
          : Container(
              width: 10.w,
            ),
    );
  }

  Widget onceAgainPs() {
    return MyTextFieldWidget(
      controller: controller.againPasswordController,
      obscureText: !controller.againPasswordBool,
      hintText: LocaleKeys.user23.tr,
      inputFormatters: [],
      suffixIcon: controller.againPasswordController.text.isNotEmpty
          ? GestureDetector(
              //GestureDetector点击区域撑满
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 10.w,
                child: Align(
                    alignment: Alignment.center,
                    child: controller.againPasswordBool
                        ? MyImage(
                            'default/eyes_open'.svgAssets(),
                            width: 20.w,
                            color: AppColor.color4D4D4D,
                          )
                        : MyImage(
                            'default/eyes_close'.svgAssets(),
                            width: 20.w,
                            color: AppColor.color4D4D4D,
                          )),
              ),
              onTap: () {
                controller.againPasswordBool = !controller.againPasswordBool;
                controller.update();
              },
            )
          : Container(
              width: 10.w,
            ),
    );
  }

  Widget inviteWidget() {
    return MyTextFieldWidget(
      controller: controller.inviteController,
      hintText: LocaleKeys.user30.tr,
    );
  }
}
