// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/controllers/follow_orders_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_nav.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_grid.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_item.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_tabbar.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_top.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:sliver_tools/sliver_tools.dart';

//

class FollowOrdersTableView extends StatelessWidget {
  const FollowOrdersTableView({super.key, required this.controller});
  final FollowOrdersController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FollowOrdersCustomerTop(controller: controller),
        Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.model.mainTabController,
                children: controller.model.mainTabs.map((type) {
                  return type == FollowOrdersNavType.explore
                      ? KeepAliveWrapper(
                          child: SmartRefresher(
                            controller: controller.model.mainTabsRefreshController.first,
                            enablePullUp: true,
                            onRefresh: () async {
                              await controller.getExploreData(isPullDown: true);

                              controller.model.mainTabsRefreshController.first.refreshToIdle();
                              controller.model.mainTabsRefreshController.first.loadComplete();
                            },
                            onLoading: () async {
                              var currentModel = controller.model.exploreTabsModelArr[controller.model.focusCurrentIndex.value];

                              if (currentModel.value.haveMore) {
                                currentModel.value.page++;
                                await controller.getExploreData();
                                controller.model.mainTabsRefreshController.first.loadComplete();
                              } else {
                                controller.model.mainTabsRefreshController.first.loadNoData();
                              }
                            },
                            child: CustomScrollView(
                              key: PageStorageKey<String>(type.value),
                              slivers: [
                                FollowOrdersTop(controller: controller),
                                FollowOrdersCustomerMid(controller: controller),
                                ...controller.model.traderType.map((e) => FollowOrdersGridView(controller: controller, type: e))
                              ],
                            ),
                          ),
                        )
                      : KeepAliveWrapper(
                          child: PullToRefreshNotification(
                            onRefresh: () async {
                              await controller.getData(isPullDown: true);
                              //1
                              return true;
                            },
                            maxDragOffset: 100,
                            child: GlowNotificationWidget(
                              ExtendedNestedScrollView(
                                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                                  return <Widget>[
                                    PullToRefreshContainer(
                                      (PullToRefreshScrollNotificationInfo? info) {
                                        return SliverToBoxAdapter(
                                          child: PullToRefreshHeader(info),
                                        );
                                      },
                                    ),
                                    SliverPadding(
                                      padding: EdgeInsets.only(bottom: 20.w),
                                      sliver: FollowOrdersTop(controller: controller),
                                    ),
                                    SliverPinnedHeader(
                                      child: FollowOrdersFutureTabbar(
                                          controller: controller.model.futureTabController,
                                          dataArray: controller.model.futureTabs.map((e) => e.value).toList()),
                                    ),
                                  ];
                                },
                                pinnedHeaderSliverHeightBuilder: () {
                                  return 0;
                                },
                                body: TabBarView(
                                  controller: controller.model.futureTabController,
                                  children: controller.model.futureTabs.map((type) {
                                    var refresh = controller.model.futureTabsRefreshArray[type.index];

                                    return Obx(() {
                                      var filterIndex = controller.model.futureFilteIndexArray[type.index];
                                      var cellModel = controller.model.futureTabsModelArr[type.index][filterIndex.value];

                                      return Column(
                                        children: [
                                          FollowOrdersFutureSelect(
                                              dataArray: controller.model.futureFilter.map((e) => e.value).toList(),
                                              currentIndex: filterIndex.value,
                                              callback: (i) {
                                                filterIndex.value = i;
                                                controller.getFutureData();
                                              }),
                                          cellModel.value.list?.isNotEmpty == true
                                              ? Expanded(
                                                  child: Builder(
                                                    builder: (BuildContext context) {
                                                      return SmartRefresher(
                                                        controller: refresh,
                                                        enablePullDown: false,
                                                        enablePullUp: true,
                                                        onLoading: () async {
                                                          if (cellModel.value.haveMore) {
                                                            cellModel.value.page++;
                                                            await controller.getFutureData();
                                                            refresh.loadComplete();
                                                          } else {
                                                            refresh.loadNoData();
                                                          }
                                                        },
                                                        child: CustomScrollView(
                                                          physics: const ClampingScrollPhysics(),
                                                          key: PageStorageKey<String>(type.value),
                                                          slivers: <Widget>[FollowOrderFutureList(list: cellModel.value.list!)],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                              : Expanded(
                                                  child: FollowOrdersLoading(
                                                      isSliver: false,
                                                      isError: cellModel.value.isError,
                                                      onTap: () {
                                                        controller.getData(isPullDown: true);
                                                      }),
                                                )
                                        ],
                                      );
                                    });
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        );
                }).toList())),
      ],
    );
  }
}

class FollowOrderFutureList extends StatelessWidget {
  const FollowOrderFutureList({super.key, required this.list, this.controller});

  final List<FollowKolInfo> list;
  final FollowOrdersController? controller;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.w),
            child: FollowOrdersItem(
              model: list[index],
              index: index,
              controller: controller,
            ),
          );
        },
        childCount: list.length,
      ),
    );
  }
}
