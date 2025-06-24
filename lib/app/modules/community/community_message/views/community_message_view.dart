import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/community/community_message/widgets/community_message_item.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/community_message_controller.dart';

class CommunityMessageView extends GetView<CommunityMessageController> {
  const CommunityMessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        title: Text(LocaleKeys.user221.tr), //消息,
        centerTitle: true,
      ),
      body: controller.pageObx(
        (data) {
          return SmartRefresher(
            controller: controller.refreshController,
            enablePullDown: false,
            enablePullUp: false,
            onRefresh: () async {
              await controller.refreshData(true);
            },
            onLoading: () async {
              await controller.loadMoreData();
            },
            child: ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, index) {
                final message = data?[index];
                return CommunityMessageItem(message: message!);
              },
            ),
          );
        },
        onRetryRefresh: () => controller.refreshData(false),
      ),
    );
  }
}
