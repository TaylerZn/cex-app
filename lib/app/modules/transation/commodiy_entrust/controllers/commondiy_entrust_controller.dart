import 'dart:async';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/ws/standard_future_socket_manager.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../getX/user_Getx.dart';
import '../../../../models/contract/res/order_info.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../utils/bus/event_bus.dart';
import '../../../../utils/bus/event_type.dart';
import '../../../../utils/utilities/ui_util.dart';

class CommodityEntrustController extends GetxController {
  static CommodityEntrustController get to => Get.find();
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

  @override
  void onClose() {
    Bus.getInstance().off(EventType.login, (data) {});
    Bus.getInstance().off(EventType.signOut, (data) {});
    Bus.getInstance().off(EventType.openContract, (data) {});
    super.onClose();
  }

  changeContractInfo(ContractInfo contractInfo) {
    this.contractInfo = contractInfo;
    fetchData();
  }

  void onHideOther() {
    isHideOther.toggle();
    fetchData();
  }

  Future<void> onOneKeyClose() async {
    try {
      await CommodityApi.instance().cancelAllOrder();
      fetchData();
      UIUtil.showSuccess(LocaleKeys.trade62.tr);
    } catch (e) {
      UIUtil.showToast(LocaleKeys.trade63.tr);
    }
  }

  void onCancelOrder(OrderInfo orderInfo) async {
    try {
      bool isConditionOrder = orderInfo.triggerType != 0;
      await CommodityApi.instance()
          .cancelOrder(orderInfo.id, isConditionOrder, orderInfo.contractId);
      fetchData();
      UIUtil.showSuccess(LocaleKeys.trade58.tr);
    } catch (e) {
      UIUtil.showToast(LocaleKeys.trade59.tr);
    }
  }

  Future fetchData() async {
    if (!UserGetx.to.isLogin || !UserGetx.to.isOpenContract) return;
    await _fetchEntrust();
  }

  /// 检查当前合约是否有订单 有订单不能调整杠杆
  bool checkCurrentContractHasOrder(ContractInfo contractInfo) {
    return dataList
          .any((element) => element.contractId == contractInfo.id);
  }

  _fetchEntrust() async {
    try {
      /// 隐藏其他合约只显示传contractId
      num? contractId = isHideOther.value ? contractInfo?.id : null;
      // List<OrderRes> list = await Future.wait([
      //   CommodityApi.instance().findCoOrder(0, 100, contractId, '[0,1,3,5]'),
      //   CommodityApi.instance()
      //       .findTriggerOrder(0, 100, contractId, '[0,1,3,5]')
      // ]);
      // List<OrderInfo> targetList = list[0].data;
      // targetList.addAll(list[1].data);
      // /// 隐藏其他合约
      // if(isHideOther.value){
      //   targetList.removeWhere((element) => element.contractId != contractId);
      // }
      // dataList.value = targetList;
      // count.value = dataList.length;
      // if (contractId == null) {
      //   isEmpty.value = count.value == 0;
      // }
      StandardFutureSocketManager.instance.subAllOrder(contractId,callback: (order){
        /// 隐藏其他合约
        if(isHideOther.value){
          order.data.removeWhere((element) => element.contractId != contractId);
        }
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
