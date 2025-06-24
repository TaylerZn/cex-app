import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/follow_kol_apply.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_manage_list.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/my_shield_enum.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyTakeShieldController extends GetxController with GetTickerProviderStateMixin {
  late FollowKolTraderInfoModel infoModel;

  List actionDisplayList = [LocaleKeys.follow217.tr, LocaleKeys.follow218.tr];
  List<MyTakeShieldType> tabs = [MyTakeShieldType.copycatUser, MyTakeShieldType.applicationUser];

  late TabController tabController;
  var currentIndex = 0.obs;

  Rx<FollowMyManageListModel> currentOrder = FollowMyManageListModel().obs;
  RefreshController currentOrderRefreshVc = RefreshController();

  Rx<FollowkolApplyModel> applyOrder = FollowkolApplyModel().obs;
  RefreshController historyOrderRefreshVc = RefreshController();

  TextEditingController textVC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    infoModel = Get.arguments['model'];
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex.value = tabController.index;

        getData();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future? getData({bool isPullDown = false}) {
    var type = tabs[currentIndex.value];
    switch (type) {
      case MyTakeShieldType.copycatUser:
        if (isPullDown) {
          currentOrder.value.page = 1;
        } else {
          if (currentOrder.value.list != null && currentOrder.value.page == 1) return null;
        }
        return AFFollow.getMyFollowManageList(
          listType: 0,
          traderId: UserGetx.to.user?.info?.id ?? 0,
          page: currentOrder.value.page,
          pageSize: currentOrder.value.pageSize,
        ).then((value) {
          int page = currentOrder.value.page;
          var pageSize = value.list?.length;

          if (page != 1) {
            currentOrder.value.list?.addAll(value.list!);
            value.list = currentOrder.value.list;
          }
          currentOrder.value = value;
          currentOrder.value.page = page;
          currentOrder.value.haveMore = pageSize == currentOrder.value.pageSize;
        });

      default:
        if (isPullDown) {
          applyOrder.value.page = 1;
        } else {
          if (applyOrder.value.list != null && applyOrder.value.page == 1) return null;
        }
        return AFFollow.getMyFollowApply(
          traderId: UserGetx.to.user?.info?.id ?? 0,
          page: applyOrder.value.page,
          pageSize: applyOrder.value.pageSize,
        ).then((value) {
          int page = applyOrder.value.page;
          var pageSize = value.list?.length;

          if (page != 1) {
            applyOrder.value.list?.addAll(value.list!);
            value.list = applyOrder.value.list;
          }
          applyOrder.value = value;
          applyOrder.value.page = page;
          applyOrder.value.haveMore = pageSize == applyOrder.value.pageSize;
        });
    }
  }

  setTraceUserRelation({required num userId, required int types}) {
    //status  0取消 1设置
    // type 0标星  1拉黑 2禁止跟单

    AFFollow.setTraceUserRelation(userId: userId, status: 1, types: types).then((value) {
      if (value == null) {
        UIUtil.showSuccess(LocaleKeys.follow119.tr);
        currentOrder.update((val) {
          val?.list?.removeWhere((element) => element.uid == userId);
        });
      } else {
        UIUtil.showToast(LocaleKeys.follow120.tr);
      }
    });
  }

  setUserRatr({required List uids}) {
    num positionRate = num.parse(textVC.text);
    var str = jsonEncode(uids);
    print('-----uids: ${jsonEncode(uids)} positionRate: $positionRate');

    AFFollow.positionSetting(uids: jsonEncode(uids), positionRate: positionRate).then((value) {
      if (value == null) {
        currentOrder.update((val) {
          val?.list?.forEach((model) {
            if (uids.contains(model.uid)) {
              model.positionRate = positionRate;
            }
          });
        });
        UIUtil.showSuccess(LocaleKeys.follow119.tr);
      } else {
        UIUtil.showToast(LocaleKeys.follow120.tr);
      }
    });
  }

  postAllUser() {
    var model = currentOrder.value;
    var array = model.list?.where((element) => element.isSelected.value).map((e) => e.uid ?? 0).toList();
    if (array != null && array.isNotEmpty) setUserRatr(uids: array);
    model.isSelected = false;
    currentOrder.value = FollowMyManageListModel.fromJson(model.toJson());
  }

  checkIsAll() {
    if (currentIndex == 0) {
      var model = currentOrder.value;
      model.isSelectedAll.value = model.list!.every((element) => element.isSelected.value == true);
    } else {
      var model = applyOrder.value;
      model.isSelectedAll.value = model.list!.every((element) => element.isSelected.value == true);
    }
  }

  setFollowApply({required num userId, required int followStatus}) {
    //1通过2拒绝
    AFFollow.setFollowApply(userId: userId, followStatus: followStatus).then((value) {
      if (value == null) {
        UIUtil.showSuccess(LocaleKeys.follow119.tr);
        applyOrder.update((val) {
          val?.list?.removeWhere((element) => element.userId == userId);
        });
      } else {
        UIUtil.showToast(LocaleKeys.follow120.tr);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
