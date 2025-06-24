import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/follow/controllers/invite_history_follow_controller.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/handing_fee_agent/invite_history_handling_fee_agent_view_controller.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/handling_fee/controllers/invite_history_handling_fee_controller.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/user_agent/invite_users_history_agent_controller.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/users/invite_users_history_controller.dart';
import '../controllers/invite_history_main_controller.dart';

class InviteHistoryMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InviteHistoryHandlingFeeController>(
      () => InviteHistoryHandlingFeeController(),
    );
    // Get.lazyPut<InviteHistoryFollowController>(
    //   () => InviteHistoryFollowController(),
    // );

    Get.lazyPut<InviteUsersHistoryController>(
      () => InviteUsersHistoryController(),
    );
    Get.lazyPut<InviteHistoryMainController>(
      () => InviteHistoryMainController(),
    );

    Get.lazyPut<InviteHistoryHandlingFeeAgentViewController>(
      () => InviteHistoryHandlingFeeAgentViewController(),
    );

    Get.lazyPut<InviteUsersHistoryAgentController>(
      () => InviteUsersHistoryAgentController(),
    );
  }
}
