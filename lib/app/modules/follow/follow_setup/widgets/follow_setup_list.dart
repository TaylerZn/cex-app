import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_search_textField.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/controllers/follow_setup_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_setup_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_setup_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/widgets/follow_setup_top.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:styled_text/tags/styled_text_tag_action.dart';
import 'package:styled_text/widgets/styled_text.dart';

//

class FollowSetupListView extends StatelessWidget {
  const FollowSetupListView({super.key, required this.controller});
  final FollowSetupController controller;
  @override
  Widget build(BuildContext context) {
    return controller.isSmart
        ? getSmartFollow(controller, controller.trader)
        :
        // Stack(children: [
        NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: controller.isGuide
                        ? const SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 22.h),
                            child: FollowSetupTop(
                              trader: controller.trader,
                              currentPosition: true,
                              controller: controller,
                            ))),
                SliverToBoxAdapter(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AppGuideView(
                    order: 3,
                    guideType: AppGuideType.follow,
                    child: Column(
                      children: [
                        Container(
                          child: controller.isEdit
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 26.h,
                                          child: Text(LocaleKeys.follow69.tr, style: AppTextStyle.f_15_500.color111111)
                                              .marginOnly(right: 4.w),
                                        ),
                                        GestureDetector(
                                            onTap: () async {
                                              Get.dialog(
                                                  transitionDuration: const Duration(milliseconds: 25),
                                                  const MyDialog(
                                                    showTime: true,
                                                  ));
                                            },
                                            child: SizedBox(
                                              width: 13.w,
                                              height: 13.w,
                                              child: MyImage(
                                                'flow/follow_setup_tip'.svgAssets(),
                                              ),
                                            ))
                                      ],
                                    ),
                                    Obx(() => FollowSetupTabbar(
                                          dataArray: controller.fillterTimeTabs.map((e) => e.value).toList(),
                                          currentIndex: controller.timeIndex.value,
                                          callBack: (index) {
                                            controller.timeIndex.value = index;
                                          },
                                        )),
                                  ],
                                ),
                        ),
                        Container(
                          // color: Colors.amber,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 26.h,
                                      child: Text(LocaleKeys.follow70.tr, style: AppTextStyle.f_15_500.color111111)
                                          .marginOnly(right: 4.w)),
                                  GestureDetector(
                                      onTap: () async {
                                        Get.dialog(
                                            transitionDuration: const Duration(milliseconds: 25),
                                            const MyDialog(
                                              showTime: false,
                                            ));
                                      },
                                      child: SizedBox(
                                        width: 13.w,
                                        height: 13.w,
                                        child: MyImage(
                                          'flow/follow_setup_tip'.svgAssets(),
                                        ),
                                      ))
                                ],
                              ),
                              Obx(() => FollowSetupTabbar(
                                    dataArray: controller.fillterTabs.map((e) => e.type.value).toList(),
                                    currentIndex: controller.currentIndex.value,
                                    callBack: (index) {
                                      controller.currentIndex.value = index;
                                    },
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
              ];
            },
            body: Obx(() => IndexedStack(
                  index: controller.currentIndex.value,
                  children: controller.fillterTabs.map((model) {
                    return Builder(
                      builder: (BuildContext context) {
                        return KeepAliveWrapper(
                            child: TraderDetailListCell(
                          model: model,
                          controller: controller,
                        ));
                      },
                    );
                  }).toList(),
                )),
          );
  }
}

