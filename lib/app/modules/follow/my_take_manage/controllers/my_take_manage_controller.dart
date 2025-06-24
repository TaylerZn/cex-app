import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MyTakeManageController extends GetxController {
  List grabOrderDisplayList = [LocaleKeys.follow201.tr, LocaleKeys.follow202.tr, LocaleKeys.follow203.tr];
  String? orderShow;
  num? orderShowIndex;
  String? orderHistoryShow;
  num? orderHistoryShowIndex;
  String? orderFollowShow;
  num? orderFollowShowIndex;
  var switchOpen = false.obs;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() {
    ///抢单展示设置  0全部不可见，1，跟单用户可见2，全部可见
    AFFollow.getCopySetting(kolUid: UserGetx.to.user?.info?.id ?? 0).then((value) {
      orderShowIndex = value.copySetting;
      if (orderShowIndex != null) {
        orderShow = grabOrderDisplayList[orderShowIndex!.toInt()];
      }
      orderHistoryShowIndex = value.hisSetting;
      if (orderHistoryShowIndex != null) {
        orderHistoryShow = grabOrderDisplayList[orderHistoryShowIndex!.toInt()];
      }

      orderFollowShowIndex = value.followSetting;
      if (orderFollowShowIndex != null) {
        orderFollowShow = grabOrderDisplayList[orderFollowShowIndex!.toInt()];
      }
      update();
    });

    ///允许用户跟单设置
    AFFollow.getCopySwitch(traderId: UserGetx.to.user?.info?.id ?? 0).then((value) {
      switchOpen.value = value.copySwitch == 1 ? true : false;
      update();
    });
  }

  setTakePosition(int type, int index) {
    if (type == 0) {
      AFFollow.copySetting(copySetting: index).then((value) {
        if (value == null) {
          UIUtil.showSuccess(LocaleKeys.follow119.tr);
          orderShowIndex = index;
          orderShow = grabOrderDisplayList[index];
          update();
        } else {
          UIUtil.showToast(LocaleKeys.follow120.tr);
        }
      });
    } else if (type == 1) {
      AFFollow.updateHisSetting(copySetting: index).then((value) {
        if (value == null) {
          UIUtil.showSuccess(LocaleKeys.follow119.tr);
          orderHistoryShowIndex = index;
          orderHistoryShow = grabOrderDisplayList[index];
          update();
        } else {
          UIUtil.showToast(LocaleKeys.follow120.tr);
        }
      });
    } else {
      AFFollow.updateFollowSetting(copySetting: index).then((value) {
        if (value == null) {
          UIUtil.showSuccess(LocaleKeys.follow119.tr);
          orderFollowShowIndex = index;
          orderFollowShow = grabOrderDisplayList[index];
          update();
        } else {
          UIUtil.showToast(LocaleKeys.follow120.tr);
        }
      });
    }
  }

  setSwitch() {
    AFFollow.copySwitch(copySwitch: !switchOpen.value ? 1 : 0).then((value) {
      if (value == null) {
        UIUtil.showSuccess(LocaleKeys.follow119.tr);

        switchOpen.value = !switchOpen.value;
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
