import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/models/order_type.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/state/operate_state.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_postion/controllers/contract_position_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

import '../../../../models/contract/res/public_info.dart';
import '../../../../models/contract/res/user_config_info.dart';
import '../../../../utils/utilities/log_util.dart';
import '../../../../widgets/components/transaction/transaction_switch_button.dart';

class ContractOperateController extends GetxController {
  OperateState state = OperateState();

  RxnNum get canOpenAmount => state.canOpenAmount;
  RxnNum get canCloseMoreAmount => state.canCloseMoreAmount;
  RxnNum get canCloseEmptyAmount => state.canCloseEmptyAmount;

  /// 可用余额
  RxNum get availableBalance => state.availableBalance;

  /// 开仓保证金
  RxnNum get margin => state.margin;
  bool isCreateOrdering = false;

  /// 持仓保证金
  RxNum holdAmount = RxNum(0);

  /// 限价单价格输入框
  late TextEditingController limitPriceTextController;
  FocusNode limitPriceFocusNode = FocusNode();

  /// 限价止盈止损触发价输入框
  late TextEditingController limitTriggerPriceTextController;
  FocusNode limitTriggerPriceFocusNode = FocusNode();

  /// 限价止盈止损委托价输入框
  late TextEditingController limitEntrustPriceTextController;
  FocusNode limitEntrustPriceFocusNode = FocusNode();

  /// 市价止盈止损触发价输入框
  late TextEditingController marketTriggerPriceTextController;
  FocusNode marketTriggerPriceFocusNode = FocusNode();
  // 数量输入框
  late TextEditingController amountTextController;
  FocusNode amountFocusNode = FocusNode();
  static ContractOperateController get to => Get.find();
  Rxn<ContractInfo> contractInfo = Rxn<ContractInfo>();

  /// 当前合约用户配置信息
  Rxn<UserConfigInfo> get userConfig => state.userConfig;
  double get amountPercent => state.amountPercent.value;

  /// 开单类型
  Rx<OrderType> orderType = OrderType.limit.obs;
  // 止赢
  late TextEditingController stopWinTextController;
  // 止损
  late TextEditingController stopLossTextController;

  setOrderType(OrderType orderType) {
    this.orderType.value = orderType;
    if (orderType.type == 2) {
      // 市价 开仓  单位只能是usdt
      if (switchState.value == TransactionSwitchButtonValue.left) {
        amountUnitIndex.value = 1;
      } else {
        // 市价 平仓 单位只能是btc
        amountUnitIndex.value = 0;
      }
    }
    clear();
    _calculateMargin();
    calculateOpenAmount();
  }

  /// 数量单位
  var amountUnitIndex = 0.obs;

  setAmountUnitIndex(int index) {
    amountUnitIndex.value = index;
    _calculateMargin();
    setAmountText();
  }

  final amountUnits = ['BTC', 'USDT'].obs;

  List<String> getAmountUnitList() {
    return amountUnits;
  }

  /// 止盈止损
  RxBool isStopLoss = false.obs;

  /// 开仓平仓
  var switchState = TransactionSwitchButtonValue.left.obs;

  setSwitchState(TransactionSwitchButtonValue value) {
    switchState.value = value;
    changeAmountPercent(0);
    _calculateMargin();
  }

  RxDouble rightHeight = 400.h.obs;

  @override
  void onInit() {
    stopWinTextController = TextEditingController();
    stopLossTextController = TextEditingController();

    amountFocusNode.addListener(() {
      if (amountFocusNode.hasFocus && amountPercent != 0) {
        changeAmountPercent(0);
        amountTextController.clear();
      }
    });

    amountTextController = TextEditingController()
      ..addListener(() {
        _calculateMargin();
      });

    limitPriceTextController = TextEditingController()
      ..addListener(() {
        calculateOpenAmount();
        _calculateMargin();
      });

    limitTriggerPriceTextController = TextEditingController();
    limitEntrustPriceTextController = TextEditingController()
      ..addListener(() {
        calculateOpenAmount();
        _calculateMargin();
      });
    marketTriggerPriceTextController = TextEditingController();
    super.onInit();

    Bus.getInstance().on(EventType.login, (data) {
      fetchCurrentContractUserConfig();
    });
    Bus.getInstance().on(EventType.signOut, (data) {
      state.reset();
    });
    Bus.getInstance().on(EventType.refreshAsset, (data) {
      fetchCurrentContractUserConfig();
    });
  }