Widget getSmartFollow(FollowSetupController controller, FollowKolInfo trader) {
  return
      // Stack(
      // children: [
      CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
          child: Container(
        decoration: const BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.w, bottom: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.follow71.tr, style: AppTextStyle.f_20_600.color111111),
                SizedBox(
                  height: 18.h,
                ),
                FollowSetupTop(trader: trader),
                Row(
                  children: [
                    Text(LocaleKeys.follow72.tr, style: AppTextStyle.f_15_500.color111111),
                    const Spacer(),
                    Obx(() => controller.accountModel.value.amountStr != null
                        ? Row(
                            children: [
                              Text(LocaleKeys.follow73.tr, style: AppTextStyle.f_11_400.color999999),
                              SizedBox(width: 4.w),
                              Text(controller.accountModel.value.amountStr!, style: AppTextStyle.f_11_500.color111111),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {"from": 2, "to": 0});
                                    if (res) {
                                      UIUtil.showSuccess(LocaleKeys.assets10.tr);
                                      controller.getMyTraderAccount;
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4.w, right: 8.w),
                                  child: MyImage(
                                    'flow/folllow_swap'.svgAssets(),
                                    width: 16.w,
                                  ),
                                ),
                              )
                            ],
                          )
                        : const SizedBox()),
                  ],
                ),
                AppGuideView(
                  order: 2,
                  guideType: AppGuideType.follow,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: Container(
                    margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                    padding: const EdgeInsets.only(left: 16, right: 12),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: AppColor.colorEEEEEE), borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Obx(() => SearchTextField(
                                  controller: controller.smartVC.value,
                                  height: 50,
                                  hintText: LocaleKeys.follow81.tr,
                                  havePrefixIcon: false,
                                  haveBottomPadding: true,
                                  fontSize: 15,
                                  fillColor: AppColor.colorWhite,
                                  haveSuffixIcon: false,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))],
                                ))),
                        Text('USDT', style: AppTextStyle.f_13_400.color666666),
                        Container(
                          width: 1,
                          height: 12.h,
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: const BoxDecoration(color: AppColor.colorEEEEEE),
                        ),
                        GestureDetector(
                            onTap: () => controller.maxAmount(), child: Text('MAX', style: AppTextStyle.f_13_500.color111111)),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 104.h,
                    margin: EdgeInsets.symmetric(vertical: 16.h),
                    alignment: Alignment.center,
                    child: MyImage(
                      'assets/images/flow/follow_smart_ad.png',
                    )),
                Text('${LocaleKeys.follow74.tr}:', style: AppTextStyle.f_14_500.color111111),
                SizedBox(
                  height: 10.h,
                ),
                Text(LocaleKeys.follow523.tr, style: AppTextStyle.f_12_400_15.color666666),
                Text(LocaleKeys.follow524.tr, style: AppTextStyle.f_12_400_15.color666666),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: LocaleKeys.follow525.tr, style: AppTextStyle.f_12_400_15.color666666),
                      TextSpan(
                          text: LocaleKeys.follow526.tr,
                          style: AppTextStyle.f_12_400_15.color0075FF,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.followDealPriceDescription});
                            }),
                    ],
                  ),
                ),

                Text(LocaleKeys.follow527.tr, style: AppTextStyle.f_12_400_15.color666666),
                // StyledText(
                //   text: LocaleKeys.follow75.tr,
                //   style: AppTextStyle.f_12_400_15.color666666,
                //   tags: {
                //     'b': StyledTextActionTag((a, b) {
                //       Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.followDealPriceDescription});
                //     }, style: AppTextStyle.f_12_400_15.color0075FF),
                //   },
                // )
              ],
            ),
            SizedBox(height: 150.h)
          ],
        ),
      ))
    ],
  );
}

class TraderDetailListCell extends StatelessWidget {
  const TraderDetailListCell({
    super.key,
    required this.model,
    required this.controller,
  });
  final FollowSetupModel model;
  final FollowSetupController controller;

