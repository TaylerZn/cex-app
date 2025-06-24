import 'dart:async';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_create_order_controller.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/ws/standard_socket_manager.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../getX/user_Getx.dart';
import '../../../../models/contract/res/position_res.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../utils/utilities/ui_util.dart';
import '../../../../ws/standard_future_socket_manager.dart';

class CommodityPositionController extends GetxController {
  static CommodityPositionController get to => Get.find();

  final isHideOther = false.obs;
  ContractInfo? contractInfo;
  Timer? timer;

  PositionRes? positionRes;
  RxList<PositionInfo> positionList = <PositionInfo>[].obs;
  // 当前合约的仓位数量
  RxInt count = 0.obs;
  // 仓位数量是否为空: 持有总仓位不为空，隐藏其他合约仓位时，当前合约为空也要展示 隐藏其他的开关组件，除非仓位总数为空
  RxBool isEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    Bus.getInstance().on(EventType.login, (data) {
      fetchData();
    });
    Bus.getInstance().on(EventType.signOut, (data) {
      timer?.cancel();
      positionList.clear();
      count.value = 0;
      positionRes = null;
      isEmpty.value = true;
    });
    Bus.getInstance().on(EventType.openContract, (data) {
      fetchData();
    });
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
          Get.back();
      try {
        if (contractInfo == null) return;
        var contractId = isHideOther.value ? contractInfo?.id : null;
        await CommodityApi.instance().closeAllPosition(contractId);
        fetchData();
      } catch (e) {
        Get.log('error when closeAllPosition: $e');
      }
    });
  }

  Future _fetchPosition() async {
    try {
      final res = await CommodityApi.instance().getAssetsList('0', null);
      _handle(res);
    } catch (e) {
      Get.log('error when _fetchPosition: $e');
    }
  }

  Future fetchData() async {
    if (!UserGetx.to.isLogin) return;
    await _fetchPosition();
    StandardFutureSocketManager.instance.subAssetList(callback: (PositionRes res) {
      _handle(res);
    });
  }

  _handle(PositionRes res) {
    /// 当前合约的仓位排在前面
    res.positionList.sort((a, b) {
      if (a.contractId == contractInfo?.id) {
        return -1;
      } else if (b.contractId == contractInfo?.id) {
        return 1;
      } else {
        return 0;
      }
    });
    res.positionList.forEach((element) {
      if (element.contractId == contractInfo?.id) {
        CommodityController.to.holdAmount.value = element.holdAmount;
      }
    });
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
    CommodityController.to.state.availableBalance.value =
        res.accountList.safeFirst?.canUseAmount ?? 0;
    CommodityController.to.calculateCanCloseAmount();
    CommodityController.to.calculateCanOpenAmount();
    if (CommodityController.to.state.percent.value != 0) {
      CommodityController.to.setAmountText();
    }
  }
}
