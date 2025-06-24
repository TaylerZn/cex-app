import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/my/coupons/model/coupons_model.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CouponsIndexController extends GetxController with GetTickerProviderStateMixin {
  List<CouponsType> navTabs = [CouponsType.claimed, CouponsType.invalid];
  List<String> navTabsStr = [CouponsType.claimed.value, CouponsType.invalid.value];

  late TabController tabController;
  int currentIndex = 0;
  var refreshVcArr = [RefreshController(), RefreshController()];
  var dataArray = [CouponsListModel().obs, CouponsListModel().obs];
  bool complete = false;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: navTabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
        getData();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future? getData({bool isPullDown = false}) async {
    if (!isPullDown && dataArray[currentIndex].value.cardList?.isNotEmpty == true) return;
    return AFFollow.getCouponCardList(currentIndex).then((value) {
      if (currentIndex == 0 && value.cardList?.isNotEmpty == true) {
        var first = '${navTabs.first.value} (${value.cardList!.where((element) => element.isBonus).length})';
        navTabsStr.replaceRange(0, 1, [first]);
      }
      complete = true;
      update();
      dataArray[currentIndex].value = value;
    });
  }

  getReceiveExpCoupon(String? cardSn, Function(String) callback) {
    AFFollow.getReceiveExpCoupon(cardSn).then((value) {
      if (value != null) {
        var str = MyTimeUtil.getYMDime(MyTimeUtil.timestampToDate(value.toInt()).toLocal(), format: 'yyyy-MM-dd HH:mm');

        callback(str);

        getData();
      }
    });
  }

  getUtc() {
    DateTime now = DateTime.now();
    Duration offset = now.timeZoneOffset;
    int hours = offset.inHours;
    return 'UTC${hours >= 0 ? '+' : ''}$hours';
  }

  @override
  void onClose() {
    super.onClose();
  }
}
