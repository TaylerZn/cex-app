import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/controllers/wallet_history_list_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_enum.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_model.dart';

class WalletHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final tabs = <WalletHistoryType>[
    WalletHistoryType.topUp,
    WalletHistoryType.withdrawal,
    // WalletHistoryType.spotTrading,
    WalletHistoryType.transfer,
    WalletHistoryType.conver, //闪兑
    WalletHistoryType.bonus
  ];

  var modelList = <WalletHistoryFilterModel>[
    WalletHistoryType.topUp.model,
    WalletHistoryType.withdrawal.model,
    // WalletHistoryType.spotTrading.model,
    WalletHistoryType.transfer.model,
    WalletHistoryType.conver.model, //闪兑
    WalletHistoryType.bonus.model,
  ];

  late TabController tabController;
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    if (AssetsGetx.to.assetSpotsList.isEmpty) {
      AssetsGetx.to.getAssetSpotsList();
    }
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.index = Get.arguments ?? 0;
    currentIndex = tabController.index;
    Get.put(WalletHistoryListController());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
