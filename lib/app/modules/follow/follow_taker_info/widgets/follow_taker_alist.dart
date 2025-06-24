import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/controllers/community_list_controller.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/views/community_list_view.dart';
import 'package:nt_app_flutter/app/modules/community/favourite_list/controllers/favourite_list_controller.dart';
import 'package:nt_app_flutter/app/modules/community/favourite_list/views/favourite_list_view.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/controllers/follow_taker_info_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_taker_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_cell.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_item.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_mixin.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_top.dart';
import 'package:nt_app_flutter/app/utils/utilities/tag_cache_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//

class TraderDetailList extends StatelessWidget with FollowShare {
  const TraderDetailList(
      {super.key, required this.type, required this.controller});

  final FollowTakerType type;
  final FollowTakerInfoController controller;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case FollowTakerType.overview:
        {
          String listtag = TagCacheUtil().saveTag('CommunityListController');

          var communityVC = CommunityListController(
            uid: controller.detailModel.value.uid,
            myPage: true,
            tagKey: listtag,
            isGetInterestPeople: true,
            isCmplete: (p) {
              controller.overviwHaveMoreData = p;
            },
          );
          return SmartRefresher(
            controller: controller.overviwRefreshVc,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () async {
              await controller.getData(isPullDown: true);
              controller.overviwRefreshVc.refreshToIdle();
              controller.overviwRefreshVc.loadComplete();
            },
            onLoading: () async {
              if (controller.overviwHaveMoreData) {
                await communityVC.onLoading();
                controller.overviwRefreshVc.loadComplete();
              } else {
                controller.overviwRefreshVc.loadNoData();
              }
            },
            child: CustomScrollView(
              key: PageStorageKey<String>(type.value),
              slivers: [
                Obx(() =>
                    controller.expression.value.monthProfit?.isNotEmpty == true
                        ? SliverToBoxAdapter(
                            child: FollowTakerOverviewCell(
                                controller.expression.value,
                                controller: controller))
                        : FollowOrdersLoading(
                            isError: controller.expression.value.isError,
                            onTap: () {
                              controller.getData(isPullDown: true);
                            })),
                GetBuilder<CommunityListController>(
                    init: communityVC,
                    tag: listtag,
                    builder: (c) {
                      return CommunityListView(
                          tagKey: '',
                          isFromFollowName:
                              controller.detailModel.value.userName);
                    })
              ],
            ),
          );
        }

