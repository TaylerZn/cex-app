import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_alist.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_nav.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../controllers/follow_orders_controller.dart';

//

class FollowOrdersView extends GetView<FollowOrdersController> {
  const FollowOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowOrdersController>(builder: (controller) {
      return VisibilityDetector(
        key: Key(controller.runtimeType.toString()),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 1) {
            controller.startGuide();
          }
        },
        child: Scaffold(
            backgroundColor: AppColor.colorWhite,
            appBar: followOrdersNav(enabled: controller.model.complete == true ? true : false),
            body: controller.model.complete == null
                // ? const FollowOrdersShimmer()
                ? FollowOrdersTableView(controller: controller)
                : controller.model.complete == true
                    ? FollowOrdersTableView(controller: controller)
                    : FollowOrdersLoading(
                        isSliver: false,
                        isError: true,
                        onTap: () {
                          controller.getInfoData(UserGetx.to.user?.info?.isKol ?? false);
                        },
                      )),
      );
    });
  }

  // Widget getTraderView() {
  //   return PullToRefreshNotification(
  //     onRefresh: () async {
  //       await controller.getData(isPullDown: true);
  //       return true;
  //     },
  //     maxDragOffset: 100,
  //     child: GlowNotificationWidget(
  //       ExtendedNestedScrollView(
  //         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
  //           return <Widget>[
  //             PullToRefreshContainer(
  //               (PullToRefreshScrollNotificationInfo? info) {
  //                 return SliverToBoxAdapter(
  //                   child: PullToRefreshHeader(info),
  //                 );
  //               },
  //             ),
  //             FollowOrdersTop(controller: controller),
  //             ...getView(),
  //             SliverPinnedHeader(
  //               child: FollowOrdersTabbar(
  //                   marginTop: 0,
  //                   marginBottom: 0,
  //                   labelStyle: AppTextStyle.f_12_500,
  //                   unselectedLabelStyle: AppTextStyle.f_12_500,
  //                   controller: controller.model.tabController,
  //                   dataArray: controller.model.tabs.map((e) => e.value).toList()),
  //             )
  //           ];
  //         },
  //         pinnedHeaderSliverHeightBuilder: () {
  //           return 0;
  //         },
  //         body: TabBarView(
  //           controller: controller.model.tabController,
  //           children: controller.model.tabs.map((type) {
  //             var cellModel = controller.model.tabsModel[type.index];
  //             var refresh = controller.model.tabsRefreshController[type.index];
  //             return Obx(() => cellModel.value.list?.isNotEmpty == true
  //                 ? Builder(
  //                     builder: (BuildContext context) {
  //                       return SmartRefresher(
  //                         controller: refresh,
  //                         enablePullDown: false,
  //                         enablePullUp: true,
  //                         onLoading: () async {
  //                           if (cellModel.value.haveMore) {
  //                             cellModel.value.page++;
  //                             await controller.getData();
  //                             refresh.loadComplete();
  //                           } else {
  //                             refresh.loadNoData();
  //                           }
  //                         },
  //                         child: CustomScrollView(
  //                           physics: const ClampingScrollPhysics(),
  //                           key: PageStorageKey<String>(type.value),
  //                           slivers: <Widget>[
  //                             // SliverOverlapInjector(
  //                             //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
  //                             // ),
  //                             FollowOrdersList(type: type, list: cellModel.value.list!)
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                   )
  //                 : FollowOrdersLoading(
  //                     isSliver: false,
  //                     isError: cellModel.value.isError,
  //                     onTap: () {
  //                       controller.getData(isPullDown: true);
  //                     }));
  //           }).toList(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // List<Widget> getView() {
  //   List<Widget> array = [];
  //   if (controller.isTrader) {
  //     array.add(FollowOrdersGroupList(type: TakerListType.allTraders, controller: controller));
  //   } else {
  //     if (controller.model.hotList != null && controller.model.hotList!.isNotEmpty) {
  //       array.add(FollowOrdersGroupList(
  //           type: TakerListType.hotTraders,
  //           des: LocaleKeys.follow5.tr,
  //           list: controller.model.hotList!,
  //           controller: controller));
  //     }
  //     if (controller.model.steadyList != null && controller.model.steadyList!.isNotEmpty) {
  //       array.add(FollowOrdersGroupList(
  //           type: TakerListType.steadyTrader,
  //           des: LocaleKeys.follow6.tr,
  //           list: controller.model.steadyList!,
  //           controller: controller));
  //     }

  //     if (controller.model.tenThousandfoldList != null && controller.model.tenThousandfoldList!.isNotEmpty) {
  //       array.add(FollowOrdersGroupList(
  //           type: TakerListType.foldTraders,
  //           des: LocaleKeys.follow7.tr,
  //           list: controller.model.tenThousandfoldList!,
  //           controller: controller));
  //     }

  //     array.add(FollowOrdersGroupList(type: TakerListType.allTraders, controller: controller));
  //   }

  //   return array;
  // }
}
