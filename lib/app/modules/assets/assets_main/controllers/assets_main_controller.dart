import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_contract/views/assets_contract_view.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_follow/views/assets_follow_view.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_funds/views/assets_funds_view.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/views/assets_overview_view.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots/views/assets_spots_view.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../main_tab/controllers/main_tab_controller.dart';

class AssetsMainController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AssetsMainController get to => Get.find();
  List<String> tabs = [
    LocaleKeys.assets1,
    LocaleKeys.assets2,
    LocaleKeys.assets3,
    LocaleKeys.assets4,
    LocaleKeys.assets142,
  ];

  List<Widget> views = [
    const AssetsOverviewView(),
    const AssetsFollowView(),
    const AssetsContractView(),
    const AssetsSpotsView(),
    const AssetsFundsView(),
  ];

  late TabController tabController;
  int _selectedIndex = 0;
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);

    tabController.addListener(_handleTabSelection);
    Bus.getInstance().on(EventType.signOut, (data) {
      tabController.index = 0;
    });
    Bus.getInstance().on(EventType.changeLang, (data) {
      AssetsGetx.to.getRefresh();
      update();
    });
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      AssetsGetx.to.getRefresh(notify: true);
      // if (tabController.index == 2) {
      //   if (UserGetx.to.goIsOpenContract()) {
      //   } else {
      //     tabController.index = _selectedIndex; // 拦截后返回之前的标签
      //   }
      // } else {
      _selectedIndex = tabController.index; // 更新当前选择的索引
      // }
      FocusScope.of(Get.context!).unfocus(); // 关闭键盘
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    fetchData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  fetchData() {
    if (!UserGetx.to.isLogin) return;
    timer?.cancel();
    AssetsGetx.to.getRefresh(notify: true);
    timer =
        Timer.periodic(const Duration(seconds: assetTimerDurationSec), (timer) {
      AssetsGetx.to.getRefresh(notify: true);
    });
  }

  static void _navigateToTabByName(String tabName) {
    Get.untilNamed(Routes.MAIN_TAB);
    MainTabController.to.changeTabIndex(4);
    final controller = Get.find<AssetsMainController>();
    final index = controller.tabs.indexOf(tabName);
    if (index != -1) {
      controller.tabController.animateTo(index);
    }
  }

  static void navigateToFunding() {
    _navigateToTabByName(LocaleKeys.assets142);
  }

  static void navigateToSpot() {
    _navigateToTabByName(LocaleKeys.assets4);
  }

  static void navigateToFlow() {
    _navigateToTabByName(LocaleKeys.assets2);
  }

  static void navigateToContract() {
    _navigateToTabByName(LocaleKeys.assets3);
  }
}
