import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/my/safe/del_account/controllers/del_account_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class DelAccountView extends GetView<DelAccountController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DelAccountController>(builder: (controller) {
      return MySystemStateBar(
          color: SystemColor.black,
          child: Scaffold(
            appBar: AppBar(
                leading: MyPageBackWidget(
                  onTap: () {
                    if (controller.pageIndex == 0) {
                      Get.back();
                    } else {
                      controller.pageIndex--;
                      controller.childPageController
                          .jumpToPage(controller.pageIndex);
                      controller.update();
                    }
                  },
                ),
                elevation: 0),
            bottomNavigationBar: Container(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w,
                  16.h + MediaQuery.of(context).viewPadding.bottom),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColor.colorEEEEEE)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  16.verticalSpace,
                  MyButton(
                      height: 48.w,
                      text: LocaleKeys.public3.tr,
                      color: AppColor.colorWhite,
                      goIcon: true,
                      backgroundColor:
                          controller.pageIndex == 3 && !controller.isSelected
                              ? AppColor.colorCCCCCC
                              : AppColor.color111111,
                      onTap: () async {
                        if (controller.pageIndex == 3) {
                          controller.onSubmit();
                        } else {
                          controller.pageIndex++;
                          controller.childPageController
                              .jumpToPage(controller.pageIndex);
                        }
                        controller.update();
                      })
                ],
              ),
            ),
            body: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: PageView(
                      physics: NeverScrollableScrollPhysics(), // 禁止手势滑动
                      controller: controller.childPageController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.user122.tr,
                                style: AppTextStyle.f_24_600,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text(
                                LocaleKeys.user123.tr,
                                style: AppTextStyle.f_14_400.color4D4D4D,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.user122.tr,
                              style: AppTextStyle.f_24_600,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            WaterfallFlow.builder(
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                itemCount: controller.reasonList.length,
                                gridDelegate:
                                    SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 0.w,
                                  mainAxisSpacing: 16.h,
                                ),
                                itemBuilder: (context, i) {
                                  var item = controller.reasonList[i];
                                  return InkWell(
                                    onTap: (() async {
                                      controller.reasonIndex = i;
                                      controller.update();
                                    }),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 44.w,
                                      decoration: BoxDecoration(
                                          color: AppColor.colorF5F5F5,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            '$item',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppColor
                                                    .color111111), //Color(0xff4d4d4d)
                                          )),
                                          SizedBox(
                                            width: 16.w,
                                          ),
                                          i == controller.reasonIndex
                                              ? MyImage(
                                                  'default/selected_success'
                                                      .svgAssets(),
                                                  width: 14.w,
                                                  height: 14.w,
                                                )
                                              : Container(
                                                  width: 14.w,
                                                  height: 14.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              99),
                                                      border: Border.all(
                                                          width: 1.6.w,
                                                          color: AppColor
                                                              .colorBBBBBB)),
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        )),
                        SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.user124.tr,
                              style: AppTextStyle.f_24_600,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text.rich(
                              TextSpan(
                                text: LocaleKeys.user125.tr,
                                style: AppTextStyle.f_14_400.color4D4D4D,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: LocaleKeys.user126.tr,
                                    style: AppTextStyle.f_14_400.color0075FF,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // 在此处理点击事件
                                        Get.toNamed(Routes.WEBVIEW, arguments: {
                                          'url':
                                              LinksGetx.to.onlineServiceProtocal
                                        });
                                      },
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.user127.tr,
                                    style: AppTextStyle.f_14_400.color4D4D4D,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.user128.tr,
                                  style: AppTextStyle.f_24_600,
                                ),
                                30.verticalSpace,
                                Text(
                                  LocaleKeys.user129.tr,
                                  style: AppTextStyle.f_14_400,
                                ),
                                Expanded(child: GetBuilder<AssetsGetx>(
                                    builder: (controller) {
                                  return
                                      // SliverList.builder(
                                      //   itemCount: controller.searchList.length,
                                      //   itemBuilder: (context, index) {
                                      //     var item = controller.searchList[index];
                                      //     return

                                      controller
                                              .assetSpotsBalanceList.isNotEmpty
                                          ? WaterfallFlow.builder(
                                              padding:
                                                  EdgeInsets.only(top: 16.h),
                                              shrinkWrap: true,
                                              addAutomaticKeepAlives: false,
                                              addRepaintBoundaries: false,
                                              gridDelegate:
                                                  SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                crossAxisSpacing: 0.w,
                                                mainAxisSpacing: 20.h,
                                              ),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: controller
                                                  .assetSpotsBalanceList.length,
                                              itemBuilder: (context, index) {
                                                var item = controller
                                                        .assetSpotsBalanceList[
                                                    index];
                                                return Row(
                                                  children: [
                                                    MyImage(
                                                      item.icon ?? '',
                                                      width: 40.w,
                                                      height: 40.w,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Expanded(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              item.coinName ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                color: AppColor
                                                                    .color111111,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8.w,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                NumberUtil
                                                                    .mConvert(
                                                                  item.allBalance,
                                                                  isEyeHide:
                                                                      true,
                                                                ),
                                                                style:
                                                                    const TextStyle(
                                                                  color: AppColor
                                                                      .color111111,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 4.h,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              item.exchangeSymbol ??
                                                                  '',
                                                              style: TextStyle(
                                                                color: AppColor
                                                                    .color999999,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                NumberUtil.mConvert(
                                                                    item
                                                                        .usdtValuatin,
                                                                    isEyeHide:
                                                                        true,
                                                                    isRate:
                                                                        IsRateEnum
                                                                            .usdt),
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColor
                                                                      .color999999,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )),
                                                  ],
                                                );
                                              },
                                            )
                                          : Center(
                                              child: Column(
                                              children: [
                                                100.verticalSpace,
                                                SizedBox(
                                                  width: 163.w,
                                                  height: 112.w,
                                                  child: MyImage(
                                                    'assets/images/assets/overview_no_asset.png',
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                                Text(LocaleKeys.assets60.tr,
                                                    style: AppTextStyle
                                                        .f_12_400.color999999),
                                              ],
                                            ));
                                }))
                              ],
                            )),
                            InkWell(
                                onTap: () {
                                  controller.isSelected =
                                      !controller.isSelected;
                                  controller.update();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 16.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      controller.isSelected
                                          ? MyImage(
                                              'default/selected_success'
                                                  .svgAssets(),
                                              width: 14.w,
                                              height: 14.w,
                                            )
                                          : Container(
                                              width: 14.w,
                                              height: 14.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          99.r),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColor
                                                          .colorABABAB)),
                                            ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        LocaleKeys.user130.tr,
                                        style: AppTextStyle.f_12_400,
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    )),
                  ],
                )),
          ));
    });
  }
}
