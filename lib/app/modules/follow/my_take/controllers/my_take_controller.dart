import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_history_order.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_trader_position.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/my_follow_enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//

class MyTakeController extends GetxController with GetTickerProviderStateMixin {
  late FollowKolTraderInfoModel infoModel;

  int currentIndex = 0;
  late TabController tabController;
  final tabs = <MyTakeFilterType>[MyTakeFilterType.currentTake, MyTakeFilterType.historyTake];

  Rx<FollowTradePositionModel> currentOrder = FollowTradePositionModel().obs;
  RefreshController currentOrderRefreshVc = RefreshController();

  Rx<FollowHistoryOrderModel> historyOrder = FollowHistoryOrderModel().obs;
  RefreshController historyOrderRefreshVc = RefreshController();

  @override
  void onInit() {
    super.onInit();
    infoModel = Get.arguments['model'];
    tabController = TabController(length: tabs.length, vsync: this);
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

  Future? getData({bool isPullDown = false}) {
    var type = tabs[currentIndex];
    switch (type) {
      case MyTakeFilterType.currentTake:
        if (isPullDown) {
          currentOrder.value.page = 1;
        } else {
          if (currentOrder.value.list != null && currentOrder.value.page == 1) return null;
        }
        return AFFollow.getTradePosition(
                page: currentOrder.value.page, pageSize: currentOrder.value.pageSize, traderId: infoModel.uid)
            .then((value) {
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
          historyOrder.value.page = 1;
        } else {
          if (historyOrder.value.list != null && historyOrder.value.page == 1) return null;
        }
        return AFFollow.getHistoryCopyOrder(
                page: historyOrder.value.page, pageSize: historyOrder.value.pageSize, uid: infoModel.uid)
            .then((value) {
          int page = historyOrder.value.page;
          var pageSize = value.list?.length;

          if (page != 1) {
            historyOrder.value.list?.addAll(value.list!);
            value.list = historyOrder.value.list;
          }
          historyOrder.value = value;
          historyOrder.value.page = page;
          historyOrder.value.haveMore = pageSize == historyOrder.value.pageSize;
        });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
