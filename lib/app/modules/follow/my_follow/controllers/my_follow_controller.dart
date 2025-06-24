import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/follow_my_trader.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/follow_user_order.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/my_follow_enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyFollowController extends GetxController with GetTickerProviderStateMixin {
  final tabs = <MyFollowFilterType>[
    MyFollowFilterType.myTrader,
    MyFollowFilterType.currentDocumentary,
    MyFollowFilterType.historyDocumentary
  ];
  late TabController tabController;
  int currentIndex = 0;

  FollowGeneralInfoModel incomeInfo = FollowGeneralInfoModel();

  // Rx<FollowMyTraderModel> myTrader = FollowMyTraderModel().obs;
  // final RefreshController myTraderRefresh = RefreshController();

  var myTraderArrIndex = 0.obs;
  List<Rx<FollowMyTraderModel>> myTraderArr = [FollowMyTraderModel().obs, FollowMyTraderModel().obs];
  List<RefreshController> myTraderRefreshArr = [RefreshController(), RefreshController()];
  final myTraderArrTabs = [MyFowllowFilterType.currentFollow, MyFowllowFilterType.historyFollow];

  Rx<FollowUserFollowOrderModel> currentList = FollowUserFollowOrderModel().obs;
  final RefreshController currentListRefresh = RefreshController();

  Rx<FollowUserFollowOrderModel> historyList = FollowUserFollowOrderModel().obs;
  final RefreshController historyListRefresh = RefreshController();
  // RxList<MapEntry<String, String>> subCurrentFilterTabs = <MapEntry<String, String>>[].obs;
  List<MapEntry<String, String>> subCurrentFilterTabs = <MapEntry<String, String>>[];

  int filterIndex = 0;

  Map<String, List<FollowUserFollowOrder>> currentListMap = {};
  var isText = true.obs;

  var textVC = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments?['model'] != null) {
      incomeInfo = Get.arguments?['model'];
    } else {
      AFFollow.getFollowGeneralInfo().then((value) {
        if (value != null) {
          incomeInfo = value;
          update();
        }
      });
    }

    isText.value = BoolKV.myFollowIsText.get() == false ? false : true;
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
        getData();
      }
    });
    if (Get.arguments?['index'] != null) {
      currentIndex = Get.arguments?['index'];
      tabController.index = currentIndex;
    }
  }

  @override
  void onReady() {
    super.onReady();

    getData();
  }

  Future? getData({bool isPullDown = false}) {
    var type = tabs[currentIndex];
    switch (type) {
      case MyFollowFilterType.currentDocumentary:
        if (isPullDown) {
          currentList.value.page = 1;
        } else {
          if (currentList.value.list != null && currentList.value.page == 1) return null;
        }

        return AFFollow.getFollowOrder(type: 1, pageNo: currentList.value.page, pageSize: currentList.value.pageSize)
            .then((value) {
          currentListMap.clear();
          filterIndex = 0;
          if (value.list != null && value.list!.isNotEmpty) {
            for (var model in value.list!) {
              var useId = model.kolUidStr;
              if (currentListMap.keys.contains(useId)) {
                var array = currentListMap[useId];
                array?.add(model);
              } else {
                currentListMap[useId] = [model];
              }
            }

            List<MapEntry<String, String>> titleArray = [];
            currentListMap.forEach((key, value) {
              titleArray.add(MapEntry(key, '${value.first.kolNameStr}(${value.length})'));
            });
            subCurrentFilterTabs = titleArray;
            FollowUserFollowOrderModel tempModel = FollowUserFollowOrderModel();
            tempModel.list = currentListMap[titleArray.first.key];
            currentList.value = tempModel;
          } else {
            int page = currentList.value.page;
            currentList.value = value;
            currentList.value.page = page;
            currentList.value.haveMore = false;
          }
        });

      case MyFollowFilterType.historyDocumentary:
        if (isPullDown) {
          historyList.value.page = 1;
        } else {
          if (historyList.value.list != null && historyList.value.page == 1) return null;
        }

        return AFFollow.getFollowOrder(type: 0, pageNo: historyList.value.page, pageSize: historyList.value.pageSize)
            .then((value) {
          int page = historyList.value.page;
          var pageSize = value.list?.length;

          if (page != 1) {
            historyList.value.list?.addAll(value.list ?? []);
            value.list = historyList.value.list?.sublist(0, min(30, historyList.value.list!.length));
            if (value.list!.length > 29) {
              historyList.value.haveMore = false;
              historyListRefresh.loadNoData();
            }
          }

          historyList.value = value;
          historyList.value.page = page;
          historyList.value.haveMore = pageSize == historyList.value.pageSize;
        });

      default:
        if (isPullDown) {
          myTraderArr[myTraderArrIndex.value].value.page = 1;
        } else {
          if (myTraderArr[myTraderArrIndex.value].value.list != null && myTraderArr[myTraderArrIndex.value].value.page == 1) {
            return null;
          }
        }

        if (myTraderArrIndex.value == 0) {
          return AFFollow.getMyTrader(page: myTraderArr[0].value.page, pageSize: myTraderArr[0].value.pageSize).then((value) {
            int page = myTraderArr[0].value.page;
            var pageSize = value.list?.length;

            if (page != 1) {
              myTraderArr[0].value.list?.addAll(value.list ?? []);
              value.list = myTraderArr[0].value.list;
            }
            value.list?.forEach((model) {
              model.isText = isText.value;
            });
            myTraderArr[0].value = value;
            myTraderArr[0].value.page = page;
            myTraderArr[0].value.haveMore = pageSize == myTraderArr[0].value.pageSize;
          });
        } else {
          return AFFollow.getMyHistoryTrader(page: myTraderArr[1].value.page, pageSize: myTraderArr[1].value.pageSize)
              .then((value) {
            int page = myTraderArr[1].value.page;
            var pageSize = value.list?.length;

            if (page != 1) {
              myTraderArr[1].value.list?.addAll(value.list ?? []);
              value.list = myTraderArr[1].value.list;
            }
            value.list?.forEach((model) {
              model.isText = isText.value;
            });
            myTraderArr[1].value = value;
            myTraderArr[1].value.page = page;
            myTraderArr[1].value.haveMore = pageSize == myTraderArr[1].value.pageSize;
          });
        }
    }
  }

  getCurrentFlollowList(int index) {
    filterIndex = index;
    var key = subCurrentFilterTabs[index].key;
    FollowUserFollowOrderModel tempModel = FollowUserFollowOrderModel();
    tempModel.list = currentListMap[key];
    currentList.value = tempModel;
  }

  changeText() {
    isText.value = !isText.value;
    BoolKV.myFollowIsText.set(isText.value);
    for (var element in myTraderArr) {
      var array = element.value.list;
      array?.forEach((model) {
        model.isText = isText.value;
      });
      element.update((val) {});
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
