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
import '../controllers/pwd_change_controller.dart';

class MySafePwdChangeView extends GetView<MySafePwdChangeController> {
  const MySafePwdChangeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySafePwdChangeController>(builder: (controller) {
      return MySystemStateBar(
        child: Scaffold(
          appBar: AppBar(leading: const MyPageBackWidget(), elevation: 0),
          bottomNavigationBar: Container(
              padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w,
                  16.h + MediaQuery.of(context).padding.bottom),
              decoration: const BoxDecoration(
                  color: AppColor.colorWhite,
                  border: Border(
                      top: BorderSide(width: 1, color: AppColor.colorECECEC))),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                MyButton(
                  width: 315.w,
                  height: 48.w,
                  text: LocaleKeys.public3.tr,
                  goIcon: true,
                  onTap: () async {
                    controller.onSubmit();
                  },
                )
              ])),
          body: Container(
            padding: EdgeInsets.all(24.w),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  LocaleKeys.user258.tr,
                  style: TextStyle(
                      height: 1, fontSize: 30.sp, fontWeight: FontWeight.w600),
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
                oldPwdWidget(),
                SizedBox(
                  height: 30.w,
                ),
                oncePs(), //密码输入
                SizedBox(
                  height: 30.w,
                ),
                onceAgainPs(), //再次密码输入
                SizedBox(
                  height: 30.w,
                ),
              ],
            )),
          ),
        ),
      );
    });
  }

  Widget oldPwdWidget() {
    return MyTextFieldWidget(
      controller: controller.oldPasswordController,
      title: LocaleKeys.user176.tr,
      hintText: LocaleKeys.user177.tr,
      isTopText: false,
      obscureText: !controller.oldPasswordBool,
      inputFormatters: [],
      suffixIcon: controller.oldPasswordController.text.isNotEmpty
          ? GestureDetector(
              //GestureDetector点击区域撑满
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 10.w,
                child: Align(
                    alignment: Alignment.center,
                    child: controller.oldPasswordBool
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
                controller.oldPasswordBool = !controller.oldPasswordBool;
                controller.update();
              },
            )
          : Container(
              width: 10.w,
            ),
    );
  }

  Widget oncePs() {
    return MyTextFieldWidget(
      controller: controller.passwordController,
      title: LocaleKeys.user178.tr,
      hintText: LocaleKeys.user179.tr,
      isTopText: false,
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
      title: LocaleKeys.user180.tr,
      hintText: LocaleKeys.user181.tr,
      isTopText: false,
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
}
