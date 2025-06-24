import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_contract.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/trades/controllers/trades_controller.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/ws/future_socket_manager.dart';
import 'package:nt_app_flutter/app/ws/standard_future_socket_manager.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../getX/assets_Getx.dart';
import '../../../../models/contract/res/position_res.dart';

class AssetsContractController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AssetsContractController get to => Get.find();
  final actions = [LocaleKeys.user268, LocaleKeys.assets7];
  final RefreshController refreshController = RefreshController();

  final List<String> tabs = [LocaleKeys.assets8, LocaleKeys.assets9];
  int contractIndex = 0;
  Timer? timer;
  int index = 0;

  late TabController tabController;

  Rxn<AssetsContract> balanceInfo = Rxn<AssetsContract>();

  List<PositionInfo> contractPositionList = [];
  List<PositionInfo> commodityPositionList = [];
  List<AccountRes> contractAssetList = [];
  List<AccountRes> standardContractAssetList = [];

  List<PositionInfo> getPositionList() {
    if (contractIndex == 0) {
      return commodityPositionList;
    } else {
      return contractPositionList;
    }
  }

  List<AccountRes> getAssetList(int index) {
    if (index == 0) {
      return standardContractAssetList;
    } else {
      return contractAssetList;
    }
  }

  int getcoinPrecision() {
    if (AssetsGetx.to.rateList.isNotEmpty &&
        !TextUtil.isEmpty(AssetsGetx.to.rateList[0].coinPrecision)) {
      return int.parse(AssetsGetx.to.rateList[0].coinPrecision.toString());
    }
    return 2;
  }

  num getRealizeProfit() {
    num unRealizedAmount = 0;
    List<PositionInfo> positionList = getPositionList();
    if (positionList.isNotEmpty) {
      for (PositionInfo positionInfo in positionList) {
        unRealizedAmount += positionInfo.openRealizedAmount;
      }
    }
    return unRealizedAmount;
  }

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(vsync: this, initialIndex: index, length: tabs.length);
    tabController.addListener(() {
      index = tabController.index;
      update();
    });

    Bus.getInstance().on(EventType.signOut, (data) {
      balanceInfo.value = null;
      contractPositionList.clear();
      commodityPositionList.clear();
      contractAssetList.clear();
      standardContractAssetList.clear();
      update();
    });

    Bus.getInstance().on(EventType.login, (data) {
      changeContractIndex(0);
      changeContractIndex(1);
    });
  }

  void actionHandler(val) async {
    if (val == 0) {
      // todo交易跳转
      MainTabController.to.changeTabIndex(2);
      TradesController.to.onTabChange(
          index == 0 ? TradeIndexType.standard : TradeIndexType.contract);
    } else if (val == 1) {
      try {
        final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER,
            arguments: {"from": 3, "to": contractIndex == 0 ? 1 : 2});
        if (res) {
          UIUtil.showSuccess(LocaleKeys.assets10.tr);
        }
      } catch (e) {
        Get.log('AssetsContractController actionHandler error: $e');
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    changeContractIndex(0);
    changeContractIndex(1);
    fetchData();
  }

  @override
  void onClose() {
    tabController.dispose();
    Bus.getInstance().off(EventType.login, (data) {});
    Bus.getInstance().off(EventType.signOut, (data) {});
    super.onClose();
  }

  Future<void> changeContractIndex(int i) async {
    if (UserGetx.to.isLogin == false) {
      return;
    }
    contractIndex = i;
    update();
    if (contractIndex == 0) {
      final res = await CommodityApi.instance().getAssetsList('0', null);
      commodityPositionList = res.positionList;
      standardContractAssetList = res.accountList;
    } else {
      final res = await ContractApi.instance().getAssetsList('0', null);
      contractPositionList = res.positionList;
      contractAssetList = res.accountList;
    }
    update();
  }

  fetchData() {
    if (!UserGetx.to.isLogin || !UserGetx.to.isOpenContract) return;
    timer?.cancel();
    AssetsGetx.to.getAssetContract();
    AssetsGetx.to.getAssetStandardContract();
    changeContractIndex(contractIndex);

    FuturetSocketManager.instance.subAssetList(callback: (PositionRes res){
      contractPositionList = res.positionList;
      contractAssetList = res.accountList;
    });
     StandardFutureSocketManager.instance.subAssetList(callback: (PositionRes res){
       commodityPositionList = res.positionList;
       standardContractAssetList = res.accountList;
     });

    // timer = Timer.periodic(const Duration(seconds: contractTimerDurationSec),
    //     (timer) {//合约轮训接口
    //   // AssetsGetx.to.getAssetContract();
    //   // AssetsGetx.to.getAssetStandardContract();
    //   changeContractIndex(contractIndex);
    // });
  }
}
