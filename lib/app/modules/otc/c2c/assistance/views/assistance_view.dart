import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/assistance_controller.dart';
import 'assistance_detail_view.dart';

class AssistanceView extends GetView<AssistanceController> {
  AssistanceView({Key? key}) : super(key: key);
  final List<String> titles = [
    LocaleKeys.c2c109.tr,
    LocaleKeys.c2c110.tr,
    LocaleKeys.c2c111.tr,
    LocaleKeys.c2c112.tr
  ];

  @override
  Widget build(BuildContext context) {
    Widget buildContent(String title, int type) {
      return InkWell(
        onTap: () {
          checkDetail(type);
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(title, style: AppTextStyle.f_13_500.color666666)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: MyPageBackWidget(onTap: () {
          if (OtcConfigUtils().isHome) {
            Get.until((route) => Get.currentRoute == Routes.CUSTOMER_MAIN);
          } else {
            Get.back();
          }
        }),
        title: const Text('获取帮助'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.h.verticalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.r)),
                            border: Border.all(color: AppColor.colorEEEEEE)),
                        child: Column(
                          children: [
                            24.verticalSpace,
                            MyImage('otc/c2c/assitance_icon'.svgAssets()),
                            18.verticalSpace,
                            Text(LocaleKeys.c2c105.tr,
                                style: AppTextStyle.f_18_600,
                                textAlign: TextAlign.center),
                            4.verticalSpace,
                            Text(
                              LocaleKeys.c2c106.tr,
                              style: AppTextStyle.f_12_400.color666666,
                            ),
                            18.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyButton(
                                    text: LocaleKeys.c2c107.tr,
                                    onTap: () {
                                      Get.toNamed(Routes.C2C_CHAT,
                                          arguments: controller.model?.idNum
                                              .toString());
                                    },
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 10.w),
                                    textStyle: AppTextStyle.f_12_400)
                              ],
                            ),
                            18.verticalSpace,
                          ],
                        ),
                      ),
                      30.verticalSpace,
                      Text(LocaleKeys.c2c108.tr, style: AppTextStyle.f_15_500),
                      30.verticalSpace,
                      ...titles.map((e) => buildContent(e, titles.indexOf(e))),
                    ],
                  ),
                ),
              ],
            ),
          )),
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
                                          constraints:
                                              BoxConstraints(minHeight: 48.h),
                                          child: MyButton(
                                            text: LocaleKeys.c2c113.tr,
                                            textAlign: TextAlign.center,
                                            onTap: () {
                                              // showDialog(
                                              //   context: context,
                                              //   builder: (_) =>ComplainCountDownDialog(seconds: 100,));
                                              controller.complaintOrder();
                                            },
                                            backgroundColor:
                                                AppColor.colorWhite,
                                            border: Border.all(
                                                color: AppColor.color111111),
                                            color: AppColor.color111111,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3.h),
                                          ))),
                              (controller.model?.status == 1 ? 0 : 7)
                                  .w
                                  .horizontalSpace,
                              Expanded(
                                  child: Container(
                                constraints: BoxConstraints(minHeight: 48.h),
                                child: MyButton(
                                    textAlign: TextAlign.center,
                                    text: LocaleKeys.c2c11.tr,
                                    color: AppColor.colorWhite,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 3.h),
                                    onTap: () {
                                      Get.toNamed(Routes.WEBVIEW, arguments: {
                                        'url':
                                            LinksGetx.to.onlineServiceProtocal
                                      });
                                    }),
                              )),
                            ],
                          )
                        ],
                      ))
                ],
              ))
        ],
      ),
    );
  }

  void checkDetail(int type) {
    Navigator.push(
      Get.context!,
      MaterialPageRoute(
          builder: (context) => AssistanceDetailView(
                title: titles[type],
                type: type,
              )),
    );
  }
}
