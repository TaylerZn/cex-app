import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/widget/assets_overview_list.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/widget/assets_overview_mid.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/widget/assets_overview_top.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../assets/assets_overview/controllers/assets_overview_controller.dart';

class AssetsOverviewView extends GetView<AssetsOverviewController> {
  const AssetsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsOverviewController());
    return GetBuilder<AssetsGetx>(builder: (assetsGetx) {
      return GetBuilder<AssetsOverviewController>(builder: (controller) {
        return VisibilityDetector(
          key: const Key('CustomerDealView'),
          onVisibilityChanged: (info) {
            if (info.visibleFraction == 1) {
              controller.getData();
            }
          },
          child: SmartRefresher(
            controller: controller.refreshVc,
            onRefresh: () async {
              controller.getData();
              await assetsGetx.getRefresh();
              controller.refreshVc.refreshToIdle();
              controller.refreshVc.loadComplete();
            },
            child: CustomScrollView(
              slivers: [
                AssetsOverviewTop(assetsGetx: assetsGetx, controller: controller),
                AssetsOverviewMid(controller: controller),
                AssetsOverviewBottom(controller: controller),
                AssetsOverviewList(assetsGetx: assetsGetx, controller: controller),
              ],
            ),
          ),
        );
      });
    });
  }
}

//  return PullToRefreshNotification(
//       onRefresh: () async {
//         await Future.wait([assetsGetx.getRefresh()]);
//         return true;
//       },
//       maxDragOffset: 100,
//       child: GlowNotificationWidget(
//         ExtendedNestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               PullToRefreshContainer(
//                 (PullToRefreshScrollNotificationInfo? info) {
//                   return SliverToBoxAdapter(
//                     child: PullToRefreshHeader(info),
//                   );
//                 },
//               ),
//               AssetsOverviewTop(assetsGetx: assetsGetx, controller: controller),
//               AssetsOverviewMid(controller: controller),
//               AssetsOverviewBottom(controller: controller),
//             ];
//           },
//           pinnedHeaderSliverHeightBuilder: () {
//             return 0;
//           },
//           body: AssetsOverviewList(assetsGetx: assetsGetx, controller: controller),
//         ),
//       ),
//     );
