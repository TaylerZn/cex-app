import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/notify/system_notify/widget/system_notify_item_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/system_notify_list_controller.dart';

class SystemNotifyListView extends GetView<SystemNotifyListController> {
  const SystemNotifyListView({super.key});
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoadMore,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return SystemNotifyItemWidget(
            messageInfo: controller.dataList[index],
          );
        },
        itemCount: controller.dataList.length,
      ),
    );
  }
}
