import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/handling_fee/widgets/invite_history_handling_fee_wiget.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/user_agent/invite_users_history_agent_controller.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/users/Invite_user_item_widget/Invite_user_item_widget.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/widget/invite_users_history_agent_user_type_stat_chart.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/widget/invite_users_history_second_tab_bar.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InviteUsersHistoryAgentView
    extends GetView<InviteUsersHistoryAgentController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InviteuserHistorySecondTabBar(
          titles: controller.titles,
          tabController: controller.tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            physics: NeverScrollableScrollPhysics(), //不让滑
            children: [
              KeepAliveWrapper(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 24.w, 16.h),
                child: _buildInviteListView(),
              )),
              KeepAliveWrapper(
                  child: InviteUsersHistoryAgentUserTypeStatChart()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInviteListView() {
    return controller.pageObx(
      (data) {
        return SmartRefresher(
          controller: controller.refreshController,
          onRefresh: () => controller.refreshData(true),
          onLoading: controller.loadMoreData,
          enablePullUp: true,
          child: ListView.builder(
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: InviteUserItemWidget(
                  user: data![index],
                ),
              );
            },
          ),
        );
      },
      onRetryRefresh: () => controller.refreshData(false),
    );
  }
}
