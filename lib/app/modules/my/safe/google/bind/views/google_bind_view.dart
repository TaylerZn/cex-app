import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:screenshot/screenshot.dart';

import '../controllers/google_bind_controller.dart';

class MySafeGoogleBindView extends GetView<MySafeGoogleBindController> {
  const MySafeGoogleBindView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySafeGoogleBindController>(builder: (controller) {
      return MySystemStateBar(
          child: MyPageLoading(
              controller: controller.loadingController,
              body: Scaffold(
                  appBar: AppBar(
                    leading: const MyPageBackWidget(),
                    centerTitle: true,
                    elevation: 0.0,
                    title: Text(
                      LocaleKeys.user139.tr,
                    ),
                  ),
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w,
                        16.h + MediaQuery.of(context).padding.bottom),
                    decoration: const BoxDecoration(
                        color: AppColor.colorWhite,
                        border: Border(
                            top: BorderSide(
                                width: 1, color: AppColor.colorECECEC))),
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
                              if (controller.canNextPage()) {
                                controller.onSubmit();
                              }
                            })
                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16.w, 10.w, 16.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  '01',
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.user140.tr,
                                    style: TextStyle(
                                      color: AppColor.color666666,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  InkWell(
                                    child: Container(
                                        height: 50.w,
                                        padding: EdgeInsets.fromLTRB(
                                            16.w, 0, 16.w, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColor.colorF5F5F5,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                (controller.googleData
                                                            ?.googleKey ??
                                                        '')
                                                    .stringSplit(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 60.w,
                                            ),
                                            // assetsController
                                            //         .depositAddress
                                            //         .isEmpty
                                            //     ? SizedBox()
                                            //     :

                                            Text(
                                              LocaleKeys.public6.tr,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: AppColor.color0075FF),
                                            ),
                                          ],
                                        )),
                                    onTap: () {
                                      // if (assetsController
                                      //     .depositAddress.isEmpty) {
                                      //   return;
                                      // }
                                      CopyUtil.copyText(
                                          controller.googleData?.googleKey ??
                                              '');
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Container(
                                    width: 100.w,
                                    height: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppColor.colorF5F5F5,
                                    ),
                                    child: controller.bytes != null
                                        ? Screenshot(
                                            controller: controller.controller,
                                            child: Image.memory(
                                              controller.bytes as Uint8List,
                                            ),
                                          )
                                        : SizedBox(),
                                  )
                                ],
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  '02',
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.user141.tr,
                                    style: TextStyle(
                                      color: AppColor.color666666,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  MyImage(
                                    'my/google_bg_add'.svgAssets(),
                                    width: 116.w,
                                  )
                                ],
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  '03',
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                LocaleKeys.user142.tr,
                                style: TextStyle(
                                  color: AppColor.color666666,
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Container(
                            height: 50.w,
                            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColor.colorF5F5F5,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              LocaleKeys.user143.tr.stringSplit(),
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  '04',
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                LocaleKeys.user144.tr,
                                style: TextStyle(
                                  color: AppColor.color666666,
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          MyTextFieldWidget(
                            controller: controller.googleCode,
                            hintText: LocaleKeys.user145.tr,
                            title: LocaleKeys.user146.tr,
                            isTopText: false,
                            suffixIcon: InkWell(
                                onTap: () async {
                                  var res =
                                      await await CopyUtil.getText(amount: 6);
                                  controller.googleCode.text = res;
                                  controller.update();
                                },
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 70.w),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocaleKeys.public5.tr,
                                    style: TextStyle(
                                        color: AppColor.color0075FF,
                                        fontSize: 14.sp),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          MyTextFieldWidget(
                            controller: controller.loginPwd,
                            hintText: LocaleKeys.user147.tr,
                            title: LocaleKeys.user29.tr,
                            isTopText: false,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                        ],
                      ),
                    ),
                  ))));
    });
  }
}
