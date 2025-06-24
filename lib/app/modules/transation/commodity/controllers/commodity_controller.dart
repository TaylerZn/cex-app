// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commdity_kchar_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_create_order_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/state/commodity_state.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity_position/controllers/commodity_position_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodiy_entrust/controllers/commondiy_entrust_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';

import '../../../../getX/user_Getx.dart';
import '../../../../utils/utilities/log_util.dart';
import '../../../../widgets/components/transaction/transaction_switch_button.dart';
import '../../../../ws/standard_future_socket_manager.dart';

class CommodityController extends GetxController
    with GetSingleTickerProviderStateMixin {//标准合约
  static CommodityController get to => Get.find();

  CommodityState state = CommodityState();

  late TextEditingController priceTextController;
  FocusNode priceFocusNode = FocusNode();
  late TextEditingController amountTextController;
  FocusNode amountFocusNode = FocusNode();
  RxBool isGuiding = true.obs;

  // 止赢
  late TextEditingController stopWinTextController;

  // 止损
  late TextEditingController stopLossTextController;

  // 持有保证金
  RxNum holdAmount = RxNum(0);

  // 是否正在创建订单
  bool isCreatingOrder = false;

  late TabController tabController;

  @override
  void onInit() {
    stopWinTextController = TextEditingController();
    stopLossTextController = TextEditingController();
    tabController = TabController(length: 3, vsync: this);

    priceTextController = TextEditingController()
      ..addListener(() {
        calculateCanOpenAmount();
        calculateMargin();
      });
    amountFocusNode.addListener(() {
      // amountTextController.text.trim().contains('%')
      if (amountFocusNode.hasFocus && state.percent.value != 0) {
        changePrecent(0);
        amountTextController.clear();
      }
    });

    amountTextController = TextEditingController()
      ..addListener(() {
        calculateCanOpenAmount();
        calculateMargin();
      });
    super.onInit();

    Bus.getInstance().on(EventType.login, (data) {
      fetchCurrentContractUserConfig();
      isGuiding.value =
          AppGuideView.canShowButtonGuide(AppGuideType.standardContract);
    });
    Bus.getInstance().on(EventType.signOut, (data) {
      state.reset();
    });
    Bus.getInstance().on(EventType.refreshAsset, (data) {
      fetchCurrentContractUserConfig();
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    if (CommodityDataStoreController.to.contractGroupList.isEmpty) {
      try {
        await CommodityDataStoreController.to.fetchPublicInfo();
      } catch (e) {
        AppLogUtil.e(e.toString());
      }
    }
    ContractInfo? contractInfo =
        CommodityDataStoreController.to.getContractInfoByContractId(1);
    if (contractInfo != null) {
      changeContractInfo(contractInfo);
      StandardFutureSocketManager.instance.subMarketInfo(contractInfo.symbol, contractInfo.id,callback: (res){
        state.fundingRate.value = res;
      });
    }

  }

  @override
  void onClose() {
    priceTextController.dispose();
    amountTextController.dispose();
    tabController.dispose();
    stopLossTextController.dispose();
    stopWinTextController.dispose();
    super.onClose();
  }

  changeOrderType(bool isMarket) {
    if (UserGetx.to.goIsLogin()) {
      state.isMarketOrder.value = isMarket;
      calculateCanOpenAmount();
      clear();
    }
  }

  void clear() {
    amountTextController.clear();
    priceTextController.clear();
    priceTextController.text = state.contractInfo.value?.close.toPrecision(state
                .contractInfo.value?.coinResultVo?.symbolPricePrecision
                .toInt() ??
            4) ??
        '';
    state.percent.value = 0;
  }

  void changeContractInfo(ContractInfo info) {
    state.contractInfo.value =
        CommodityDataStoreController.to.getContractInfoByContractId(info.id) ??
            info;
    state.amountUnits.value = [info.firstName, 'USDT'];
    changePrecent(0);
    fetchCurrentContractUserConfig();
    CommodityKChartController.to.changeContractInfo(info);
    CommodityEntrustController.to.changeContractInfo(info);
    CommodityPositionController.to.changeContractInfo(info);
    fetchOpenStatus();
    fetchFundingRate();
  }

  void changePrecent(double value) {
    state.percent.value = value;
    setAmountText();
  }

  void setAmountText() {
    if (state.percent.value != 0) {
      if (state.switchState.value == TransactionSwitchButtonValue.left) {
        if (state.amountUnitIndex.value == 0) {
          amountTextController.text = (state.percent.value.toDecimal() *
                  state.canOpenAmount.value.toDecimal())
              .toPrecision(
                  state.contractInfo.value?.multiplier.numDecimalPlaces() ?? 2);
        } else {
          amountTextController.text = (state.percent.value.toDecimal() *
                  state.availableBalance.value.toDecimal() *
                  (state.userConfig.value?.getNowLevel() ?? 20).toDecimal())
              .toPrecision(
                  state.contractInfo.value?.multiplier.numDecimalPlaces() ?? 2);
        }
      } else {
        amountTextController.text = '${(state.percent.value * 100).toInt()}%';
      }
    } else {
      amountTextController.clear();
    }
  }

  void showGuideView() {
    if (UserGetx.to.isLogin) {
      Intro.of(Get.context!)
          .start(reset: false, group: AppGuideType.standardContract.name);
    }
  }

  void changeAmountUnitIndex(int res) {
    state.amountUnitIndex.value = res;
    if (state.switchState.value == TransactionSwitchButtonValue.left) {
      calculateCanOpenAmount();
      calculateMargin();
    } else {
      calculateCanCloseAmount();
    }
  }

  /// 刷新数据
  refreshData() async {
    try {
      List<Future> futures = [
        fetchCurrentContractUserConfig(),
        fetchOpenStatus(),
        fetchFundingRate(),
        CommodityPositionController.to.fetchData(),
        CommodityEntrustController.to.fetchData(),
      ];

      if (CommodityDataStoreController.to.contractGroupList.isEmpty) {
        futures.add(CommodityDataStoreController.to.fetchPublicInfo());
      }
      await Future.wait(futures);
    } on Exception catch (e) {
      AppLogUtil.e(e.toString());
    }
  }

  Future<void> checkContractListIfEmptyLoadData() async {
    if (CommodityDataStoreController.to.contractGroupList.isEmpty) {
      await CommodityDataStoreController.to.fetchPublicInfo();
    }
    setFirstContract();
  }

  void setFirstContract() {
    if (state.contractInfo.value == null) {
      ContractInfo? contractInfo =
          CommodityDataStoreController.to.getContractInfoByContractId(1);
      if (contractInfo != null) {
        changeContractInfo(contractInfo);
      }
    }
  }
}

extension CommodityControllerX on CommodityController {
  /// 修改保证金模式
  Future<void> editMarginModel(int marginModel) async {
    if (state.contractInfo.value == null || !UserGetx.to.goIsLogin()) return;
    try {
      await CommodityApi.instance()
          .marginModelEdit(state.contractInfo.value!.id, marginModel);
      fetchCurrentContractUserConfig();
    } on DioException catch (e) {
      UIUtil.showError(e.error.toString());
    }
  }

  /// 获取当前币种配置
  Future fetchCurrentContractUserConfig() async {
    if (state.contractInfo.value == null || !UserGetx.to.isLogin) return;
    try {
      final res = await CommodityApi.instance()
          .getUserConfig(state.contractInfo.value!.id);
      state.userConfig.value = res;
      calculateCanOpenAmount();
      calculateMargin();
    } catch (e) {
      bobLog('error when fetchCurrentContractUserConfig: $e');
    }
  }

  Future<void> editLever(int lever) async {
    if (state.contractInfo.value == null || !UserGetx.to.goIsLogin()) return;
    try {
      await CommodityApi.instance()
          .levelEdit(lever, state.contractInfo.value!.id);
      fetchCurrentContractUserConfig();
    } on DioException catch (e) {
      UIUtil.showError(e.error.toString());
    }
  }

  Future fetchOpenStatus() async {
    if (state.contractInfo.value == null) return;
    try {
      final res = await CommodityApi.instance()
          .getContractOpenStatus(state.contractInfo.value!.id);
      state.openStatus.value = res;
    } catch (e) {
      bobLog('error when fetchCurrentTradePeriodInfo: $e');
    }
  }

  Future fetchFundingRate() async {
    if (state.contractInfo.value == null) return;
    try {
      final res = await CommodityApi.instance().getMarketInfo(
          state.contractInfo.value!.symbol, state.contractInfo.value!.id);
      state.fundingRate.value = res;
    } catch (e) {}
  }
}
