import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/follow_kol_apply.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_block/model/follow_kol_relation.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/my_shield_enum.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyTakeBlockController extends GetxController {
  MyTakeShieldActionType type = MyTakeShieldActionType.blacklist;
  var model = FollowkolRelationListModel().obs;
  RefreshController refreshVC = RefreshController();
  Rx<FollowkolApplyModel> applyOrder = FollowkolApplyModel().obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    type = Get.arguments['type'];
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

//0标星  1黑名单 2禁用名单
  Future? getData({bool isPullDown = false}) async {
    if (type == MyTakeShieldActionType.applyFor) {
      if (isPullDown) {
        applyOrder.value.page = 1;
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
    } else {
      if (isPullDown) {
        model.value.page = 1;
      }
      int types = type == MyTakeShieldActionType.blacklist ? 1 : 2;
      int page = model.value.page;
      var value = await AFFollow.getMyRelationList(types: types, pageNo: page, pageSize: model.value.pageSize);
      var pageSize = value.list?.length;

      if (page != 1) {
        model.value.list?.addAll(value.list!);
        value.list = model.value.list;
      }
      model.value = value;
      model.value.page = page;
      model.value.haveMore = pageSize == model.value.pageSize;

      return null;
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

  setTraceUserRelation({required num userId, required int types}) {
    //status  0取消 1设置
    // type 0标星  1拉黑 2禁止跟单

    AFFollow.setTraceUserRelation(userId: userId, status: 0, types: types).then((value) {
      if (value == null) {
        UIUtil.showSuccess(LocaleKeys.follow119.tr);
        model.update((val) {
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