      case FollowTakerType.performance:
        return controller.viewType.index < 3
            ? FollowTakerMiddleView(type: controller.viewType)
            : SmartRefresher(
                controller: controller.expressionRefreshVc,
                enablePullDown: true,
                onRefresh: () async {
                  await controller.getData(isPullDown: true);
                  controller.expressionRefreshVc.refreshToIdle();
                  controller.expressionRefreshVc.loadComplete();
                },
                child: CustomScrollView(
                  key: PageStorageKey<String>(type.value),
                  slivers: [
                    Obx(() =>
                        controller.expression.value.monthProfit?.isNotEmpty ==
                                true
                            ? SliverToBoxAdapter(
                                child: FollowTakerExpressCell(
                                    controller.expression.value,
                                    controller: controller))
                            : FollowOrdersLoading(
                                isError: controller.expression.value.isError,
                                onTap: () {
                                  controller.getData(isPullDown: true);
                                }))
                  ],
                ),
              );
      case FollowTakerType.currentSingle:
        return !controller.showView
            ? FollowTakerMiddleView(type: controller.viewType)
            : SmartRefresher(
                controller: controller.currentOrderRefreshVc,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  await controller.getData(isPullDown: true);
                  controller.currentOrderRefreshVc.refreshToIdle();
                  controller.currentOrderRefreshVc.loadComplete();
                },
                onLoading: () async {
                  if (controller.currentOrder.value.haveMore) {
                    controller.currentOrder.value.page++;
                    await controller.getData();
                    controller.currentOrderRefreshVc.loadComplete();
                  } else {
                    controller.currentOrderRefreshVc.loadNoData();
                  }
                },
                child: CustomScrollView(
                  key: PageStorageKey<String>(type.value),
                  slivers: [
                    Obx(() => controller.currentOrder.value.list?.isNotEmpty ==
                            true
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (content, index) {
                              return FollowTakerCurrentDetailCell(
                                  controller.currentOrder.value.list![index],
                                  controller: controller);
                            },
                                childCount:
                                    controller.currentOrder.value.list!.length),
                          )
                        : FollowOrdersLoading(
                            isError: controller.currentOrder.value.isError,
                            onTap: () {
                              controller.getData(isPullDown: true);
                            }))
                  ],
                ),
              );

      case FollowTakerType.historySingle:
        return !controller.showHistoryView
            ? FollowTakerMiddleView(type: controller.viewType)
            : SmartRefresher(
                controller: controller.historyOrderRefreshVc,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  await controller.getData(isPullDown: true);
                  controller.historyOrderRefreshVc.refreshToIdle();
                  controller.historyOrderRefreshVc.loadComplete();
                },
                onLoading: () async {
                  if (controller.historyOrder.value.haveMore) {
                    controller.historyOrder.value.page++;
                    await controller.getData();
                    controller.historyOrderRefreshVc.loadComplete();
                  } else {
                    controller.historyOrderRefreshVc.loadNoData();
                  }
                },
                child: CustomScrollView(
                  key: PageStorageKey<String>(type.value),
                  slivers: [
                    Obx(() => controller.historyOrder.value.list?.isNotEmpty ==
                            true
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (content, index) {
                              return FollowTakerHistoryDetailCell(
                                  controller.detailModel.value.uid,
                                  controller.historyOrder.value.list![index],
                                  controller: controller);
                            },
                                childCount:
                                    controller.historyOrder.value.list!.length),
                          )
                        : FollowOrdersLoading(
                            isError: controller.historyOrder.value.isError,
                            onTap: () {
                              controller.getData(isPullDown: true);
                            }))
                  ],
                ),
              );
      case FollowTakerType.follower:
        return !controller.showFollowView
            ? FollowTakerMiddleView(
                type: controller.viewType, takerType: FollowTakerType.follower)
            : SmartRefresher(
                controller: controller.followerRefreshVc,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  await controller.getData(isPullDown: true);
                  controller.followerRefreshVc.refreshToIdle();
                  controller.followerRefreshVc.loadComplete();
                },
                onLoading: () async {
                  if (controller.follower.value.haveMore) {
                    controller.follower.value.page++;
                    await controller.getData();
                    controller.followerRefreshVc.loadComplete();
                  } else {
                    controller.followerRefreshVc.loadNoData();
                  }
                },
                child: CustomScrollView(
                  key: PageStorageKey<String>(type.value),
                  slivers: [
                    Obx(() => controller.follower.value.list?.isNotEmpty == true
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (content, index) {
                              return FollowTakerFollowDetailCell(
                                  controller.follower.value.list![index],
                                  controller: controller);
                            },
                                childCount:
                                    controller.follower.value.list!.length),
                          )
                        : FollowOrdersLoading(
                            isError: controller.follower.value.isError,
                            onTap: () {
                              controller.getData(isPullDown: true);
                            }))
                  ],
                ),
              );

      case FollowTakerType.userReview:
        return !controller.showFollowView
            ? FollowTakerMiddleView(
                type: controller.viewType,
                takerType: FollowTakerType.userReview)
            : SmartRefresher(
                controller: controller.commentRefreshVc,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  await controller.getData(isPullDown: true);
                  controller.commentRefreshVc.refreshToIdle();
                  controller.commentRefreshVc.loadComplete();
                },
                onLoading: () async {
                  if (controller.comment.value.haveMore) {
                    controller.comment.value.page++;
                    await controller.getData();
                    controller.commentRefreshVc.loadComplete();
                  } else {
                    controller.commentRefreshVc.loadNoData();
                  }
                },
                child: CustomScrollView(
                  key: PageStorageKey<String>(type.value),
                  slivers: [
                    Obx(() =>
                        controller.comment.value.records?.isNotEmpty == true
                            ? FollowTakerUserRatingList(
                                controller: controller,
                                model: controller.comment.value,
                                haveDecoration: false)
                            : FollowOrdersLoading(
                                isError: controller.comment.value.isError,
                                onTap: () {
                                  controller.getData(isPullDown: true);
                                }))
                  ],
                ),
              );
      case FollowTakerType.likeFavourite:
        return (controller.viewType == FollowViewType.mySelfToCustomer ||
                controller.viewType == FollowViewType.mySelfToTrader)
            ? GetBuilder<FavouriteListController>(
                init: FavouriteListController(),
                builder: (controller) {
                  return FavouriteListView();
                })
            : FollowTakerMiddleView(type: controller.viewType);

      default:
        return const SizedBox();
    }
  }
}
