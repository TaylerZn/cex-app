import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/users/invite_users_history_controller.dart';

class InviteUsersHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InviteUsersHistoryController());
  }
}
