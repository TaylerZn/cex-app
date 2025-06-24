import 'dart:async';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_operate_controller.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/ws/future_socket_manager.dart';
import 'package:nt_app_flutter/app/ws/standard_future_socket_manager.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../models/contract/res/position_res.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../utils/bus/event_bus.dart';
import '../../../../utils/bus/event_type.dart';

class ContractPositionController extends GetxController {
  static ContractPositionController get to => Get.find();

  final isHideOther = false.obs;
  ContractInfo? contractInfo;
  PositionRes? positionRes;
  RxList<PositionInfo> positionList = <PositionInfo>[].obs;
  RxInt count = 0.obs;
  // 持有仓位是否为空
  RxBool isEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    Bus.getInstance().on(EventType.login, (data) {
      fetchData();
    });
    Bus.getInstance().on(EventType.signOut, (data) {
      positionList.clear();
      count.value = 0;
      positionRes = null;
      isEmpty.value = true;
    });
    Bus.getInstance().on(EventType.openContract, (data) {
      fetchData();
    });
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.login, (data) {});
    Bus.getInstance().off(EventType.signOut, (data) {});
    Bus.getInstance().off(EventType.openContract, (data) {});
    super.onClose();
  }

  void changeContractInfo(ContractInfo contractInfo) {
    this.contractInfo = contractInfo;
    fetchData();
  }

  /// 是否有仓位
  bool checkHasPosition() {
    return positionList
        .any((element) => element.contractId == contractInfo?.id);
  }

  void onHideOther() {
    isHideOther.toggle();
    fetchData();
  }

  void onOneKeyClose() {
    UIUtil.showConfirm(LocaleKeys.trade60.tr, content: LocaleKeys.trade61.tr,
        confirmHandler: () async {
      try {
        if (contractInfo == null) return;
        var contractId = isHideOther.value ? contractInfo?.id : null;
        await ContractApi.instance().closeAllPosition(contractId);
        fetchData();
        Get.back();
      } catch (e) {
        Get.log('error when closeAllPosition: $e');
      }
    });
  }

  fetchPosition() async {
    try {
      final res = await ContractApi.instance().getAssetsList('0', null);
      _handlePosition(res);
    } catch (e) {
      Get.log('error when _fetchPosition: $e');
    }
  }

  fetchData() {
    if (!UserGetx.to.isLogin) return;
    fetchPosition();
    FuturetSocketManager.instance.subAssetList(callback: (PositionRes res) {
      _handlePosition(res);
    });
  }

  _handlePosition(PositionRes res) {
    ///I 当前合约的仓位排在前面
    res.positionList.sort((a, b) {
      if (a.contractId == contractInfo?.id) {
        return -1;
      } else if (b.contractId == contractInfo?.id) {
        return 1;
      } else {
        return 0;
      }
    });
    for (var element in res.positionList) {
      if (element.contractId == contractInfo?.id) {
        ContractOperateController.to.holdAmount.value = element.holdAmount;
      }
    }
    if (isHideOther.value) {
      positionList.value = res.positionList
          .where((element) => element.contractId == contractInfo?.id)
          .toList();
    } else {
      positionList.value = res.positionList;
      isEmpty.value = positionList.isEmpty;
    }
    count.value = positionList.length;
    positionRes = res;
    ContractOperateController.to.state.availableBalance.value =
        res.accountList.safeFirst?.canUseAmount ?? 0;
    ContractOperateController.to.calculateCloseAmount();
    ContractOperateController.to.calculateOpenAmount();
    if (ContractOperateController.to.state.amountPercent.value != 0) {
      ContractOperateController.to
          .changeAmountPercent(ContractOperateController.to.amountPercent);
    }
  }
}
