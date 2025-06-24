import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/controllers/follow_taker_info_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_taker_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_mixin.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/my_shield_enum.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

PreferredSize getNavBar(FollowTakerInfoController controller) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Obx(() => AppBar(
            leading:
                MyPageBackWidget(backColor: controller.textColorValue.value),
            backgroundColor: controller.navBarColor.value,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Visibility(
                        visible: controller.showBar.value,
                        child: Expanded(
                          child: Row(
                            children: <Widget>[
                              UserAvatar(
                                controller.detailModel.value.icon,
                                width: 24.w,
                                height: 24.w,
                                levelType: controller.detailModel.value.levelType,
                                isTrader: true,
                                tradeIconSize: 8.w,
                              ),
                              Expanded(
                                child: Text(
                                  controller.detailModel.value.userName,
                                  style: AppTextStyle.f_16_600.color111111,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ).paddingSymmetric(horizontal: 8.w),
                              ),
                              controller.detailModel.value.flagIcon.isEmpty
                                  ? const SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: MyImage(
                                          controller.detailModel.value.flagIcon,
                                          width: 16.w,
                                          height: 12.w),
                                    )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    controller.viewType != FollowViewType.mySelfToCustomer
                        ? SizedBox(
                            height: 44.h,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                FollowTakerSheetView()
                                    .showPersonalHomepageSheetView(controller,
                                        viewType: controller.viewType);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 16.w),
                                child: MyImage(
                                  'flow/follow_manage_right'.svgAssets(),
                                  width: 18.w,
                                  color: controller.textColorValue.value,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                )
              ],
            ),
            titleSpacing: 0,
          )));
}

