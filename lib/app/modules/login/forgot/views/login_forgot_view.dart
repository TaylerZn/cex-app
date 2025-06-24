import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/country_area_prefixIcon.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/login_forgot_controller.dart';

class LoginForgotView extends GetView<LoginForgotController> {
  const LoginForgotView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginForgotController>(builder: (controller) {
      return MySystemStateBar(
          child: Scaffold(
              appBar: AppBar(leading: const MyPageBackWidget(), elevation: 0),
              bottomNavigationBar: Container(
                  padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w,
                      16.w + MediaQuery.of(context).padding.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyButton(
                        height: 48.w,
                        text: LocaleKeys.public3.tr,
                        goIcon: true,
                        backgroundColor: controller.canNextPage()
                            ? null
                            : AppColor.colorCCCCCC,
                        onTap: () async {
                          controller.submitOntap(context);
                        },
                      ),
                    ],
                  )),
              body: GetBuilder<AreaGetx>(builder: (areaGetx) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              LocaleKeys.user15.tr,
                              style: AppTextStyle.f_24_600,
                            ),
                            4.verticalSpace,
                            Text(
                              LocaleKeys.user16.tr,
                              style: AppTextStyle.f_11_400.color999999,
                            ),
                            SizedBox(
                              height: 40.w,
                            ),
                            MyTextFieldWidget(
                                prefix: controller.isMobile
                                    ? const CountryAreaPrefixIconWidget()
                                    : null,
                                controller: controller.accountControll,
                                hintText: LocaleKeys.user7.tr,
                                title: LocaleKeys.user17.tr,
                                isTopText: false),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })));
    });
  }

  resetSuccessWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20.w,
        ),
        MyImage(
          'default/selected_success'.svgAssets(),
          width: 64.w,
        ),
        SizedBox(
          height: 20.w,
        ),
        Text(
          '密码重置成功',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff111111)),
        ),
        SizedBox(
          height: 40.w,
        ),
        MyButton(
          text: LocaleKeys.public1.tr,
          height: 48.w,
          goIcon: true,
          backgroundColor: Color(0xff111111),
          color: Colors.white,
          onTap: () {
            Get.back();
            Get.back();
          },
        )
      ],
    );
  }
}