  @override
  void onClose() {
    amountTextController.dispose();
    limitPriceTextController.dispose();
    limitTriggerPriceTextController.dispose();
    limitEntrustPriceTextController.dispose();
    marketTriggerPriceTextController.dispose();
    stopWinTextController.dispose();
    stopLossTextController.dispose();
    super.onClose();
  }

  void changeContractInfo(ContractInfo info) {
    contractInfo.value = info;
    switchState.value = TransactionSwitchButtonValue.left;
    amountUnits.value = info.symbol.split('-');
    clear();
    fetchCurrentContractUserConfig();
  }

  clear() {
    amountTextController.clear();
    limitPriceTextController.clear();
    limitTriggerPriceTextController.clear();
    limitEntrustPriceTextController.clear();
    marketTriggerPriceTextController.clear();
    limitPriceTextController.text = getPrice();
    limitEntrustPriceTextController.text = getPrice();
    state.margin.value = 0;
    changeAmountPercent(0);
  }

  String getPrice() {
    if (contractInfo.value == null ||
        contractInfo.value!.close.isEmpty ||
        contractInfo.value!.close == '0') {
      return '';
    } else {
      int precision =
          contractInfo.value!.coinResultVo?.symbolPricePrecision.toInt() ?? 4;
      return contractInfo.value!.close.toNum().toPrecision(precision);
    }
  }

  void depthChangePrice(String price) {
    if (orderType.value == OrderType.limit) {
      limitPriceTextController.text = price;
    } else if (orderType.value == OrderType.limitStop) {
      limitEntrustPriceTextController.text = price;
    }
    calculateOpenAmount();
    _calculateMargin();
  }

  void changeAmountPercent(double percent) {
    state.amountPercent.value = percent;
    if (percent != 0) {
      // amountTextController.text = '${(percent * 100).toInt()}%';
      /// 开仓
      setAmountText();
    } else {
      amountTextController.clear();
    }
    _calculateMargin();
  }

  void setAmountText() {
    if (switchState.value == TransactionSwitchButtonValue.left) {
      if (amountUnitIndex.value == 0) {
        if (canOpenAmount.value != null) {
          amountTextController.text = (state.amountPercent.value.toDecimal() *
                  canOpenAmount.value!.toDecimal())
              .toPrecision(
                  contractInfo.value?.multiplier.numDecimalPlaces() ?? 2);
        } else {
          amountTextController.text = '0';
        }
      } else {
        amountTextController.text = (state.amountPercent.value.toDecimal() *
                availableBalance.value.toDecimal() *
                (userConfig.value?.getNowLevel() ?? 20).toDecimal())
            .toPrecision(
                contractInfo.value?.coinResultVo?.marginCoinPrecision.toInt() ??
                    4);
      }
    } else {
      /// 平仓
      amountTextController.text =
          '${(state.amountPercent.value * 100).toInt()}%';
    }
  }

  /// 修改保证金模式
  Future<void> editMarginModel(int marginModel) async {
    if (contractInfo.value == null) return;
    try {
      await ContractApi.instance()
          .marginModelEdit(contractInfo.value!.id, marginModel);
      fetchCurrentContractUserConfig();
    } on DioException catch (e) {
      UIUtil.showError(e.error.toString());
    }
  }

  /// 获取当前币种配置
  fetchCurrentContractUserConfig() async {
    if (contractInfo.value == null || !UserGetx.to.isLogin) return;
    try {
      final res =
          await ContractApi.instance().getUserConfig(contractInfo.value!.id);
      userConfig.value = res;
      calculateOpenAmount();
      _calculateMargin();
    } catch (e) {
      bobLog('error when fetchCurrentContractUserConfig: $e');
    }
  }

  Future<void> editLever(int lever) async {
    if (contractInfo.value == null) return;
    try {
      await ContractApi.instance().levelEdit(lever, contractInfo.value!.id);
      fetchCurrentContractUserConfig();
    } on DioException catch (e) {
      UIUtil.showError(e.error.toString());
    }
  }
}

