import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/country_area_prefixIcon.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/login_registered_controller.dart';

class LoginRegisteredView extends GetView<LoginRegisteredController> {
  const LoginRegisteredView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginRegisteredController>(builder: (controller) {
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
                      LocaleKeys.user25.tr,
                      style: AppTextStyle.f_24_600,
                    ),
                    10.verticalSpace,
                    Text(
                      LocaleKeys.user14.tr,
                      style: AppTextStyle.f_12_500.color999999,
                    ),
                    58.verticalSpace,
                    MyTextFieldWidget(
                      prefix: controller.isMobile
                          ? const CountryAreaPrefixIconWidget()
                          : null,
                      controller: controller.accountControll,
                      hintText: LocaleKeys.user7.tr,
                    ),
                    12.verticalSpace,
                    InkWell(
                        onTap: () {
                          controller.isSelected = !controller.isSelected;
                          controller.update();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.isSelected
                                ? MyImage(
                              'default/selected_success'.svgAssets(),
                              width: 14.w,
                              height: 14.w,
                            )
                                : Container(
                              width: 14.w,
                              height: 14.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99.r),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColor.colorEEEEEE)),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                    text: LocaleKeys.user254.tr,
                                    style: TextStyle(
                                        color: AppColor.color999999, fontSize: 12.sp),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: ' ',
                                      ),
                                      TextSpan(
                                          text: LocaleKeys.user88.tr,
                                          style: TextStyle(
                                            color: AppColor
                                                .color0075FF, //Color(0xff0075FF),
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
                                )),
                          ],
                        )),
                    16.verticalSpace,
                    MyButton(
                      width: 315.w,
                      height: 48.w,
                      text: LocaleKeys.public3.tr,
                      backgroundColor: controller.canNextPage()
                          ? null
                          : AppColor.colorCCCCCC,
                      onTap: () async {
                        controller.submitOntap(context);
                      },
                    ),
                    SizedBox(height: 12.w),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 28.w),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 1,
                            color: Color(0xffEEEEEE),
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              'Or',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff999999)),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            height: 1,
                            color: Color(0xffEEEEEE),
                          ))
                        ],
                      ),
                    ),
                    Center(
                      child: RichText(
                        overflow: TextOverflow.clip,
                        text: TextSpan(
                          text: '${LocaleKeys.user26.tr} ',
                          style: TextStyle(
                              color: AppColor.color111111, fontSize: 12.sp),
                          children: <TextSpan>[
                            TextSpan(
                                text: LocaleKeys.user27.tr,
                                style: TextStyle(
                                  color: AppColor.color0075FF,
                                  fontSize: 12.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.back();
                                  }),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    });
  }
}
