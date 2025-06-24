import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/open_contract_controller.dart';

class OpenContractView extends GetView<OpenContractController> {
  const OpenContractView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(LocaleKeys.trade243.tr,
                        style: AppTextStyle.f_24_600.color111111)
                    .marginOnly(bottom: 16.h),
                Text(LocaleKeys.trade244.tr,
                        style: AppTextStyle.f_14_400.color333333)
                    .marginOnly(bottom: 30.h),
                getView(),
                Text(LocaleKeys.trade248.tr,
                    style: AppTextStyle.f_14_400.color666666),
                Text(LocaleKeys.trade277.tr,
                    style: AppTextStyle.f_14_400.color666666),
                Text(LocaleKeys.trade249.tr,
                        style: AppTextStyle.f_14_400.color666666)
                    .paddingOnly(top: 10.h, bottom: 10.h),
                Text(LocaleKeys.trade250.tr,
                    style: AppTextStyle.f_14_400.color666666),
                SizedBox(height: 100.h)
              ],
            ),
          ),
        ),
        bottomNavigationBar: DecoratedBox(
          decoration: const BoxDecoration(color: AppColor.colorWhite),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.h, left: 24.w),
                child: Row(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          controller.isChecked.value =
                              !controller.isChecked.value;
                        },
                        child: Obx(() => Container(
                              padding: const EdgeInsets.only(right: 4),
                              child: MyImage(
                                'contract/${controller.isChecked.value ? 'market_select' : 'market_unSelect'}'
                                    .svgAssets(),
                              ),
                            ))),
                    Expanded(
                        child: Text(LocaleKeys.trade251.tr,
                            style: AppTextStyle.f_12_400.color333333)),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(16.w),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  height: 80.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.colorWhite,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColor.colorABABAB,
                                  width: 1,
                                ),
                              ),
                              height: 48.h,
                              child: Text(LocaleKeys.trade252.tr,
                                  style: AppTextStyle.f_16_600.color111111)),
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              if (controller.isChecked.value) {
                                Get.toNamed(Routes.OPEN_CONTRACT_ANSWER,
                                    arguments: {'model': controller.array});
                              }
                            },
                            child: Obx(() => Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: controller.isChecked.value
                                      ? AppColor.color111111
                                      : AppColor.colorCCCCCC,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                height: 48.h,
                                child: Text(LocaleKeys.trade253.tr,
                                    style: AppTextStyle.f_16_600.copyWith(
                                        color: controller.isChecked.value
                                            ? AppColor.colorWhite
                                            : AppColor.color111111))))),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  Widget getView() {
    var array = [
      LocaleKeys.trade245.tr,
      LocaleKeys.trade246.tr,
      LocaleKeys.trade247.tr
    ];
    List<Widget> viewArray = [];
    for (var i = 0; i < array.length; i++) {
      var w = GestureDetector(
        onTap: () {
          if (i == 0) {
            Get.toNamed(Routes.WEBVIEW,
                arguments: {'url': LinksGetx.to.futuresUseAgreement});
          } else if (i == 1) {
            Get.toNamed(Routes.WEBVIEW,
                arguments: {'url': LinksGetx.to.riskDisclosure});
          } else {
            Get.toNamed(Routes.WEBVIEW,
                arguments: {'url': LinksGetx.to.disclaimer});
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          padding: EdgeInsets.only(bottom: 16.w),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
            ),
          ),
          child: Row(
            children: <Widget>[
              Text(
                array[i],
                style: AppTextStyle.f_16_500.color4D4D4D,
              ),
              const Spacer(),
              MyImage(
                'default/go'.svgAssets(),
                height: 14.r,
                width: 14.r,
                color: AppColor.color4D4D4D,
              )
            ],
          ),
        ),
      );
      viewArray.add(w);
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(children: viewArray),
    );
  }
}
