import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/login/login/controllers/login_controller.dart';
import 'package:nt_app_flutter/app/modules/login/login/widgets/more_login.dart';
import 'package:nt_app_flutter/app/modules/my/language_set/controllers/language_set_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/country_area_prefixIcon.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class LoginIndexView extends GetView<LoginIndexController> {
  const LoginIndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
        color: SystemColor.black,
        child: Scaffold(
          bottomNavigationBar: Container(
            height: 38.w + MediaQuery.of(context).padding.bottom,
            padding: EdgeInsets.fromLTRB(
                30.w, 0.w, 30.w, MediaQuery.of(context).padding.bottom),
            child: Align(
              child: RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  text: '${LocaleKeys.user5.tr} ',
                  style: TextStyle(
                      color: AppColor.color999999,
                      fontSize: 12.sp), //Color(0xff999999)
                  children: <TextSpan>[
                    const TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                        text: LocaleKeys.user88.tr,
                        style: TextStyle(
                          color: AppColor.color0075FF, //Color(0xff0075FF),
                          fontSize: 12.sp,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.WEBVIEW, arguments: {
                              'url': LinksGetx.to.privacyProtocal
                            });
                          }),
                    const TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                        text: LocaleKeys.user89.tr,
                        style: TextStyle(
                          color: AppColor.color0075FF,
                          fontSize: 12.sp,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.WEBVIEW, arguments: {
                              'url': LinksGetx.to.accountProtocol
                            });
                          }),
                    const TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                        text: LocaleKeys.user90.tr,
                        style: TextStyle(
                          color: AppColor.color0075FF,
                          fontSize: 12.sp,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(Routes.WEBVIEW, arguments: {
                              'url': LinksGetx.to.communityAgreement
                            });
                          }),
                  ],
                ),
              ),
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       padding: EdgeInsets.symmetric(vertical: 24.w),
            //       child: Row(
            //         children: [
            //           Expanded(
            //               child: Container(
            //             height: 1,
            //             color: AppColor.colorEEEEEE,
            //           )),
            //           Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 10.w),
            //             child: Text(
            //               'Or',
            //               style: TextStyle(
            //                   fontSize: 12.sp,
            //                   fontWeight: FontWeight.w600,
            //                   color: AppColor.color999999),
            //             ),
            //           ),
            //           Expanded(
            //               child: Container(
            //             height: 1,
            //             color: AppColor.colorEEEEEE,
            //           ))
            //         ],
            //       ),
            //     ),
            //     MyButton(
            //         width: 315.w,
            //         height: 48.w,
            //         text: LocaleKeys.user4.tr,
            //         backgroundColor: AppColor.colorWhite,
            //         color: AppColor.color111111,
            //         border: Border.all(color: AppColor.colorBlack),
            //         onTap: () async {
            //           Get.toNamed(Routes.LOGIN_REGISTERED,
            //               arguments: Get.arguments);
            //         }),
            //     SizedBox(
            //       height: 30.w,
            //     ),
            //     Expanded(
            //       child: RichText(
            //         overflow: TextOverflow.clip,
            //         text: TextSpan(
            //           text: '${LocaleKeys.user5.tr} ',
            //           style: TextStyle(
            //               color: AppColor.color999999,
            //               fontSize: 12.sp), //Color(0xff999999)
            //           children: <TextSpan>[
            //             const TextSpan(
            //               text: ' ',
            //             ),
            //             TextSpan(
            //                 text: '${LocaleKeys.user88.tr}',
            //                 style: TextStyle(
            //                   color: AppColor.color0075FF, //Color(0xff0075FF),
            //                   fontSize: 12.sp,
            //                   decoration: TextDecoration.underline,
            //                 ),
            //                 recognizer: TapGestureRecognizer()
            //                   ..onTap = () {
            //                     Get.toNamed(Routes.WEBVIEW, arguments: {
            //                       'url': LinksGetx.to.privacyProtocal
            //                     });
            //                   }),
            //             const TextSpan(
            //               text: ' ',
            //             ),
            //             TextSpan(
            //                 text: LocaleKeys.user89.tr,
            //                 style: TextStyle(
            //                   color: AppColor.color0075FF,
            //                   fontSize: 12.sp,
            //                   decoration: TextDecoration.underline,
            //                 ),
            //                 recognizer: TapGestureRecognizer()
            //                   ..onTap = () {
            //                     Get.toNamed(Routes.WEBVIEW, arguments: {
            //                       'url': LinksGetx.to.accountProtocol
            //                     });
            //                   }),
            //             const TextSpan(
            //               text: ' ',
            //             ),
            //             TextSpan(
            //                 text: LocaleKeys.user90.tr,
            //                 style: TextStyle(
            //                   color: AppColor.color0075FF,
            //                   fontSize: 12.sp,
            //                   decoration: TextDecoration.underline,
            //                 ),
            //                 recognizer: TapGestureRecognizer()
            //                   ..onTap = () {
            //                     Get.toNamed(Routes.WEBVIEW, arguments: {
            //                       'url': LinksGetx.to.communityAgreement
            //                     });
            //                   }),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 44.w,
                  padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(6.w, 8.w, 6.w, 8.w),
                          child: MyImage(
                            'default/close'.svgAssets(),
                            fit: BoxFit.fill,
                            width: 16.w,
                            height: 16.w,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () {
                          controller.setLanguage();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10.w, 0.w, 9.w, 0.w),
                          height: 32.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.w, color: AppColor.colorDDDDDD),
                              borderRadius: BorderRadius.circular(6)),
                          child: Obx(() {
                            return Row(
                              children: [
                                Text(
                                  LanguageSetController
                                      .to.currentLang.value.langName,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.color111111,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                MyImage(
                                  'default/arrow_bottom'.svgAssets(),
                                  width: 13.w,
                                )
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(top: 40.w),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              MyImage(
                                'logo'.pngAssets(),
                                width: 54.w,
                                radius: 14.r,
                              ),
                              40.verticalSpace,
                              Text(
                                LocaleKeys.user6.tr,
                                style: AppTextStyle.f_28_600,
                              ),
                              Container(
                                height: 33.w,
                              ),
                              Obx(() {
                                return MyTextFieldWidget(
                                  prefix: controller.isMobile.value
                                      ? const CountryAreaPrefixIconWidget()
                                      : null,
                                  controller: controller.accountControll,
                                  hintText: LocaleKeys.user7.tr,
                                  focusNode: controller.focusNode1,
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
                              SizedBox(
                                height: 20.w,
                              ),
                              Obx(() {
                                return MyTextFieldWidget(
                                  controller: controller.passwordControll,
                                  hintText: LocaleKeys.user8.tr,
                                  obscureText: !controller.passwordBool.value,
                                  focusNode: controller.focusNode2,
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
                                                'default/eyes_close'
                                                    .svgAssets(),
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
                              })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.w,
                        ),
                        MyButton(
                          width: 315.w,
                          height: 48.w,
                          text: LocaleKeys.public3.tr,
                          onTap: controller.onLogin,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        InkWell(
                          onTap: () async {
                            Get.toNamed(Routes.LOGIN_FORGOT);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 300.w,
                            child: Text(
                              LocaleKeys.user10.tr,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      AppColor.color333333), //Color(0xff333333)
                            ),
                          ),
                        ),
                        // const MoreLogin(),
                        30.verticalSpace,
                        _registerUser(),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  Widget _registerUser() {
    return RichText(
      text: TextSpan(
          text: LocaleKeys.user331.tr,
          style: AppTextStyle.f_14_400.color8E8E92,
          children: [
            const TextSpan(text: " "),
            WidgetSpan(
              child: InkWell(
                onTap: () async {
                  Get.toNamed(Routes.LOGIN_REGISTERED);
                },
                child: Text(
                  LocaleKeys.user332.tr,
                  style: TextStyle(
                    color: AppColor.colorAbnormal, //Color(0xff0075FF),
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
