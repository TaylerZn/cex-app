import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/handing_fee_agent/invite_history_handling_fee_agent_view_controller.dart';

class InviteHistoryHandlingFeeAgentViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteHistoryHandlingFeeAgentViewController());
  }
}
