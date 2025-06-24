import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/google_index_controller.dart';

class MySafeGoogleView extends GetView<MySafeGoogleController> {
  const MySafeGoogleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserGetx>(builder: (userGetx) {
      return GetBuilder<MySafeGoogleController>(builder: (controller) {
        return MySystemStateBar(
            child: Scaffold(
                appBar: AppBar(
                  leading: const MyPageBackWidget(),
                  centerTitle: true,
                  elevation: 0.0,
                ),
                bottomNavigationBar: userGetx.isGoogleVerify
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w,
                            16.h + MediaQuery.of(context).padding.bottom),
                        decoration: const BoxDecoration(
                            color: AppColor.colorWhite,
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: AppColor.colorECECEC))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyButton(
                                height: 48.w,
                                text: LocaleKeys.user152.tr,
                                goIcon: true,
                                onTap: () async {
                                  // Get.to(main_keyboard());
                                  Get.toNamed(Routes.MY_SAFE_GOOGLE_BIND)
                                      ?.then((value) => {controller.update()});
                                })
                          ],
                        ),
                      ),
                body: GestureDetector(
                  onTap: () {
                    // 触摸收起键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SingleChildScrollView(
                      child: Container(
                    padding: EdgeInsets.fromLTRB(24.w, 0.w, 24.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.w,
                        ),
                        Text(
                          LocaleKeys.user153.tr,
                          style: TextStyle(
                              fontSize: 24.sp, fontWeight: FontWeight.w600),
                        ),
                        userGetx.isGoogleVerify
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40.w,
                                  ),
                                  Container(
                                    height: 38.w,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              LocaleKeys.user154.tr,
                                              style: TextStyle(
                                                  height: 1,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )),
                                        Row(
                                          children: [
                                            InkWell(
                                                onTap: () async {
                                                  controller.delSubmit();
                                                },
                                                child: Container(
                                                    height: 38.w,
                                                    padding: EdgeInsets.only(
                                                        left: 10.w),
                                                    child: MyImage(
                                                      'my/safe_del'.svgAssets(),
                                                      width: 20.w,
                                                      height: 20.w,
                                                    )))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 55.w,
                                  ),
                                  Center(
                                    child: MyImage('my/google_bg'.svgAssets()),
                                  ),
                                  SizedBox(
                                    height: 40.w,
                                  ),
                                  Text(
                                    LocaleKeys.user155.tr,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.color999999),
                                  ),
                                ],
                              )
                      ],
                    ),
                  )),
                )));
      });
    });
  }
}
