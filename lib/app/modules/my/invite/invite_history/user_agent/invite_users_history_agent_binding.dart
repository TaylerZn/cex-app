import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/user_agent/invite_users_history_agent_controller.dart';

// import 'invite_users_history_agent_controller.dart';

class InviteUsersHistoryAgentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteUsersHistoryAgentController());
  }
}
