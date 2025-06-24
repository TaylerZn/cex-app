import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_list/model/follow_taker_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowTakerListController extends GetxController with GetTickerProviderStateMixin {
  final navTabs = <TakerListType>[
    TakerListType.allTraders,
    TakerListType.hotTraders,
    TakerListType.steadyTrader,
    TakerListType.foldTraders
  ];

  final fillterTabs = <FollowOrdersType>[
    FollowOrdersType.aggregate,
    FollowOrdersType.winRatio,
    FollowOrdersType.yield,
    // FollowOrdersType.revenueVolume,
    // FollowOrdersType.currentNumber,
  ];

  late TabController tabController;
  late TabController tabControllerFillter;

  late int currentIndex;
  int currentIndexFillter = 0;
  final tabsModel = <List<FollowKolListModel>>[];
  final tabsRefreshController = <List<RefreshController>>[];

  @override
  void onInit() {
    super.onInit();
    currentIndex = Get.arguments['index'] ?? 0;

    tabController = TabController(length: navTabs.length, vsync: this);
    tabController.index = currentIndex;
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
        getData();
      }
    });
    tabControllerFillter = TabController(length: fillterTabs.length, vsync: this);
    tabControllerFillter.addListener(() {
      if (!tabControllerFillter.indexIsChanging) {
        currentIndexFillter = tabControllerFillter.index;
        getData();
      }
    });

    tabsModel
        .addAll(List.generate(navTabs.length, (index) => List.generate(fillterTabs.length, (index) => FollowKolListModel())));

    tabsRefreshController
        .addAll(List.generate(navTabs.length, (index) => List.generate(fillterTabs.length, (index) => RefreshController())));
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  // var type = tabs[currentIndex];
  // switch (type) {
  //   case MyFollowFilterType.currentDocumentary:
  //     if (isPullDown) {
  //       currentList.value.page = 1;
  //     } else {
  //       if (currentList.value.list != null && currentList.value.page == 1) return null;
  //     }

  Future? getData({bool isPullDown = false}) async {
    int orderByType = currentIndex == 0 ? fillterTabs[currentIndexFillter].orderType : 0;
    var currentModel = currentIndex == 0 ? tabsModel[0][currentIndexFillter] : tabsModel[currentIndex].first;
    if (isPullDown) {
      currentModel.page = 1;
    } else {
      if (currentModel.list != null && currentModel.page == 1) return null;
    }

    //0全部交易员 1热门交易员  2稳健交易员  3万倍交易员

    var value = await AFFollow.getTraderList(
        kolType: currentIndex, orderByType: orderByType, page: currentModel.page, pageSize: currentModel.pageSize);
    var pageLength = value.list?.length;
    if (currentModel.page != 1) {
      currentModel.list?.addAll(value.list ?? []);
      value.list = currentModel.list;
    }
    currentModel.list = value.list;
    currentModel.page = currentModel.page;
    currentModel.haveMore = pageLength == currentModel.pageSize;
    update();
    return value;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
