import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/users/Invite_user_item_widget/invite_user_filter_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class InviteUsersHistoryController extends GetListController<InviteUserItem> {
  Rxn<InvitefilterType> orderType = Rxn<InvitefilterType>(null);
  String sort = '';
  String order = '';

  @override
  Future<List<InviteUserItem>> fetchData() async {
    if (orderType.value?.type != null) {
      switch (orderType.value!.type!) {
        case 1: //全部
          sort = '';
          order = '';
          break;
        case 2:
          sort = 'iniviteDate';
          order = 'desc';
          break;
        case 3:
          sort = 'iniviteDate';
          order = 'asc';
          break;
        case 4:
          sort = 'bonusAmount';
          order = 'asc';
        case 5:
          sort = 'bonusAmount';
          order = 'desc';
          break;
        default:
          sort = '';
          order = '';
          break;
      }
    }

    try {
      InviteUserListModel? res = await UserApi.instance().agentNewUserList(
        pageSize.toString(),
        pageIndex.toString(),
        sort, // Default sorting by time desc
        order,
      );
      return res?.list as List<InviteUserItem> ?? [];
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    refreshData(false);
  }

  void changeOrderType(InvitefilterType res) {
    if (orderType.value == res) {
      return;
    }
    orderType.value = res;
    refreshData(false);
  }
}