  @override
  Widget build(BuildContext context) {
    switch (model.type) {
      case FollowSetupType.fixedAmount:
        return CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: getCurrentDetailCell(model),
            ),
            SliverToBoxAdapter(
              child: getSecond(model),
            ),
            SliverToBoxAdapter(
              child: getThree(context, model),
            ),
            const SliverToBoxAdapter(
                child: SizedBox(
              height: 150,
            ))
          ],
        );

      default:
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: getCurrentDetailCell(model),
            ),
            SliverToBoxAdapter(
              child: getSecond(model),
            ),
            SliverToBoxAdapter(
              child: getThree(context, model),
            ),
            const SliverToBoxAdapter(
                child: SizedBox(
              height: 150,
            ))
          ],
        );
    }
  }

  Widget getCurrentDetailCell(FollowSetupModel model) {
    return Container(
      // color: Colors.amber,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(LocaleKeys.follow76.tr, style: AppTextStyle.f_15_500.color111111),
          Container(
            margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
            padding: const EdgeInsets.only(left: 16, right: 12),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: AppColor.colorEEEEEE), borderRadius: BorderRadius.circular(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: SearchTextField(
                  controller: model.controllerArray.first,
                  height: 50,
                  hintText: model.type.hintText,
                  havePrefixIcon: false,
                  haveBottomPadding: true,
                  fontSize: 15,
                  fillColor: AppColor.colorWhite,
                  haveSuffixIcon: false,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))],
                )),
                Text(model.type == FollowSetupType.fixedAmount ? 'USDT' : LocaleKeys.follow77.tr,
                    style: AppTextStyle.f_13_500.color666666),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Obx(() => controller.accountModel.value.amountStr != null
                  ? Row(
                      children: [
                        Text(LocaleKeys.follow73.tr, style: AppTextStyle.f_12_400.color999999),
                        SizedBox(width: 4.w),
                        Text(controller.accountModel.value.amountStr!, style: AppTextStyle.f_12_400.color111111),
                        GestureDetector(
                          onTap: () async {
                            try {
                              final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {"from": 2, "to": 0});
                              if (res) {
                                UIUtil.showSuccess(LocaleKeys.assets10.tr);
                                controller.getMyTraderAccount;
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w, right: 8.w),
                            child: MyImage(
                              'flow/folllow_swap'.svgAssets(),
                              width: 12.w,
                            ),
                          ),
                        )
                      ],
                    )
                  : const SizedBox())),
        ],
      ),
    );
  }

  getSecond(FollowSetupModel model) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                height: 26.h,
                child: Text(LocaleKeys.follow78.tr, style: AppTextStyle.f_15_500.color111111).marginOnly(right: 4.w),
              ),
              GestureDetector(
                  onTap: () async {
                    UIUtil.showAlert(
                        isDismissible: true,
                        LocaleKeys.follow78.tr,
                        content: LocaleKeys.follow304.tr,
                        confirmText: LocaleKeys.follow85.tr, confirmHandler: () {
                      Get.back();
                    });
                  },
                  child: SizedBox(
                    width: 13.w,
                    height: 13.w,
                    child: MyImage(
                      'flow/follow_setup_tip'.svgAssets(),
                    ),
                  ))
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
            padding: const EdgeInsets.only(left: 16, right: 12),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: AppColor.colorEEEEEE), borderRadius: BorderRadius.circular(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: SearchTextField(
                  controller: model.controllerArray[1],
                  height: 50,
                  hintText: model.hintText,
                  havePrefixIcon: false,
                  haveBottomPadding: true,
                  fontSize: 15,
                  fillColor: AppColor.colorWhite,
                  haveSuffixIcon: false,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))],
                )),
                Text('USDT', style: AppTextStyle.f_13_500.color666666),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 8.h),
          //   child: Row(
          //     children: [
          //       Text('该交易员日均开仓',
          //           style: TextStyle(
          //             fontSize: 12.sp,
          //             color: AppColor.color999999,
          //             fontWeight: FontWeight.w400,
          //           )),
          //       SizedBox(width: 4.w),
          //       Text('29次',
          //           style: TextStyle(
          //             fontSize: 12.sp,
          //             color: AppColor.color111111,
          //             fontWeight: FontWeight.w500,
          //           )),
          //     ],
          //   ),
          // ),
          // Row(
          //   children: <Widget>[
          //     Text('智能推荐',
          //         style: TextStyle(
          //           fontSize: 12.sp,
          //           color: AppColor.color999999,
          //           fontWeight: FontWeight.w400,
          //         )),
          //     SizedBox(width: 4.w),
          //     Text('--',
          //         style: TextStyle(
          //           fontSize: 12.sp,
          //           color: AppColor.color111111,
          //           fontWeight: FontWeight.w500,
          //         )),
          //   ],
          // ),
        ],
      ),
    );
  }

  getThree(BuildContext context, FollowSetupModel model) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('高级设置', style: AppTextStyle.body2_500.color111111),
          //   ],
          // ),
          MediaQuery.removePadding(
              removeTop: true,
              removeBottom: true,
              context: context,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.all(0),
                  collapsedTextColor: Colors.green,
                  iconColor: AppColor.color4D4D4D,
                  collapsedIconColor: AppColor.color4D4D4D,
                  title: Text(LocaleKeys.follow79.tr, style: AppTextStyle.f_15_500.color111111),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(LocaleKeys.follow80.tr, style: AppTextStyle.f_13_600.color111111),
                        Container(
                          margin: EdgeInsets.only(top: 8.h, bottom: 5.h),
                          padding: const EdgeInsets.only(left: 16, right: 12),
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              border: Border.all(width: 1.0, color: AppColor.colorEEEEEE),
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: SearchTextField(
                                controller: model.controllerArray[2],
                                height: 50,
                                hintText: LocaleKeys.follow81.tr,
                                havePrefixIcon: false,
                                haveBottomPadding: true,
                                fontSize: 15,
                                fillColor: AppColor.colorWhite,
                                haveSuffixIcon: false,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                  LengthLimitingTextInputFormatter(5),
                                ],
                              )),
                              Text('%', style: AppTextStyle.f_13_500.color666666),
                            ],
                          ),
                        ),
                        Obx(() => Wrap(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: LocaleKeys.follow246.trArgs([(model.text2.value)]),

                                          // text: '当跟单该交易员的仓位损失达到${model.text2.value}%时，该仓位会 ',
                                          style: AppTextStyle.f_12_400.color999999),
                                      TextSpan(text: '   ', style: AppTextStyle.f_12_400.color999999),
                                      TextSpan(text: '${LocaleKeys.follow247.tr}; ', style: AppTextStyle.f_12_400.color111111),
                                      TextSpan(text: LocaleKeys.follow248.tr, style: AppTextStyle.f_12_400.color999999),
                                    ],
                                  ),
                                )

                                // Text(LocaleKeys.follow82.tr, style: AppTextStyle.small_400.color999999),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: Text(LocaleKeys.follow83.tr, style: AppTextStyle.f_13_600.color111111),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8.h, bottom: 5.h),
                          padding: const EdgeInsets.only(left: 16, right: 12),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: AppColor.colorEEEEEE),
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: SearchTextField(
                                controller: model.controllerArray.last,
                                height: 50,
                                hintText: LocaleKeys.follow81.tr,
                                havePrefixIcon: false,
                                haveBottomPadding: true,
                                fontSize: 15,
                                fillColor: AppColor.colorWhite,
                                haveSuffixIcon: false,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                ],
                              )),
                              Text('%', style: AppTextStyle.f_13_500.color666666),
                            ],
                          ),
                        ),
                        Obx(() => Wrap(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: LocaleKeys.follow249.trArgs([(model.text3.value)]),

                                          // text: '当跟单该交易员的仓位损失达到${model.text2.value}%时，该仓位会 ',
                                          style: AppTextStyle.f_12_400.color999999),
                                      TextSpan(text: '   ', style: AppTextStyle.f_12_400.color999999),
                                      TextSpan(text: '${LocaleKeys.follow247.tr}; ', style: AppTextStyle.f_12_400.color111111),
                                      TextSpan(text: LocaleKeys.follow248.tr, style: AppTextStyle.f_12_400.color999999),
                                      // TextSpan(
                                      //     text: '当跟单该交易员的仓位盈利达到${model.text3.value}%时，该仓位会 ',
                                      //     style: AppTextStyle.small_400.color999999),
                                      // TextSpan(text: '立即市价全平', style: AppTextStyle.small_400.color111111),
                                      // TextSpan(text: '；该策略会在所有跟单仓位上执行\n', style: AppTextStyle.small_400.color999999),
                                    ],
                                  ),
                                )

                                // Text(LocaleKeys.follow82.tr, style: AppTextStyle.small_400.color999999),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class FollowSetupTabbar extends StatelessWidget {
  const FollowSetupTabbar({super.key, required this.dataArray, required this.currentIndex, this.callBack});
  final List<String> dataArray;
  final int currentIndex;
  final Function(int index)? callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      padding: EdgeInsets.fromLTRB(0, 9.w, 16.w, 16.w),
      child: Row(
          children: dataArray
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: MyButton(
                    height: 32.w,
                    text: e,
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    color: dataArray[currentIndex] == e ? AppColor.colorBlack : AppColor.color666666,
                    textStyle: AppTextStyle.f_12_600,
                    backgroundColor: dataArray[currentIndex] == e ? Colors.transparent : AppColor.colorF4F4F4,
                    border: Border.all(
                        color: dataArray[currentIndex] == e ? AppColor.color333333 : AppColor.colorF4F4F4, width: 1.w),
                    onTap: () {
                      if (e != dataArray[currentIndex]) {
                        callBack?.call(dataArray.indexOf(e));
                      }
                    },
                  ),
                ),
              )
              .toList()),
    );
  }
}