extension ContractOperateControllerCal on ContractOperateController {
  /// 计算可开的量
  /// 计算可开的量 = 账户余额 * 杠杆倍数 / 价格
  calculateOpenAmount() {
    if (!UserGetx.to.isLogin || contractInfo.value == null) return;
    Decimal price = Decimal.zero;

    switch (orderType.value) {
      case OrderType.limit:
        // 限价单价格
        if (limitPriceTextController.text.trim().isEmpty) {
          state.canOpenAmount.value = 0;
          return;
        }
        price = limitPriceTextController.text.trim().toDecimal();
        break;
      case OrderType.limitStop:
        // 限价委托价
        if (limitEntrustPriceTextController.text.trim().isEmpty) {
          state.canOpenAmount.value = 0;
          return;
        }

        price = limitEntrustPriceTextController.text.trim().toDecimal();
        break;
      case OrderType.market:
      case OrderType.marketStop:
        // 市价单价格
        ContractInfo? info = ContractDataStoreController.to
            .getContractInfoByContractId(contractInfo.value!.id);
        if (info == null || info.close == '0') return;
        price = info.close.toDecimal();
        break;
    }
    if (price == Decimal.zero) return;
    state.canOpenAmount.value = (availableBalance.value.toDecimal() *
            (userConfig.value?.getNowLevel() ?? 20).toDecimal() /
            price)
        .toDecimal(
            scaleOnInfinitePrecision:
                contractInfo.value?.multiplier.numDecimalPlaces() ?? 4)
        .toPrecision(contractInfo.value?.multiplier.numDecimalPlaces() ?? 2)
        .toNum();
  }

  /// 计算保证金 按 btc/usdt 为例子
  /// 计算保证金 = 价格 * 数量 / 杠杆倍数
  _calculateMargin() {
    if (!UserGetx.to.isLogin || contractInfo.value == null) {
      state.margin.value = null;
      return;
    }

    Decimal price = Decimal.zero;
    Decimal amount = Decimal.zero;
    Decimal totalBalance = Decimal.zero;

    if (amountTextController.text.isEmpty) {
      state.margin.value = 0;
      return;
    }
    // 滑杆模式保证金 就是可用余额 * 百分比
    if (amountTextController.text.contains('%')) {
      state.margin.value =
          (availableBalance.value.toDecimal() * amountPercent.toDecimal())
              .toString()
              .toNum();
      return;
    }

    switch (orderType.value) {
      case OrderType.limit:

        /// 限价单价格
        if (limitPriceTextController.text.trim().isEmpty) {
          state.margin.value = 0;
          return;
        }
        price = limitPriceTextController.text.trim().toDecimal();
        break;
      case OrderType.limitStop:
        // 限价委托价
        if (limitEntrustPriceTextController.text.trim().isEmpty) {
          state.margin.value = 0;
          return;
        }
        price = limitEntrustPriceTextController.text.trim().toDecimal();
        break;
      case OrderType.market:
      case OrderType.marketStop:

        /// 市价单价格
        ContractInfo? info = ContractDataStoreController.to
            .getContractInfoByContractId(contractInfo.value!.id);
        if (info == null || info.close == '0') return;
        price = info.close.toDecimal();
        break;
    }

    // 保证金：滑杆模式
    if (state.amountPercent.value != 0) {
      state.margin.value = (availableBalance.value * state.amountPercent.value)
          .toString()
          .toNum();
    } else {
      // btc
      if (amountUnitIndex.value == 0) {
        // 输入数量
        amount = amountTextController.text.trim().toDecimal();
        // 总值
        totalBalance = amount * price;
        state.margin.value =
            (totalBalance / (userConfig.value?.getNowLevel() ?? 20).toDecimal())
                .toString()
                .toNum();
      } else {
        // 总值 / 杠杆倍数
        state.margin.value = (amountTextController.text.trim().toDecimal() /
                (userConfig.value?.getNowLevel() ?? 20).toDecimal())
            .toString()
            .toNum();
      }
    }
  }

  /// 计算可平的量
  calculateCloseAmount() {
    if (contractInfo.value == null || !UserGetx.to.isLogin) return;
    state.canCloseMoreAmount.value = null;
    state.canCloseMoreAmount.value = null;
    if (ContractPositionController.to.positionRes == null) return;
    Decimal openMore = Decimal.zero;
    Decimal openEmpty = Decimal.zero;
    for (var element
        in ContractPositionController.to.positionRes!.positionList) {
      if (element.contractId == contractInfo.value?.id) {
        if (element.orderSide == "BUY") {
          openMore += element.canCloseVolume.toDecimal();
        } else {
          openEmpty += element.canCloseVolume.toDecimal();
        }
      }
    }
    state.canCloseMoreAmount.value =
        (openMore * contractInfo.value!.multiplier.toDecimal()).toDouble();
    state.canCloseEmptyAmount.value =
        (openEmpty * contractInfo.value!.multiplier.toDecimal()).toDouble();
  }
}
