import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_cell.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/follow_user_review_controller.dart';

class FollowUserReviewView extends GetView<FollowUserReviewController> {
  const FollowUserReviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('用户评价'),
          centerTitle: true,
        ),
        body: SmartRefresher(
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
            slivers: [
              Obx(() => controller.comment.value.records?.isNotEmpty == true
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate((content, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child:
                              FollowReviewCell(maxLines: 4, haveAction: true, model: controller.comment.value.records![index]),
                        );
                      }, childCount: controller.comment.value.records!.length),
                    )
                  : FollowOrdersLoading(
                      isError: controller.comment.value.isError,
                      onTap: () {
                        controller.getData(isPullDown: true);
                      }))
            ],
          ),
        ));
  }
}
