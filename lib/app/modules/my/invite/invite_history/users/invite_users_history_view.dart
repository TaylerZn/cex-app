import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/users/Invite_user_item_widget/Invite_user_item_widget.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/users/Invite_user_item_widget/invite_user_filter_button.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/users/invite_users_history_controller.dart';

import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/common_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InviteUsersHistoryView extends GetView<InviteUsersHistoryController> {
  const InviteUsersHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                return InviteUserFilterButton(
                    title: controller.orderType.value?.name ??
                        LocaleKeys.assets108.tr,
                    onTap: () async {
                      InvitefilterType? res =
                          await showUserHistoryFilterTypeBottomSheet(
                              orderType: controller.orderType.value);
                      if (res != null) {
                        controller.changeOrderType(res);
                      }
                    });
              }),
            ],
          ),
        ),
        Expanded(
          child: controller.pageObx(
            (data) {
              return SmartRefresher(
                controller: controller.refreshController,
                onRefresh: () => controller.refreshData(true),
                onLoading: controller.loadMoreData,
                enablePullUp: true,
                child: ListView.builder(
                  itemCount: data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InviteUserItemWidget(
                      user: data![index],
                    );
                  },
                ),
              );
            },
            onRetryRefresh: () => controller.refreshData(false),
          ),
        ),
      ],
    );
  }
}
