import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/app_remote_config_controller.dart';
import 'package:nt_app_flutter/app/modules/main_tab/models/trade_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/dialog/network_error_dialog.dart';
import 'package:nt_app_flutter/app/ws/contract_socket_manager.dart';
import 'package:nt_app_flutter/app/ws/spot_goods_socket_manager.dart';
import 'package:nt_app_flutter/app/ws/standard_socket_manager.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../markets/market/controllers/markets_index_controller.dart';

class MainTabController extends FullLifeCycleController
    with GetTickerProviderStateMixin, FullLifeCycleMixin {
  static MainTabController get to => Get.find();
  double centerBtnBottom = 0;
  var tabIndex = 0.obs;
  DateTime? lastPressedAt;

  List<Map<String, dynamic>> tabs = [
    {
      "icon": 'tab/app_tab_home',
      "label": LocaleKeys.public15,
      'lottie': 'assets/json/h_new.json',
    },
    {
      "icon": 'tab/app_tab_market',
      "label": LocaleKeys.public16,
      'lottie': 'assets/json/tab/market.json',
    },
    {
      "icon": '/tab/app_tab_trade',
      "label": LocaleKeys.public17,
      'lottie': 'assets/json/tab/trade.json',
    },
    {
      "icon": 'tab/app_tab_follow',
      "label": LocaleKeys.public18,
      'lottie': 'assets/json/tab/copy.json',
    },
    {
      "icon": 'tab/app_tab_wallet',
      "label": LocaleKeys.public19,
      'lottie': 'assets/json/tab/wallet.json',
    },
  ];
  PageController pageController = PageController(initialPage: 0);
  late AnimationController animationController;
  late Animation<double> animation;
  var isAnimating = false.obs;

  /// 交易类型
  var tradeType = TradeType.contract.obs; //1.obs;

  List<AnimationController> homeTabAnimationControllers = [];

  @override
  void onInit() {
    homeTabAnimationControllers.clear();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    List.generate(
        tabs.length,
        (index) =>
            homeTabAnimationControllers.add(AnimationController(vsync: this)));
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    pageController.dispose();
    homeTabAnimationControllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    AppRemoteConfigController.to.fetchRate();
  }

  @override
  void onDetached() {
    _closeSocket();
  }

  @override
  void onHidden() {
    _closeSocket();
  }

  @override
  void onInactive() {
    _closeSocket();
  }

  @override
  void onPaused() {
    _closeSocket();
  }

  @override
  void onResumed() {
    _connectSocket();
  }

  _closeSocket() {
    ContractSocketManager.instance.close();
    StandardSocketManager.instance.close();
    SpotGoodsSocketManager.instance.close();
  }

  _connectSocket() {
    ContractSocketManager.instance.connect();
    StandardSocketManager.instance.connect();
    SpotGoodsSocketManager.instance.connect();
  }
}

extension MainTabControllerx on MainTabController {
  void changeTransactionType(TradeType value) {
    tradeType.value = value;
  }

  Future<void> changeTabIndex(int value) async {
    MyCommunityUtil.showSocialMenu.value = false;

    if (value == 1 &&
        Get.isRegistered<MarketsIndexController>() &&
        Get.find<MarketsIndexController>().isInit) {
      if (Get.find<MarketsIndexController>().tabController.index == 2) {
        MyCommunityUtil.showSocialMenu.value = true;
      }
    }

    if (value == 4) {
      if (UserGetx.to.goIsLogin()) {
        jumpPage(value);
        changeIndex(value);
      }
    } else {
      jumpPage(value);
      changeIndex(value);
    }

    if (animationController.status != AnimationStatus.reverse) {
      animationController.reverse();
    }
    // }
    if (GetPlatform.isIOS) {
      HapticFeedback.lightImpact();
    }
  }

  jumpPage(value) {
    pageController.jumpToPage(value);
    if (tabIndex.value != value) {
      tabIndex.value = value;
      isAnimating.value = true;
    }
  }

  changeIndex(int value) {
    for (int i = 1; i < homeTabAnimationControllers.length; i++) {
      if (i != value) {
        homeTabAnimationControllers[i].reset();
      }
    }
    if (value == 0) return;
    homeTabAnimationControllers[value].forward().then((v) {
      homeTabAnimationControllers[value].stop();
    });
  }
}

extension MainTabControllerX on MainTabController {
  // 返回键退出
  bool closeOnConfirm() {
    DateTime now = DateTime.now();
    // 物理键，两次间隔大于4秒, 退出请求无效
    if (lastPressedAt == null ||
        now.difference(lastPressedAt!) > const Duration(seconds: 1)) {
      lastPressedAt = now;
      UIUtil.showToast(LocaleKeys.public56.tr);
      return false;
    }

    // 退出请求有效
    lastPressedAt = null;
    return true;
  }

  checkNetworkStatus() async {
    await 5000.milliseconds.delay();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      Get.log('result =${result.toString()}');
      if (result == ConnectivityResult.none) {
        NetworkErrorDialog.show();
      }
    });
  }
}
