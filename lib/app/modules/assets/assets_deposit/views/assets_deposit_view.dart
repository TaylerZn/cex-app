import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_deposit/controllers/assets_deposit_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_network_select.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_dialog.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:screenshot/screenshot.dart';

class AssetsDepositView extends GetView<AssetsDepositController> {
  const AssetsDepositView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put(AssetsDepositController());
    return GetBuilder<AssetsDepositController>(builder: (controller) {
      return MySystemStateBar(
          child: Scaffold(
              appBar: AppBar(
                leading: const MyPageBackWidget(),
                centerTitle: true,
                elevation: 0.0,
                title: Text(
                  LocaleKeys.assets35.tr,
                ),
                actions: [
                  InkWell(
                      onTap: () {
                        Get.toNamed(Routes.WALLET_HISTORY);
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        alignment: Alignment.center,
                        child: Text(
                          LocaleKeys.assets36.tr,
                          style: AppTextStyle.f_14_500.color666666,
                        ),
                      ))
                ],
              ),
              bottomNavigationBar: controller.loadingController.isSuccess
                  ? Container(
                      height: 80.w + MediaQuery.of(context).padding.bottom,
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w,
                          16.h + MediaQuery.of(context).padding.bottom),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                              height: 48.w,
                              text: LocaleKeys.assets37.tr,
                              color: AppColor.colorWhite,
                              backgroundColor: AppColor.color111111,
                              onTap: () async {
                                Get.dialog(
                                  MyShareView(
                                    content: depositShareWidget(context),
                                  ),
                                  useSafeArea: false,
                                  barrierDismissible: true,
                                );
                              })
                        ],
                      ),
                    )
                  : const SizedBox(),
              body: MyPageLoading(
                  controller: controller.loadingController,
                  body: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 32.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.assets38.tr,
                                    style: AppTextStyle.f_14_500.color999999,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 6.h, 0, 12.h),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color:
                                                        AppColor.colorEEEEEE))),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                controller.address ?? '',
                                                style: TextStyle(
                                                  height: 1.4,
                                                  fontWeight: FontWeight.w700,
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
                                            MyImage(
                                              'default/copy'.svgAssets(),
                                              width: 16.w,
                                            )
                                          ],
                                        )),
                                    onTap: () {
                                      // if (assetsController
                                      //     .depositAddress.isEmpty) {
                                      //   return;
                                      // }
                                      CopyUtil.copyText(
                                          controller.address ?? '');
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: AppColor.colorWhite,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              LocaleKeys.assets39.tr, //选择充值网络
                                              style: AppTextStyle
                                                  .f_14_500.color999999,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                controller.isDialogShown.value =
                                                    true;
                                                var res =
                                                    await showMyBottomDialog(
                                                        context,
                                                        AssetsNetworkSelect(
                                                          list: controller
                                                              .networkList,
                                                          value: controller
                                                              .networkValue,
                                                          isDeposit: true,
                                                        ));
                                                controller.isDialogShown.value =
                                                    false;
                                                if (res != null) {
                                                  EasyLoading.show();
                                                  controller.networkIndex = res;
                                                  await controller
                                                      .getChargeAddress();
                                                  EasyLoading.dismiss();
                                                  controller.update();
                                                }
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 6.h, 0, 12.h),
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .colorEEEEEE))),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      controller.networkValue,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16.sp,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const Expanded(
                                                      child: SizedBox(),
                                                    ),
                                                    Obx(() {
                                                      return MyImage(
                                                        width: 16.w,
                                                        height: 16.h,
                                                        !controller
                                                                .isDialogShown //TODO: 待处理图片改变的时机
                                                                .value
                                                            ? 'default/arrow_bottom'
                                                                .svgAssets()
                                                            : 'default/arrow_top'
                                                                .svgAssets(),
                                                        color: AppColor
                                                            .colorA3A3A3,
                                                      );
                                                    })
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  LocaleKeys.assets146.tr,
                                                  style: AppTextStyle
                                                      .f_14_500.color999999,
                                                ),
                                                Text(
                                                  '${controller.depositMinStr} ${controller.currency}', //最小充币额
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColor.color111111),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 17.h,
                                            ),
                                          ])),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(16.w),
                                      decoration: BoxDecoration(
                                          color: AppColor.colorWhite,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 180.w,
                                                height: 180.w,
                                                padding: EdgeInsets.all(0.0),
                                                // 设置padding为0
                                                alignment: Alignment.center,
                                                // 居中显示
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: AppColor.colorWhite,
                                                    border: Border.all(
                                                        width: 1.6.w,
                                                        color: AppColor
                                                            .colorF2F2F2)),
                                                child: Screenshot(
                                                  controller:
                                                      controller.controller,
                                                  child:
                                                      controller.bytes != null
                                                          ? Image.memory(
                                                              controller.bytes
                                                                  as Uint8List,
                                                              fit: BoxFit
                                                                  .fill, // 填充模式，根据需要调整
                                                            )
                                                          : SizedBox(),
                                                )),
                                            SizedBox(
                                              height: 16.w,
                                            ),
                                            Container(
                                              width: 216.w,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${LocaleKeys.assets40.tr}${controller.currency}_${controller.networkValue}${LocaleKeys.assets41.tr}',
                                                style: AppTextStyle
                                                    .f_12_400.colorE64F44,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ])),
                                ],
                              ),
                            ])),
                  ))));
    });
  }

  depositShareWidget(context) {
    return Container(
        width: 337.w,
        padding: EdgeInsets.all(24.w),
        color: AppColor.colorWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${LocaleKeys.assets42.tr} ${controller.currency}',
              style: AppTextStyle.f_16_500,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.bytes != null
                    ? Image.memory(
                        controller.bytes as Uint8List,
                      )
                    : const SizedBox(),
              ],
            ),
            Text(
              LocaleKeys.assets43.tr,
              style: AppTextStyle.f_12_500.color999999,
            ),
            4.verticalSpace,
            Text(
              controller.address ?? '',
              style: AppTextStyle.f_14_600,
            ),
            16.verticalSpace,
            Text(
              LocaleKeys.assets44.tr,
              style: AppTextStyle.f_12_500.color999999,
            ),
            4.verticalSpace,
            Text(
              controller.networkValue,
              style: AppTextStyle.f_14_600,
            ),
          ],
        ));
  }
}
