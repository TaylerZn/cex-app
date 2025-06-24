import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/community/focus.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';

import 'follow_member_controller.dart';

class FollowMemberListController
    extends GetListController<TopicFocusListModel?> {
  String tag;
  FollowMemberListController(this.tag);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    refreshData(false);
  }

  @override
  Future<List<TopicFocusListModel?>> fetchData() async {
    List<TopicFocusListModel?> list = [];
    int uid = int.tryParse(Get.find<FollowMemberController>().uid ?? '0') ?? 0;
    try {

      if(  tag.contains('follow')){
        list = await CommunityApi.instance()
            .topicFocusList('', uid, '') ??
            [];
      }else{
        list = await CommunityApi.instance()
            .fansList(uid) ??
            [];
      }

    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
    // TODO: implement fetchData
    return list;
  }
}
