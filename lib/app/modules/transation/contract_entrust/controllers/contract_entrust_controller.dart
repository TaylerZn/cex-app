import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/ws/future_socket_manager.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../api/contract/contract_api.dart';
import '../../../../models/contract/res/order_info.dart';
import '../../../../models/contract/res/public_info.dart';

class ContractEntrustController extends GetxController {
  static ContractEntrustController get to => Get.find();
  ContractInfo? contractInfo;
  RxList<OrderInfo> dataList = RxList();
  RxInt count = 0.obs;
  RxBool isEmpty = true.obs;
  final isHideOther = false.obs;

  @override
  void onInit() {
    super.onInit();
    Bus.getInstance().on(EventType.login, (data) {
      fetchData();
    });
    Bus.getInstance().on(EventType.signOut, (data) {
      dataList.clear();
      count.value = 0;
      isEmpty.value = true;
    });
    Bus.getInstance().on(EventType.openContract, (data) {
      fetchData();
    });
  }

  void onHideOther() {
    isHideOther.toggle();
    fetchData();
  }

  Future<void> onOneKeyClose() async {
    try {
      await ContractApi.instance().cancelAllOrder();
      fetchData();
      UIUtil.showSuccess(LocaleKeys.trade62.tr);
    } catch (e) {
      UIUtil.showError(LocaleKeys.trade63.tr);
    }
  }

  void onCancelOrder(OrderInfo orderInfo) async {
    try {
      bool isConditionOrder = orderInfo.triggerType != 0;
      await ContractApi.instance().cancelOrder(
          orderInfo.id, isConditionOrder ? true : null, orderInfo.contractId);
      fetchData();
      UIUtil.showSuccess(LocaleKeys.trade58.tr);
    } catch (e) {
      UIUtil.showError(LocaleKeys.trade59.tr);
    }
  }

  changeContractInfo(ContractInfo contractInfo) {
    this.contractInfo = contractInfo;
    count.value = 0;
    fetchData();
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.login, (data) {});
    Bus.getInstance().off(EventType.signOut, (data) {});
    Bus.getInstance().off(EventType.openContract, (data) {});
    super.onClose();
  }

  /// 检查当前合约是否有订单
  bool checkCurrentContractHasOrder(ContractInfo contractInfo) {
    return dataList.any((element) => element.contractId == contractInfo.id);
  }
}

extension CurrentEntrustControllerExt on ContractEntrustController {
  Future fetchData() async {
    if (!UserGetx.to.isLogin || !UserGetx.to.isOpenContract) return;
    fetchEntrust();
  }

  fetchEntrust() async {
    try {
      /// 隐藏其他合约只显示传contractId
      num? contractId = isHideOther.value ? contractInfo?.id : null;
      List<OrderRes> list = await Future.wait([
        ContractApi.instance().findCoOrder(1, 100, contractId, '[0,1,3,5]'),
        ContractApi.instance().findTriggerOrder(1, 100, contractId, '[0]')
      ]);
      List<OrderInfo> targetList = [];
      targetList.addAll(list[0].data);
      targetList.addAll(list[1].data);
      if (isHideOther.value) {
        targetList.removeWhere((element) => element.contractId != contractId);
      }
      Get.log('+++ targetList: ${targetList.length}');

      dataList.value = targetList;
      count.value = dataList.length;

      if (contractId == null) {
        isEmpty.value = count.value == 0;
      }
      FuturetSocketManager.instance.subAllOrder(contractId,
          callback: (OrderRes order) {
        /// 隐藏其他合约只显示传contractId
        if (isHideOther.value) {
          order.data.removeWhere((element) => element.contractId != contractId);
        }
        Get.log('+++ order.data: ${order.data.length}');
        dataList.value = order.data;
        count.value = dataList.length;
        if (contractId == null) {
          isEmpty.value = count.value == 0;
        }
      });
    } catch (e) {
      Get.log('error when _fetchEntrust: $e');
    }
  }
}
