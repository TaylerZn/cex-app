import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_home_traker/widget/follow_orders_cell.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_taker_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_bar.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_alist.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_top.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../controllers/follow_taker_info_controller.dart';

//
class FollowTakerInfoView extends GetView<FollowTakerInfoController> {
  const FollowTakerInfoView({super.key, this.tagStr});
  final String? tagStr;

  @override
  String? get tag => TagCacheUtil().getTag('FollowTakerInfoController');

  @override
  Widget build(BuildContext context) {
    return tagStr != null
        ? GetBuilder<FollowTakerInfoController>(
            tag: tagStr,
            builder: (controller) {
              return controller.viewType == FollowViewType.other
                  ? const FollowOrdersLoading(isSliver: false)
                  : Column(
                      children: <Widget>[
                        FollowTakerTabbar(
                          controller: controller.tabController,
                          dataArray: controller.tabArray.map((e) => e.value).toList(),
                        ),
                        Expanded(
                            child: TabBarView(
                                controller: controller.tabController,
                                children: controller.tabArray.map((type) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return TraderDetailList(
                                        type: type,
                                        controller: controller,
                                      );
                                    },
                                  );
                                }).toList()))
                      ],
                    );
            })
        : GetBuilder<FollowTakerInfoController>(
            tag: tag,
            builder: (controller) {
              return Scaffold(
                  appBar: getNavBar(controller),
                  body: controller.viewType == FollowViewType.other
                      ? const FollowOrdersLoading(isSliver: false)
                      : NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollNotification) {
                            if (scrollNotification is ScrollUpdateNotification) {
                              if (scrollNotification.metrics.axis == Axis.vertical) {
                                double currentPixels = scrollNotification.metrics.pixels;
                                double previousPixels = currentPixels - scrollNotification.scrollDelta!;

                                controller.scrollControllerOffsetY(
                                    scrollNotification.metrics.pixels, currentPixels > previousPixels);
                              }
                            }
                            return true;
                          },
                          child: NestedScrollView(
                              // controller: controller.scrollVC,
                              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                                return <Widget>[
                                  FollowTakerTop(controller: controller),
                                  SliverPinnedHeader(
                                    child: FollowTakerTabbar(
                                      controller: controller.tabController,
                                      dataArray: controller.tabArray.map((e) => e.value).toList(),
                                    ),
                                  ),
                                ];
                              },
                              body: TabBarView(
                                  controller: controller.tabController,
                                  children: controller.tabArray.map((type) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        controller.scrollViewController = PrimaryScrollController.of(context);

                                        return TraderDetailList(
                                          type: type,
                                          controller: controller,
                                        );
                                      },
                                    );

                                    // }
                                  }).toList())),
                        ),
                  bottomNavigationBar: getBottomView(context, controller));
            });
  }

  Widget? getBottomView(BuildContext context, FollowTakerInfoController controller) {
    return controller.showBottom
        ? Obx(() => controller.detailModel.value.userName.isEmpty
            ? const SizedBox()
            : getButton(context, controller.viewType, controller))
        : null;
  }

  Widget getButton(BuildContext context, FollowViewType type, FollowTakerInfoController controller) {
    var infoModel = FollowKolInfo(
        uid: controller.detailModel.value.uid,
        imgUrl: controller.detailModel.value.imgUrl,
        userName: controller.detailModel.value.userName,
        label: controller.detailModel.value.label,
        isFollowStart: controller.detailModel.value.isFollowStart,
        positionSize: controller.detailModel.value.positionSize,
        ctime: controller.detailModel.value.ctime,
        startCount: controller.detailModel.value.startCount,
        levelType: controller.detailModel.value.levelType);

    if (type == FollowViewType.mySelfToCustomer) {
      return GestureDetector(
        onTap: () {
          Get.toNamed(Routes.APPLY_SUPERTRADER_STATES);
        },
        child: Container(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            decoration: const BoxDecoration(
              color: AppColor.colorWhite,
              border: Border(
                top: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
              ),
            ),
            height: 80.h,
            child: Container(
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFD428),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                ),
                height: 48.h,
                child: Text(LocaleKeys.follow127.tr, style: AppTextStyle.f_16_600.color111111.ellipsis))),
      );
    } else {
      var model = controller.detailModel.value;

      if (model.isDisableUsers == 1) {
        return Container(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            decoration: const BoxDecoration(
              color: AppColor.colorWhite,
              border: Border(
                top: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
              ),
            ),
            height: 80.h,
            child: Container(
                padding: EdgeInsets.only(left: 24.w),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: AppColor.colorF1F1F1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
                ),
                height: 48.h,
                child: Text(LocaleKeys.follow33.tr, style: AppTextStyle.f_16_600.colorABABAB)));
      } else {
        if (model.followStatus == 1) {
          return Container(
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              decoration: const BoxDecoration(
                color: AppColor.colorWhite,
                border: Border(
                  top: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
                ),
              ),
              height: 80.h,
              child: MyButton.borderWhiteBg(
                height: 48.h,
                text: LocaleKeys.follow13.tr,
                textStyle: AppTextStyle.f_16_600.color111111,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                onTap: () {
                  Get.toNamed(Routes.FOLLOW_SETUP,
                      arguments: {'model': infoModel, 'isEdit': true, 'isSmart': controller.detailModel.value.isSmart});
                },
              ));
        } else {
          if (model.switchFollowerNumber == 2) {
            return Container(
                padding: EdgeInsets.all(16.w),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                decoration: const BoxDecoration(
                  color: AppColor.colorWhite,
                  border: Border(
                    top: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
                  ),
                ),
                height: 80.h,
                child: Container(
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: AppColor.colorF1F1F1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
                    ),
                    height: 48.h,
                    child: Text(LocaleKeys.follow14.tr, style: AppTextStyle.f_16_600.colorABABAB)));
          } else {
            if (model.copySwitch == 0) {
              if (model.applyFollowStatus == 0) {
                //申请中
                return Container(
                    padding: EdgeInsets.all(16.w),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColor.colorWhite,
                      border: Border(
                        top: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
                      ),
                    ),
                    height: 80.h,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: AppColor.colorF1F1F1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
                        ),
                        height: 48.h,
                        child: Text(LocaleKeys.follow15.tr, style: AppTextStyle.f_16_600.colorABABAB)));
              } else if (model.applyFollowStatus == 1) {
                //通过
                return Container(
                  padding: EdgeInsets.all(16.w),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColor.colorWhite,
                    border: Border(
                      top: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
                    ),
                  ),
                  height: 80.h,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 120,
                        child: MyButton.borderWhiteBg(
                          height: 48.h,
                          text: LocaleKeys.follow17.tr,
                          textStyle: AppTextStyle.f_16_600.color111111,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          onTap: () {
                            if (UserGetx.to.goIsLogin()) {
                              if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                                showshieldSheetView(
                                    model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                                    callback: () => Get.back());
                              } else {
                                Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': infoModel, 'isSmart': false});
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        flex: 217,
                        child: MyButton(
                          onTap: () {
                            if (UserGetx.to.goIsLogin()) {
                              if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                                showshieldSheetView(
                                    model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                                    callback: () => Get.back());
                              } else {
                                Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': infoModel, 'isSmart': true});
                              }
                            }
                          },
                          text: LocaleKeys.follow16.tr,
                          height: 48.h,
                          textStyle: AppTextStyle.f_16_600,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                //去申请
                return FollowBottomApplyBtn(model: infoModel);
              }
            } else {
              return Container(
                padding: EdgeInsets.all(16.w),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                decoration: const BoxDecoration(
                  color: AppColor.colorWhite,
                  border: Border(
                    top: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
                  ),
                ),
                height: 80.h,
                child: Row(
                  children: [
                    Expanded(
                      flex: 120,
                      child: MyButton.borderWhiteBg(
                        height: 48.h,
                        text: LocaleKeys.follow17.tr,
                        textStyle: AppTextStyle.f_16_600.color111111,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        onTap: () {
                          if (UserGetx.to.goIsLogin()) {
                            if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                              showshieldSheetView(
                                  model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                                  callback: () => Get.back());
                            } else {
                              Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': infoModel, 'isSmart': false});
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      flex: 217,
                      child: MyButton(
                        onTap: () {
                          if (UserGetx.to.goIsLogin()) {
                            if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                              showshieldSheetView(
                                  model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                                  callback: () => Get.back());
                            } else {
                              Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': infoModel, 'isSmart': true});
                            }
                          }
                        },
                        text: LocaleKeys.follow16.tr,
                        height: 48.h,
                        textStyle: AppTextStyle.f_16_600,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                      ),
                    )
                  ],
                ),
              );
            }
          }
        }
      }
    }
  }
}