class MyDialog extends StatelessWidget {
  const MyDialog({super.key, this.showTime = true});
  final bool showTime;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: showTime ? getTimeWidget() : getWayWidget());
  }

  getTimeWidget() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.follow69.tr,
            style: AppTextStyle.f_16_500.color111111,
          ).marginOnly(bottom: 7.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: LocaleKeys.follow84.tr,
                  style: AppTextStyle.f_12_400_15.color666666,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: MyButton(
                  text: LocaleKeys.follow85.tr,
                  color: AppColor.colorWhite,
                  textStyle: AppTextStyle.f_15_600.color111111,
                  height: 40.h,
                  onTap: () {
                    // controller.editCommission();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getWayWidget() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.follow70.tr,
            style: AppTextStyle.f_16_500.color111111,
          ).marginOnly(bottom: 16.h),
          Text(
            LocaleKeys.follow296.tr,
            style: AppTextStyle.f_12_500.color111111,
          ),
          Text.rich(
            TextSpan(
              children: [
                // TextSpan(
                //   text: '固定金额跟单：',
                //   style: AppTextStyle.small_500.color111111,
                // ),
                TextSpan(
                  text: LocaleKeys.follow297.tr,
                  style: AppTextStyle.f_12_400_15.color666666,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            LocaleKeys.follow88.tr,
            style: AppTextStyle.f_12_500.color111111,
          ),
          Text.rich(
            TextSpan(
              children: [
                // TextSpan(
                //   text: '按比例跟单：',
                //   style: TextStyle(
                //     color: AppColor.color111111,
                //     fontSize: 12.sp,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),

                TextSpan(
                  text: LocaleKeys.follow87.tr,
                  style: AppTextStyle.f_12_400_15.color666666,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: MyButton(
                  text: LocaleKeys.follow85.tr,
                  color: AppColor.colorWhite,
                  textStyle: AppTextStyle.f_15_600.color111111,
                  height: 40.h,
                  onTap: () {
                    // controller.editCommission();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