class FollowTakerTabbar extends StatelessWidget {
  const FollowTakerTabbar(
      {super.key, required this.dataArray, required this.controller});

  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        // color: Colors.green,
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
        ),
      ),
      height: 40.h,
      width: double.infinity,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        labelStyle: AppTextStyle.f_15_600,
        unselectedLabelStyle: AppTextStyle.f_15_400,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColor.colorBlack,
            width: 2.h,
          ),
          // insets: EdgeInsets.only(left: 14.w, right: 14.w, top: 0, bottom: 0),
        ),
        labelPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        tabs: dataArray
            .map((f) => Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(f),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

// 交易员看自己         跳转列表
// 交易员看交易员       只有拉黑
// 交易员看用户个人主页  拉黑和禁止跟单

// 用户看交易员         只有拉黑
// 用户看自己           啥也没有
// 用户看用户个人主页    只有拉黑

class FollowTakerSheetView with FollowShare {
  showPersonalHomepageSheetView(FollowTakerInfoController controller,
      {FollowViewType viewType = FollowViewType.other}) {
    showModalBottomSheet(
      context: Get.context!,
      useSafeArea: true,
      builder: (BuildContext context) {
        var shareView = viewType.index < 3
            ? const SizedBox()
            : GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  Get.back();

                  Get.dialog(
                    MyShareView(
                      content: getTakerBarShareView(
                        controller.detailModel.value.uid,
                        controller.detailModel.value,
                      ),
                      url:
                          '${LinksGetx.to.followUrl}${controller.detailModel.value.uid}',
                    ),
                    useSafeArea: false,
                    barrierDismissible: true,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 25.h),
                  child: Column(
                    children: <Widget>[
                      imgContainer(MyImage(
                        'default/share'.svgAssets(),
                        width: 20.w,
                      )),
                      SizedBox(height: 10.w),
                      Text(LocaleKeys.public34.tr,
                          style: AppTextStyle.f_12_400.color666666),
                    ],
                  ),
                ),
              );

        return Container(
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          padding: EdgeInsets.fromLTRB(
              30.w, 16.h, 24.w, 24.w + MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: ShapeDecoration(
                    color: AppColor.color999999,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 38.h),
              (viewType == FollowViewType.traderToCustomer ||
                      viewType == FollowViewType.mySelfToTrader)
                  ? Row(
                      children: [
                        shareView,
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            if (UserGetx.to.goIsLogin()) {
                              Get.back();
                              if (viewType == FollowViewType.mySelfToTrader) {
                                Get.toNamed(Routes.MY_TAKE_BLOCK, arguments: {
                                  'type': MyTakeShieldActionType.blacklist
                                });
                              } else {
                                bool? res = await UIUtil.showConfirm(
                                    LocaleKeys.follow128.tr,
                                    contentWidget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // SizedBox(height: 7.h),
                                          Text(
                                              LocaleKeys.follow129.trArgs([
                                                (controller
                                                    .detailModel.value.userName)
                                              ]),
                                              style: AppTextStyle
                                                  .f_12_400_15.color666666),
                                          Text(LocaleKeys.follow130.tr,
                                              style: AppTextStyle
                                                  .f_12_400_15.color666666)
                                        ]),
                                    cancelText: LocaleKeys.public2.tr,
                                    confirmText: LocaleKeys.public1.tr);
                                if (res == true) {
                                  controller.setProhibitAction(
                                      userId: controller.detailModel.value.uid,
                                      types: 1);
                                }
                              }
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              imgContainer(MyImage(
                                'flow/follow_blacklist'.svgAssets(),
                                width: 20.w,
                              )),
                              SizedBox(height: 10.w),
                              Text(
                                  viewType == FollowViewType.mySelfToTrader
                                      ? LocaleKeys.follow221.tr
                                      : LocaleKeys.follow131.tr,
                                  style: AppTextStyle.f_12_400.color666666),
                            ],
                          ),
                        ),
                        SizedBox(width: 25.h),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            if (UserGetx.to.goIsLogin()) {
                              Get.back();
                              if (viewType == FollowViewType.mySelfToTrader) {
                                Get.toNamed(Routes.MY_TAKE_BLOCK, arguments: {
                                  'type': MyTakeShieldActionType.prohibit
                                });
                              } else {
                                bool? res = await UIUtil.showConfirm(
                                    LocaleKeys.follow132.tr,
                                    content: LocaleKeys.follow133.trArgs([
                                      (controller.detailModel.value.userName)
                                    ]),
                                    cancelText: LocaleKeys.public2.tr,
                                    confirmText: LocaleKeys.public1.tr);
                                if (res == true) {
                                  controller.setProhibitAction(
                                      userId: controller.detailModel.value.uid,
                                      types: 2);
                                }
                              }
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              imgContainer(MyImage(
                                'flow/follow_prohibit'.svgAssets(),
                                color: AppColor.colorBlack,
                                width: 20.w,
                              )),
                              SizedBox(height: 10.w),
                              Text(
                                  viewType == FollowViewType.mySelfToTrader
                                      ? LocaleKeys.follow222.tr
                                      : LocaleKeys.follow134.tr,
                                  style: AppTextStyle.f_12_400.color666666),
                            ],
                          ),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        shareView,
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            if (UserGetx.to.goIsLogin()) {
                              Get.back();
                              if (viewType == FollowViewType.mySelfToTrader) {
                                Get.toNamed(Routes.MY_TAKE_BLOCK, arguments: {
                                  'type': MyTakeShieldActionType.blacklist
                                });
                              } else {
                                bool? res = await UIUtil.showConfirm(
                                    LocaleKeys.follow128.tr,
                                    contentWidget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // SizedBox(height: 7.h),

                                          Text(
                                              LocaleKeys.follow129.trArgs([
                                                (controller
                                                    .detailModel.value.userName)
                                              ]),
                                              style: AppTextStyle
                                                  .f_12_400_15.color666666),
                                          Text(LocaleKeys.follow130.tr,
                                              style: AppTextStyle
                                                  .f_12_400_15.color666666)
                                        ]),
                                    cancelText: LocaleKeys.public2.tr,
                                    confirmText: LocaleKeys.public1.tr);
                                if (res == true) {
                                  controller.setProhibitAction(
                                      userId: controller.detailModel.value.uid,
                                      types: 1);
                                }
                              }
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              imgContainer(MyImage(
                                'flow/follow_blacklist'.svgAssets(),
                                width: 20.w,
                              )),
                              SizedBox(height: 10.w),
                              Text(LocaleKeys.follow131.tr,
                                  style: AppTextStyle.f_12_400.color666666),
                            ],
                          ),
                        ),
                      ],
                    )
            ],
          ),
        );
      },
    );
  }

  Widget imgContainer(Widget child) {
    return Container(
      child: Center(
        child: child,
      ),
      width: 48.w,
      height: 48.w,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: AppColor.colorF5F5F5),
    );
  }
}
