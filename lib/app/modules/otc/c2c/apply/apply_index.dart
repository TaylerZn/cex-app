import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/extension.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/widget/apply_stage_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'controllers/customer_apply_controller.dart';

class ApplyIndexView extends StatefulWidget {
  const ApplyIndexView({super.key});

  @override
  State<ApplyIndexView> createState() => _ApplyIndexViewState();
}

class _ApplyIndexViewState extends State<ApplyIndexView> {
  final controller = Get.find<CustomerApplyController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerApplyController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const MyPageBackWidget(backColor: Colors.white),
          centerTitle: true,
        ),
        backgroundColor: AppColor.color111111,
        body: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          // color: AppColor.color111111,
          child: Stack(
            children: [
              SizedBox(height: 15.h),
              Container(
                  height: 125.h,
                  color: AppColor.color111111,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SizedBox(
                      width: double.infinity,
                      height: 100.h,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 3.h,
                              child: SizedBox(
                                width: 200.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(LocaleKeys.c2c66.tr,
                                        style:
                                            AppTextStyle.f_24_600.colorFFFFFF),
                                    SizedBox(height: 4.h),
                                    Text(LocaleKeys.c2c67.tr,
                                        style: AppTextStyle.f_14_400.colorTips)
                                  ],
                                ),
                              )),
                          Positioned(
                              right: 0,
                              child: MyImage('otc/c2c/apply_icon'.pngAssets(),
                                  width: 126.w, height: 121.h))
                        ],
                      ))),
              Positioned(
                  top: 40.h,
                  child: Image.asset(
                      width: ScreenUtil().screenWidth,
                      height: 300.h,
                      fit: BoxFit.fitHeight,
                      'otc/c2c/top_gradient'.pngAssets())),
              Positioned(
                  bottom: 0,
                  top: 165.h,
                  child: Stack(
                    children: [
                      Container(
                          width: ScreenUtil().screenWidth,
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    child: Column(
                                      children: [
                                        buildInfoList(),
                                        SizedBox(height: 16.h),
                                        ApplyStageWidget(
                                            selectedIndex:
                                                controller.applyStage),
                                        24.h.verticalSpace,
                                        widget.buildBottomContent(),
                                      ],
                                    )),
                                20.h.verticalSpace,
                                // Expanded(child: SizedBox()),
                                widget.buildAction()
                              ],
                            ),
                          ))
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }

  Widget buildInfoList() {
    Widget buildInfoContent(String content) {
      return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
          children: [
            MyImage(
              'default/selected_success'.svgAssets(),
              width: 14.w,
              height: 14.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Text(
              content,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.colorWhite), //Color(0xff4d4d4d)
            )),
          ],
        ),
      );
    }

    ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          buildInfoContent(LocaleKeys.c2c68.tr),
          SizedBox(height: 16.h),
          buildInfoContent(LocaleKeys.c2c69.tr),
          SizedBox(height: 16.h),
          buildInfoContent(LocaleKeys.c2c70.tr),
          SizedBox(height: 16.h),
          buildInfoContent(LocaleKeys.c2c71.tr),
        ])),
        SizedBox(height: 30.h),
        Container(height: 1, width: 327.h, color: Color(0xff242424)),
        SizedBox(height: 30.h),
        Text(LocaleKeys.c2c79.tr, style: AppTextStyle.f_14_600.colorFFFFFF)
      ],
    );
  }
}
