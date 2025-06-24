import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_my_star/model/follow_my_star_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_block/model/follow_kol_relation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowMyStarController extends GetxController with GetTickerProviderStateMixin {
  List<FollowMyStarType> navTabs = [FollowMyStarType.trader, FollowMyStarType.card];
  late TabController tabController;
  int currentIndex = 0;
  var model = FollowkolRelationListModel().obs;
  TextEditingController? textVC;
  RefreshController refreshVc = RefreshController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: navTabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future? getData({bool isPullDown = false}) async {
    if (isPullDown) {
      model.value.page = 1;
    } else {
      if (model.value.list != null && model.value.page == 1) return null;
    }

    int page = model.value.page;
    var value = await AFFollow.getMyRelationList(pageNo: page, pageSize: model.value.pageSize);
    var pageSize = value.list?.length;
    if (page != 1) {
      model.value.list?.addAll(value.list!);
      value.list = model.value.list;
    }
    model.value = value;
    model.value.page = page;
    model.value.haveMore = pageSize == model.value.pageSize;

    return model;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
