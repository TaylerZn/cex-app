import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/community_message_notification_controller.dart';
import '../widgets/community_message_notification_item.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';

class CommunityMessageNotificationView
    extends GetView<CommunityMessageNotificationController> {
  const CommunityMessageNotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.public38.tr), //社区,
          centerTitle: true,
        ),
        body: Obx(() => _buildListView()));
  }

  Widget _buildListView() {
    return controller.pageObx(
      (state) {
        return SmartRefresher(
          controller: controller.refreshController,
          onRefresh: () => controller.refreshData(true),
          onLoading: controller.loadMoreData,
          enablePullUp: true,
          enablePullDown: true,
          child: ListView.builder(
            itemCount: state?.length ?? 0,
            itemBuilder: (context, index) {
              return CommunityMessageNotificationItem(
                message: state![index],
              );
            },
          ),
        );
      },
      onRetryRefresh: () => controller.refreshData(false),
    );
  }
}
