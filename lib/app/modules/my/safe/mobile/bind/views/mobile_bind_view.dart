import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/country_area_prefixIcon.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/mobile_bind_controller.dart';

class MySafeMobileBindView extends GetView<MySafeMobileBindController> {
  const MySafeMobileBindView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySafeMobileBindController>(builder: (controller) {
      return MySystemStateBar(
        child: Scaffold(
            appBar: AppBar(
              leading: const MyPageBackWidget(),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w,
                  16.h + MediaQuery.of(context).padding.bottom),
              decoration: const BoxDecoration(
                  color: AppColor.colorWhite,
                  border: Border(
                      top: BorderSide(width: 1, color: AppColor.colorECECEC))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                      height: 48.w,
                      text: LocaleKeys.public3.tr,
                      color: AppColor.colorWhite,
                      backgroundColor: controller.canNext()
                          ? AppColor.color111111
                          : AppColor.colorCCCCCC,
                      goIcon: true,
                      onTap: () async {
                        controller.onSubmit();
                      }),
                ],
              ),
            ),
            body: GetBuilder<AreaGetx>(builder: (areaGetx) {
              return Container(
                padding: EdgeInsets.all(24.w),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UserGetx.to.isSetMobile
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.w, horizontal: 16.w),
                            margin: EdgeInsets.only(bottom: 24.w),
                            decoration: BoxDecoration(
                                color: AppColor.colorDanger.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              children: [
                                MyImage(
                                  'default/alert'.svgAssets(),
                                  width: 12.w,
                                  height: 12.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Expanded(
                                    child: Text(
                                  LocaleKeys.user16.tr,
                                  style: AppTextStyle.f_12_400.colorDanger,
                                ))
                              ],
                            ),
                          )
                        : const SizedBox(),
                    Text(
                        UserGetx.to.isSetMobile
                            ? LocaleKeys.user167.tr
                            : LocaleKeys.user168.tr,
                        style: AppTextStyle.f_24_600),
                    33.verticalSpace,
                    MyTextFieldWidget(
                      prefix: controller.newPhone.text.isNotEmpty
                          ? const CountryAreaPrefixIconWidget()
                          : null,
                      controller: controller.newPhone,
                      hintText: LocaleKeys.user169.tr,
                      title: LocaleKeys.user170.tr,
                      isTopText: false,
                    ),
                  ],
                )),
              );
            })),
      );
    });
  }
}
