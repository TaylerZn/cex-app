import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/follow/widgets/invite_history_follow_widget.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../controllers/invite_history_follow_controller.dart';

class InviteHistoryFollowView extends GetView<InviteHistoryFollowController> {
  const InviteHistoryFollowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child:
            GetBuilder<InviteHistoryFollowController>(builder: (controller) {
          return SmartRefresher(
              controller: controller.refreshVc,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () async {
                controller.pageIndex = 1;

                await controller.getdataList();
                controller.refreshVc.refreshToIdle();
              },
              onLoading: () async {
                if (controller.haveMore) {
                  controller.pageIndex++;
                  await controller.getdataList();
                  controller.refreshVc.loadComplete();
                } else {
                  controller.refreshVc.loadNoData();
                }
              },
              child: MyPageLoading(
                  controller: controller.loadingController.value,
                  body: WaterfallFlow.builder(
                      padding: EdgeInsets.all(16.w),
                      shrinkWrap: true,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      gridDelegate:
                          SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0.w,
                        mainAxisSpacing: 10.h,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.dataList.length,
                      itemBuilder: (context, index) {
                        return InviteHistoryFollowWidget(
                            item: controller.dataList[index]);
                      })));
        }))
      ],
    );
  }
}
