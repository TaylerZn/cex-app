import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/widget/assets_overview_top.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_detail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/follow_my_trader.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/follow_user_order.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_item.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_mixin.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/controllers/my_follow_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/my_follow_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_mark.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../getX/assets_Getx.dart';
import '../../../../utils/utilities/number_util.dart';

//

class MyFollowListCell extends StatelessWidget with FollowShare, FollowTag {
  const MyFollowListCell({super.key, required this.type, required this.controller});
  final MyFollowFilterType type;
  final MyFollowController controller;

  @override
  Widget build(BuildContext context) {
    return type == MyFollowFilterType.myTrader
        ? Obx(() => IndexedStack(
              index: controller.myTraderArrIndex.value,
              children: [
                SmartRefresher(
                  controller: controller.myTraderRefreshArr[0],
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () async {
                    await controller.getData(isPullDown: true);
                    controller.myTraderRefreshArr[0].refreshToIdle();
                    controller.myTraderRefreshArr[0].loadComplete();
                  },
                  onLoading: () async {
                    if (controller.myTraderArr[0].value.haveMore) {
                      controller.myTraderArr[0].value.page++;
                      await controller.getData();
                      controller.myTraderRefreshArr[0].loadComplete();
                    } else {
                      controller.myTraderRefreshArr[0].loadNoData();
                    }
                  },
                  child: CustomScrollView(
                    key: PageStorageKey<String>(type.value),
                    slivers: [
                      FollowCurrentDetailTabbar(
                        dataArray: controller.myTraderArrTabs.map((e) => e.value).toList(),
                        currentIndex: controller.myTraderArrIndex.value,
                        callBack: (i) {
                          controller.myTraderArrIndex.value = i;
                          controller.getData();
                        },
                      ),
                      Obx(() => controller.myTraderArr[0].value.list?.isNotEmpty == true
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (content, index) {
                                  return getMyTraderCurrentCell(controller.myTraderArr[0].value.list![index]);
                                },
                                childCount: controller.myTraderArr[0].value.list!.length,
                              ),
                            )
                          : controller.myTraderArr[0].value.isError == false
                              ? SliverToBoxAdapter(
                                  child: Padding(
                                  padding: EdgeInsets.only(top: 36.w),
                                  child: const MyFollowStudy(),
                                ))
                              : FollowOrdersLoading(
                                  isError: controller.myTraderArr[0].value.isError,
                                  onTap: () {
                                    controller.getData(isPullDown: true);
                                  }))
                    ],
                  ),
                ),
                SmartRefresher(
                  controller: controller.myTraderRefreshArr[1],
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () async {
                    await controller.getData(isPullDown: true);
                    controller.myTraderRefreshArr[1].refreshToIdle();
                    controller.myTraderRefreshArr[1].loadComplete();
                  },
                  onLoading: () async {
                    if (controller.myTraderArr[1].value.haveMore) {
                      controller.myTraderArr[1].value.page++;
                      await controller.getData();
                      controller.myTraderRefreshArr[1].loadComplete();
                    } else {
                      controller.myTraderRefreshArr[1].loadNoData();
                    }
                  },
                  child: CustomScrollView(
                    key: PageStorageKey<String>(type.value),
                    slivers: [
                      FollowCurrentDetailTabbar(
                        dataArray: controller.myTraderArrTabs.map((e) => e.value).toList(),
                        currentIndex: controller.myTraderArrIndex.value,
                        callBack: (i) {
                          controller.myTraderArrIndex.value = i;
                          controller.getData();
                        },
                      ),
                      Obx(() => controller.myTraderArr[1].value.list?.isNotEmpty == true
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (content, index) {
                                  return getMyTraderHistoryCell(controller.myTraderArr[1].value.list![index]);
                                },
                                childCount: controller.myTraderArr[1].value.list!.length,
                              ),
                            )
                          : FollowOrdersLoading(
                              isError: controller.myTraderArr[1].value.isError,
                              onTap: () {
                                controller.getData(isPullDown: true);
                              }))
                    ],
                  ),
                ),
              ],
            ))
        : type == MyFollowFilterType.currentDocumentary
            ? Obx(() => controller.currentList.value.list == null
                ? CustomScrollView(
                    key: PageStorageKey<String>(type.value),
                    slivers: const <Widget>[FollowOrdersLoading()],
                  )
                : controller.currentList.value.list!.isEmpty
                    ? CustomScrollView(
                        key: PageStorageKey<String>(type.value),
                        slivers: const <Widget>[FollowOrdersLoading(isError: false)],
                      )
                    : SmartRefresher(
                        controller: controller.currentListRefresh,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh: () async {
                          await controller.getData(isPullDown: true);
                          controller.currentListRefresh.refreshToIdle();
                          controller.currentListRefresh.loadComplete();
                        },
                        onLoading: () async {
                          if (controller.currentList.value.haveMore) {
                            controller.currentList.value.page++;
                            await controller.getData();
                            controller.currentListRefresh.loadComplete();
                          } else {
                            controller.currentListRefresh.loadNoData();
                          }
                        },
                        child: CustomScrollView(
                          key: PageStorageKey<String>(type.value),
                          slivers: <Widget>[
                            FollowCurrentDetailTabbar(
                              dataArray: controller.subCurrentFilterTabs.map((e) => e.value).toList(),
                              currentIndex: controller.filterIndex,
                              callBack: (i) {
                                controller.getCurrentFlollowList(i);
                              },
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate((content, index) {
                                return getCurrentDetailCell(controller.currentList.value.list![index]);
                              }, childCount: controller.currentList.value.list!.length),
                            )
                          ],
                        ),
                      ))
            : SmartRefresher(
                controller: controller.historyListRefresh,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  await controller.getData(isPullDown: true);
                  controller.historyListRefresh.refreshToIdle();
                  controller.historyListRefresh.loadComplete();
                },
                onLoading: () async {
                  if (controller.historyList.value.haveMore) {
                    controller.historyList.value.page++;
                    await controller.getData();
                    controller.historyListRefresh.loadComplete();
                  } else {
                    controller.historyListRefresh.loadNoData();
                  }
                },
                child: CustomScrollView(
                  key: PageStorageKey<String>(type.value),
                  slivers: <Widget>[
                    Obx(() => controller.historyList.value.list?.isNotEmpty == true
                        ? SliverPadding(
                            padding: EdgeInsets.only(top: 16.w),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate((content, index) {
                                return getMyHistoryTapeCell(controller.historyList.value.list![index], content);
                              }, childCount: controller.historyList.value.list!.length),
                            ))
                        : FollowOrdersLoading(
                            isError: controller.historyList.value.isError,
                            onTap: () {
                              controller.getData(isPullDown: true);
                            }))
                  ],
                ),
              );
  }

  Widget getCurrentDetailCell(FollowUserFollowOrder model) {
    return Container(
      // margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 16.h),
      decoration: const BoxDecoration(
        // color: Colors.amber,
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                margin: EdgeInsets.only(right: 4.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: model.tagColor.withOpacity(0.1)),
                child: Text(model.tag, style: AppTextStyle.f_10_500.copyWith(color: model.tagColor)),
              ),
              Text(model.name, style: AppTextStyle.f_14_600.color111111),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                margin: EdgeInsets.only(left: 4.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: AppColor.colorF5F5F5),
                child: Text(model.contractTypeStr, style: AppTextStyle.f_10_500.color4D4D4D),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                margin: EdgeInsets.only(left: 4.w),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: AppColor.colorF5F5F5),
                child: Text(model.positionTypeStr, style: AppTextStyle.f_10_500.color4D4D4D),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(model.createdTime, style: AppTextStyle.f_11_500.color999999.ellipsis),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    MyShareView(
                        content: getHistoryFollowShareView(
                            earningsRateStr: model.rateStr,
                            contractType: model.contractTypeStr,
                            tagStr: model.tag,
                            tagColor: model.tagColor,
                            modelName: model.name,
                            openPriceStr: model.markPriceStr,
                            isStandardContract: model.isStandardContract,
                            subSymbol: model.subSymbolStr,
                            icon: model.iconStr,
                            name: model.kolNameStr)),
                    useSafeArea: false,
                    barrierDismissible: true,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w, left: 10.w),
                  child: MyImage(
                    'flow/follow_share'.svgAssets(),
                    width: 16.w,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${LocaleKeys.follow135.tr}(USDT)', style: AppTextStyle.f_11_400.color4D4D4D),
                          Text(model.earnStr, style: AppTextStyle.f_16_600.copyWith(color: model.earnColor)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(LocaleKeys.follow178.tr, style: AppTextStyle.f_11_400.color4D4D4D),
                          Text(model.rateStr, style: AppTextStyle.f_16_600.copyWith(color: model.earnColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 132.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${LocaleKeys.follow150.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                            SizedBox(height: 2.h),
                            Text(model.volumeStr, style: AppTextStyle.f_13_500.color4D4D4D),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${LocaleKeys.follow151.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                          SizedBox(height: 2.h),
                          Text(model.holdAmountStr, style: AppTextStyle.f_13_500.color4D4D4D),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${LocaleKeys.follow179.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                          SizedBox(height: 2.h),
                          Text(model.markPriceStr, style: AppTextStyle.f_13_500.color4D4D4D),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 132.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${LocaleKeys.follow152.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                          SizedBox(height: 2.h),
                          Text(model.openPriceStr, style: AppTextStyle.f_13_500.color4D4D4D),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.follow2.tr, style: AppTextStyle.f_11_400.color999999),
                        SizedBox(height: 2.h),
                        Text(model.kolNameStr, style: AppTextStyle.f_13_500.color4D4D4D),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getMyTraderCurrentCell(FollowMyTrader model) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppColor.colorF5F5F5),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      UserAvatar(
                        model.icon,
                        width: 36.w,
                        height: 36.h,
                        levelType: model.levelType,
                        isTrader: true,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            model.name,
                            style: AppTextStyle.f_15_500.color111111,
                          ),
                          Row(
                            children: <Widget>[
                              Text(model.followTimeStr, style: AppTextStyle.f_11_400.color999999),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    FollowKolInfo info = FollowKolInfo();
                    info.uid = model.kolUid ?? -1;
                    info.userName = model.name;
                    info.monthProfitRate = model.monthProfitRate;
                    info.winRateWeek = model.winRate;
                    info.label = model.labelStr;

                    Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': info, 'isEdit': true, 'isSmart': model.isSmart});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5.h),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: AppColor.colorEEEEEE)),
                    child: Text(LocaleKeys.follow13.tr, style: AppTextStyle.f_12_600.colorBlack),
                  ),
                )
              ],
            ),
            SizedBox(height: 19.h),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 115.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${LocaleKeys.follow44.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                      SizedBox(height: 2.h),
                      Text(model.followProfitStr, style: AppTextStyle.f_13_500.color4D4D4D),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${LocaleKeys.follow181.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                    SizedBox(height: 2.h),
                    Text(model.currentAmountStr, style: AppTextStyle.f_13_500.color4D4D4D),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('${LocaleKeys.follow182.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                    SizedBox(height: 2.h),
                    Text(model.todayProfitStr, style: AppTextStyle.f_13_500.color4D4D4D),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.h),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${LocaleKeys.follow183.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                        SizedBox(height: 2.h),
                        Text(model.flotProfitStr, style: AppTextStyle.f_13_500.color4D4D4D),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(LocaleKeys.follow184.tr, style: AppTextStyle.f_11_400.color999999),
                      SizedBox(height: 2.h),
                      Text(model.rateStr, style: AppTextStyle.f_13_500.color4D4D4D)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getMyHistoryTapeCell(FollowUserFollowOrder model, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppColor.colorEEEEEE),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      // ClipOval(
                      //   child: MyImage(
                      //     model.iconStr,
                      //     width: 36.w,
                      //     height: 36.h,
                      //   ),
                      // ),
                      UserAvatar(
                        model.iconStr,
                        width: 36.w,
                        height: 36.h,
                        levelType: model.levelType,
                        isTrader: true,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(model.kolNameStr, style: AppTextStyle.f_15_500.color111111),
                          Row(
                            children: <Widget>[
                              Text(model.followTimeStr, style: AppTextStyle.f_11_400.color999999),
                            ],
                          )
                        ],
                      ),
                      ...getIcon([model.flagIcon, ...model.organizationIconList])
                    ],
                  ),
                ),
                const Spacer(),
                Text(LocaleKeys.follow185.tr, style: AppTextStyle.f_12_500.color999999)
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5.h),
                //   decoration:
                //       BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColor.colorEEEEEE)),
                //   child: Text('已结束', style: AppTextStyle.f_12_500.color999999),
                // )
              ],
            ),
            SizedBox(height: 19.h),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${LocaleKeys.follow135.tr}(USDT)', style: AppTextStyle.f_11_400.color999999),
                      SizedBox(height: 2.h),
                      Text(model.earnStr,
                          style: AppTextStyle.f_13_500.copyWith(
                            color: model.earnColor,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${LocaleKeys.follow151.tr}(USDT)', style: AppTextStyle.f_11_400.color999999),
                          SizedBox(height: 4.h),
                          Text(model.holdAmountStr, style: AppTextStyle.f_13_500.color4D4D4D),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(LocaleKeys.follow115.tr, style: AppTextStyle.f_11_400.color999999),
                          SizedBox(height: 2.h),
                          Text(model.rateStr,
                              style: AppTextStyle.f_13_500.copyWith(
                                color: model.earnColor,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 1,
              color: AppColor.colorF5F5F5,
              margin: EdgeInsets.only(top: 16.w, bottom: 12.w),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MyButton.borderWhiteBg(
                  onTap: () {
                    if (model.isfollowStatus) {
                      UIUtil.showToast(LocaleKeys.follow302.tr);
                    } else {
                      var infoModel = FollowKolInfo(
                        uid: model.kolUid ?? -1,
                        imgUrl: model.iconStr,
                        userName: model.kolNameStr,
                        levelType: model.levelType,
                      );

                      Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': infoModel, 'isSmart': false});
                    }
                  },
                  height: 24.w,
                  text: LocaleKeys.follow259.tr,
                  textStyle: AppTextStyle.f_12_500,
                  color: AppColor.color111111,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                10.horizontalSpace,
                model.isRating
                    ? MyButton.borderWhiteBg(
                        onTap: () {
                          Get.toNamed(Routes.FOLLOW_TAKER_INFO,
                              arguments: {'uid': model.kolUid, 'index': 4}, preventDuplicates: false);
                        },
                        height: 24.w,
                        text: LocaleKeys.follow514.tr,
                        textStyle: AppTextStyle.f_12_500,
                        color: AppColor.colorBlack,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                      )
                    : MyButton(
                        onTap: () {
                          var detailModel = FollowkolUserDetailModel(
                              userName: model.kolNameStr,
                              imgUrl: model.iconStr,
                              flagIcon: model.flagIcon,
                              uid: model.kolUid ?? -1);
                          controller.textVC.text = '';

                          showFollowMarkheetView(
                            currentContext: context,
                            bottomType: FollowMarkType.mark,
                            detailModel: detailModel,
                            textVC: controller.textVC,
                            callback: () {
                              model.isTraderRating = '1';
                              controller.update();
                            },
                          );
                        },
                        height: 24.w,
                        text: LocaleKeys.follow495.tr,
                        textStyle: AppTextStyle.f_12_500,
                        color: AppColor.colorBlack,
                        backgroundColor: const Color(0xFFFFD428),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getMyTraderHistoryCell(FollowMyTrader model) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: AppColor.colorEEEEEE),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      ClipOval(
                        child: MyImage(
                          model.icon,
                          width: 36.w,
                          height: 36.h,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(model.name, style: AppTextStyle.f_15_500.color111111),
                          Row(
                            children: <Widget>[
                              Text(model.followHistroyTimeStr, style: AppTextStyle.f_11_400.color999999),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                MyButton(
                  text: LocaleKeys.follow259.tr,
                  textStyle: AppTextStyle.f_12_600.colorWhite,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                  onTap: () {
                    if (model.followStatus == 1) {
                      UIUtil.showToast(LocaleKeys.follow302.tr);
                    } else {
                      if (model.isBlacklistedUsers == 1 || model.isDisableUsers == 1) {
                        showshieldSheetView(model.isBlacklistedUsers == 1 ? FollowActionType.shield : FollowActionType.prohibit,
                            callback: () => Get.back());
                      } else {
                        FollowKolInfo info = FollowKolInfo(
                            uid: model.kolUid ?? 0,
                            imgUrl: model.icon,
                            userName: model.kolName ?? '',
                            monthProfitRate: model.monthProfitRate,
                            winRate: model.winRate);

                        Get.toNamed(Routes.FOLLOW_SETUP, arguments: {'model': info, 'isMore': true, 'isSmart': model.isSmart});
                      }
                    }
                  },
                )
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //跟单总收益
                    Text('${LocaleKeys.follow44.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                    SizedBox(height: 2.h),
                    Text(model.followProfitStr, style: AppTextStyle.f_13_500.color4D4D4D),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('${LocaleKeys.follow255.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                    SizedBox(height: 2.h),
                    Text(model.avgHoldAmountStr, style: AppTextStyle.f_13_500.color4D4D4D),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //跟单次数
                      Text(LocaleKeys.follow256.tr, style: AppTextStyle.f_11_400.color999999),
                      SizedBox(height: 2.h),
                      Text(model.followCountStr, style: AppTextStyle.f_13_500.color4D4D4D),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(LocaleKeys.follow257.tr, style: AppTextStyle.f_11_400.color999999),
                      SizedBox(height: 2.h),
                      Text(model.followTypeStr, style: AppTextStyle.f_13_500.color4D4D4D),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${LocaleKeys.follow258.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                      SizedBox(height: 2.h),
                      Text(model.singleTotalStr, style: AppTextStyle.f_13_500.color4D4D4D),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('${LocaleKeys.follow78.tr} (USDT)', style: AppTextStyle.f_11_400.color999999),
                      SizedBox(height: 2.h),
                      Text(model.maxFollowAmountStr, style: AppTextStyle.f_13_500.color4D4D4D),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowCurrentDetailTabbar extends StatelessWidget {
  const FollowCurrentDetailTabbar({super.key, required this.dataArray, this.callBack, required this.currentIndex});
  final List<String> dataArray;
  final int currentIndex;
  final Function(int index)? callBack;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        // color: Colors.red,
        // height: 56.w,
        margin: EdgeInsets.only(top: 16.h),
        padding: const EdgeInsets.only(left: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: dataArray
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: MyButton(
                        height: 24.w,
                        text: e,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        color: e == dataArray[currentIndex] ? AppColor.color111111 : AppColor.colorABABAB,
                        textStyle: AppTextStyle.f_12_500,
                        borderRadius: BorderRadius.circular(50),
                        backgroundColor: e == dataArray[currentIndex] ? AppColor.colorF1F1F1 : Colors.transparent,
                        // border: Border.all(
                        //     color: e == dataArray[currentIndex] ? AppColor.color111111 : AppColor.colorEEEEEE, width: 1.w),
                        onTap: () {
                          if (e != dataArray[currentIndex]) {
                            callBack?.call(dataArray.indexOf(e));
                          }
                        },
                      ),
                    ),
                  )
                  .toList()
              //     // ),
              ),
        ),
      ),
    );
  }
}

class MyFollowStudy extends StatelessWidget {
  const MyFollowStudy({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsGetx>(builder: (c) {
      return Column(
        children: <Widget>[
          Text(
              '${LocaleKeys.assets159.tr}${c.followInfoModel.followBalance == 0 ? '0.00' : NumberUtil.mConvert(c.followInfoModel.followBalance, isEyeHide: true, isRate: null, count: 2)} USDT',
              style: AppTextStyle.f_15_500.color111111),
          12.verticalSpace,
          Text(LocaleKeys.assets158.tr, style: AppTextStyle.f_12_400_15.color4D4D4D).paddingOnly(bottom: 12.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showAssetsSheetView(
                      title: LocaleKeys.assets160.tr,
                      des: LocaleKeys.assets166.tr,
                      desArray: [LocaleKeys.assets167.tr, LocaleKeys.assets168.tr, LocaleKeys.assets169.tr],
                      array: [LocaleKeys.assets170.tr, LocaleKeys.assets171.tr, LocaleKeys.assets7.tr],
                      callback: (i) async {
                        if (i == 0) {
                          RouteUtil.goTo('/otc-b2c');
                        } else if (i == 1) {
                          Get.toNamed(Routes.ASSETS_DEPOSIT, arguments: 'USDT');
                        } else {
                          try {
                            final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {"from": 3, "to": 0});
                            if (res) {
                              UIUtil.showSuccess(LocaleKeys.assets10.tr);
                              AssetsGetx.to.getTotalAccountBalance();
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                      });
                },
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(13.w),
                        margin: EdgeInsets.only(bottom: 10.w),
                        decoration: const ShapeDecoration(
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                          ),
                        ),
                        child: MyImage(
                          'assets/asset_deposit'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                        )),
                    Text(LocaleKeys.assets160.tr, style: AppTextStyle.f_12_400.color4D4D4D).paddingSymmetric(horizontal: 27.w)
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.helpHowToCopyTradeCenter});
                },
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(13.w),
                        margin: EdgeInsets.only(bottom: 10.w),
                        decoration: const ShapeDecoration(
                          shape: OvalBorder(
                            side: BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                          ),
                        ),
                        child: MyImage(
                          'assets/assets_study'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                        )),
                    Text(LocaleKeys.assets161.tr, style: AppTextStyle.f_12_400.color4D4D4D).paddingSymmetric(horizontal: 27.w)
                  ],
                ),
              )
            ],
          )
        ],
      );
    });
  }
}
