import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/assistance/controllers/assistance_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/assistance/widget/first_assistance_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/assistance/widget/other_assistance_widget.dart';

import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/footer_widget.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssistanceDetailView extends StatefulWidget {
  final int type;
  final String title;
  const AssistanceDetailView({super.key, required this.title, required this.type});

  @override
  State<AssistanceDetailView> createState() => _AssistanceDetailViewState();
}

class _AssistanceDetailViewState extends State<AssistanceDetailView> {
  final controller = Get.find<AssistanceController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyPageBackWidget(),
      ),
      body: Column(
        children: [
          Expanded(
              child: widget.type == 0
                  ? FirstAssistanceWidget(controller: controller)
                  : OtherAssistanceWidget(title: widget.title, type: widget.type - 1)),
          SizedBox(
              height: 110.h,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          Container(height: 1, color: AppColor.colorEEEEEE),
                          16.w.verticalSpace,
                          Row(
                            children: [
                              controller.model?.status == 1
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Container(
                                          constraints: BoxConstraints(minHeight: 48.h),
                                          child: MyButton(
                                            text: LocaleKeys.c2c113.tr,
                                            textAlign: TextAlign.center,
                                            onTap: () {
                                              // showDialog(
                                              //   context: context,
                                              //   builder: (_) =>ComplainCountDownDialog(seconds: 100,));
                                              controller.complaintOrder();
                                            },
                                            backgroundColor: AppColor.colorWhite,
                                            border: Border.all(color: AppColor.color111111),
                                            color: AppColor.color111111,
                                            padding: EdgeInsets.symmetric(vertical: 3.h),
                                          ))),
                              (controller.model?.status == 1 ? 0 : 7).w.horizontalSpace,
                              Expanded(
                                  child: Container(
                                constraints: BoxConstraints(minHeight: 48.h),
                                child: MyButton(
                                    textAlign: TextAlign.center,
                                    text: LocaleKeys.c2c11.tr,
                                    color: AppColor.colorWhite,
                                    padding: EdgeInsets.symmetric(vertical: 3.h),
                                    onTap: () {
                                      Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.onlineServiceProtocal});
                                    }),
                              )),
                            ],
                          )
                        ],
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
