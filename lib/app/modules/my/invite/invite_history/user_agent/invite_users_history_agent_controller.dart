import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InviteUsersHistoryAgentController
    extends GetListController<InviteUserItem>
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final titles = [
    LocaleKeys.user287.tr,
    LocaleKeys.user288.tr,
  ];

  @override
  Future<List<InviteUserItem>> fetchData() async {
    try {
      InviteUserListModel? res = await UserApi.instance().agentNewUserList(
        pageSize.toString(),
        pageIndex.toString(),
        '', // Default sorting by time desc
        '',
      );
      return res?.list ?? [];
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: titles.length, vsync: this);
    super.onInit();
    refreshData(false);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
