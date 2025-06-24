import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/community/community_list/widgets/item_row/index.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_taker_enum.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';

class FollowMemberController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement FollowMemberController
  String? uid;
  final count = 0.obs;
  FollowAction index = FollowAction.follow;
  late TabController tabController;
  late FollowViewType viewType;

  @override
  void onInit() {
    super.onInit();
    uid = Get.arguments?['uid'];
    index = Get.arguments?['index'] ?? 0;
    viewType = Get.arguments?['viewType'] ?? FollowViewType.mySelfToCustomer;
    List<FollowAction> list = viewType.followTab;
    // if(list.length == 1){
    //   list.add(FollowAction.none);
    // }
    tabController = TabController(length: list.length, vsync: this);
    tabController.index = viewType.followTab.indexOf(index);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
