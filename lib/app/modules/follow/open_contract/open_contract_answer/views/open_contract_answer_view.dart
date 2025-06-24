import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/open_contract_answer_controller.dart';

class OpenContractAnswerView extends GetView<OpenContractAnswerController> {
  const OpenContractAnswerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (c) {
          return Scaffold(
              appBar: AppBar(
                leading: const MyPageBackWidget(),
                actions: [
                  IconButton(
                    onPressed: () {
                      controller.resetData();
                    },
                    icon: MyImage(
                      'my/apply_supertrade_refresh'.svgAssets(),
                      width: 18,
                    ),
                  )
                ],
              ),
              body: CustomScrollView(slivers: [
                SliverPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(LocaleKeys.trade254.tr,
                                  style: AppTextStyle.f_24_600.color111111)
                              .marginOnly(bottom: 16.h),
                          Text(LocaleKeys.trade255.tr,
                              style: AppTextStyle.f_14_400.color333333),
                          Text(LocaleKeys.trade278.tr,
                              style: AppTextStyle.f_14_400.color333333),
                          Text(LocaleKeys.trade279.tr,
                              style: AppTextStyle.f_14_400.color333333),
                          Text(LocaleKeys.trade280.tr,
                              style: AppTextStyle.f_14_400.color333333),
                        ],
                      ),
                    )),
                SliverList.builder(
                  itemCount: controller.array.length,
                  itemBuilder: (context, index) {
                    var model = controller.array[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.quiestionText,
                            style: AppTextStyle.f_16_500.color333333,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
                            decoration: ShapeDecoration(
                              color: AppColor.colorF5F5F5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: model.options!.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    model.selectIndex = e.i;
                                    controller.checkData();
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: Row(
                                      children: <Widget>[
                                        MyImage(
                                            (e.i == model.selectIndex
                                                    ? 'my/apply_supertrade_succse'
                                                    : 'my/apply_supertrade_unsel')
                                                .svgAssets(),
                                            height: 14.r,
                                            width: 14.r),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Text(
                                            e.optionText,
                                            style: AppTextStyle
                                                .f_12_400_15.color4D4D4D,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          model.showError
                              ? Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  padding: EdgeInsets.fromLTRB(
                                      16.w, 10.w, 16.w, 10.w),
                                  decoration: ShapeDecoration(
                                    color: const Color(0x19F6465D),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      MyImage(
                                          'my/apply_supertrade_error'
                                              .svgAssets(),
                                          height: 14.r,
                                          width: 14.r),
                                      SizedBox(width: 10.w),
                                      Text(
                                        LocaleKeys.trade261.tr,
                                        style: AppTextStyle.f_12_400.colorBlack,
                                      ),
                                    ],
                                  ))
                              : const SizedBox()
                        ],
                      ),
                    );
                  },
                )
              ]),
              bottomNavigationBar: DecoratedBox(
                decoration: const BoxDecoration(color: AppColor.colorWhite),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                                  onTap: () async {
                                    if (controller.isDone) {
                                      Get.dialog(
                                          transitionDuration:
                                              const Duration(milliseconds: 25),
                                          MyDialog(controller: controller));
                                    }
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: controller.isDone
                                            ? AppColor.color111111
                                            : AppColor.colorCCCCCC,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      height: 48.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(LocaleKeys.trade256.tr,
                                              style: AppTextStyle.f_16_600
                                                  .copyWith(
                                                      color: controller.isDone
                                                          ? AppColor.colorWhite
                                                          : AppColor
                                                              .color111111)),
                                          MyImage(
                                            'flow/follow_setup_arrow'
                                                .svgAssets(),
                                            height: 24.r,
                                            width: 24.r,
                                            color: AppColor.colorWhite,
                                          )
                                        ],
                                      ))),
                            ),
                          ],
                        )),
                  ],
                ),
              ));
        });
  }
}

class MyDialog extends StatelessWidget {
  const MyDialog({
    super.key,
    required this.controller,
  });
  final OpenContractAnswerController controller;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(32.w)),
              child: ClipOval(
                child: MyImage(
                  'assets/images/my/setting/kyc_ok.png',
                ),
              ),
            ),
            Text(LocaleKeys.trade257.tr,
                    style: AppTextStyle.f_16_500.color111111)
                .paddingSymmetric(vertical: 16.h),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
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
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: LocaleKeys.trade258.tr,
                              style: AppTextStyle.f_12_400.color333333),
                          TextSpan(
                              text: LocaleKeys.trade259.tr,
                              style: AppTextStyle.f_12_400.color0075FF,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(Routes.WEBVIEW, arguments: {
                                    'url': LinksGetx.to.futuresUseAgreement
                                  });
                                }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() => MyButton(
                      text: LocaleKeys.trade260.tr,
                      color: AppColor.colorWhite,
                      textStyle: AppTextStyle.f_14_500.colorWhite,
                      backgroundColor: controller.isChecked.value
                          ? AppColor.color111111
                          : AppColor.colorABABAB,
                      height: 40.h,
                      onTap: () {
                        if (controller.isChecked.value) {
                          controller.openContract();
                        }
                      })),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
