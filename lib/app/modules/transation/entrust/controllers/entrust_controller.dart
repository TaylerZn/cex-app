import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_enum.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_flow_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_historical_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_bottomSheet.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
//

class EntrustController extends GetxController with GetSingleTickerProviderStateMixin {
  List<TransactionModel> tabs = [];
  var index = 0;
  var showExport = false.obs;
  late TabController tabController;
  RxList<String> tabBarArray = <String>[].obs;
  @override
  void onInit() {
    super.onInit();

    tabs = <TransactionModel>[
      TransactionModel(BehaviorType.currentEntrust, () => getData(isPullDown: true, isFilter: true)),
      TransactionModel(BehaviorType.historyEntrust, () => getData(isPullDown: true, isFilter: true)),
      TransactionModel(BehaviorType.historicalTrans, () => getData(isPullDown: true, isFilter: true)),
      TransactionModel(BehaviorType.flowFunds, () => getData(isPullDown: true, isFilter: true)),
    ];

    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
        getData();
      }
    });

    tabBarArray.value = tabs.map((e) => e.type.value).toList();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future? getData({bool isPullDown = false, bool isFilter = false}) {
    var model = tabs[index];
    if (isPullDown) {
      if (index < 2) {
        model.orderData.value.page = 1;
      } else {
        model.data.value.page = 1;
      }
    } else {
      if ((model.data.value.orderList != null || model.orderData.value.data.isNotEmpty) && model.data.value.page == 1) {
        return null;
      }
    }
    switch (model.type) {
      case BehaviorType.currentEntrust:
        return getEntrustList(model,
            status: model.filterType == 99 ? '[0]' : '[0,1,3,5]', isPullDown: isPullDown, isFilter: isFilter);
      case BehaviorType.historyEntrust:
        return getEntrustList(model,
            status: model.filterStateStr,
            isPullDown: isPullDown,
            isFilter: isFilter,
            beginTime: model.filterHistoryBeginTime,
            endTime: model.filterHistoryEndTime);

      case BehaviorType.flowFunds: //资金流水
        if (isFilter) model.data.value = TransactionBaseModel();
        return AFContractTransactions.getFlowFundsList(
                page: model.data.value.page,
                pageSize: model.data.value.pageSize,
                type: model.filterFlowType,
                beginTime: model.filterFlowBeginTime,
                endTime: model.filterFlowEndTime)
            .then((value) {
          setTransactionBaseModel(model, value);
        });

      case BehaviorType.historicalTrans: //历史成交
        if (isFilter) model.data.value = TransactionBaseModel();
        return AFContractTransactions.gethisTradeList(
                page: model.data.value.page,
                pageSize: model.data.value.pageSize,
                contractId: model.filterHistoryContractId,
                beginTime: model.filterHistoryTradeBeginTime,
                endTime: model.filterHistoryTradeEndTime)
            .then((value) {
          setTransactionBaseModel(model, value);
        });

      case BehaviorType.locationHistory: //仓位历史
        return null;

      case BehaviorType.capitalCost: //资金费用
        return null;

      default:
        return null;
    }
  }

  getEntrustList(TransactionModel model,
      {required String status, bool isPullDown = false, bool isFilter = false, num? beginTime, num? endTime}) {
    if (isFilter) {
      model.orderData.value = OrderRes(current: 0, total: 0, data: [], size: -1);
    }
    if (model.filterType < 99) {
      return AFContractTransactions.getContractCurrentList(
              status: status,
              contractId: model.filterContractId,
              type: model.filterType == 0 ? null : model.filterType,
              beginTime: beginTime,
              endTime: endTime)
          .then((value) {
        setOrderResModel(model, value);
      });
    } else {
      return AFContractTransactions.getTriggerOrderList(
              status: status, contractId: model.filterContractId, beginTime: beginTime, endTime: endTime)
          .then((value) {
        setOrderResModel(model, value);
      });
    }
  }

  setTransactionBaseModel(TransactionModel model, TransactionBaseModel value) {
    int page = model.data.value.page;
    var pageSize = value.orderList?.length;

    if (page != 1) {
      model.data.value.orderList?.addAll(value.orderList ?? []);
      value.orderList = model.data.value.orderList;
    }
    model.data.value = value;

    model.data.value.page = page;
    model.data.value.haveMore = pageSize == model.data.value.pageSize;
  }

  setOrderResModel(TransactionModel model, OrderRes value) {
    int page = model.orderData.value.page;
    var pageSize = value.data.length;

    if (page != 1) {
      model.orderData.value.data.addAll(value.data);
      value.data = model.orderData.value.data;
    }
    model.orderData.value = value;

    model.orderData.value.page = page;
    model.orderData.value.haveMore = pageSize == model.orderData.value.pageSize;
    if (model.type == BehaviorType.currentEntrust) {
      if (model.orderData.value.data.isNotEmpty == true) {
        List<String> array = [];
        for (var i = 0; i < tabs.length; i++) {
          if (i == 0) {
            array.add('${tabs[i].type.value} (${model.orderData.value.data.length})');
          } else {
            array.add(tabs[i].type.value);
          }
        }
        tabBarArray.value = array;
      } else {
        tabBarArray.value = tabs.map((e) => e.type.value).toList();
      }
    }
  }

  cancelOrder({String orderId = '', num contractId = 0, int currentIndex = 0}) {
    var model = tabs.first;
    ContractApi.instance().cancelOrder(orderId, model.filterType < 3 ? false : true, contractId).then((value) {
      var temp = model.orderData.value;
      var order = OrderRes(current: temp.current, total: temp.total, size: temp.size, data: temp.data);
      order.data.removeAt(currentIndex);
      model.orderData.value = order;
      UIUtil.showSuccess(LocaleKeys.trade58.tr);
    }).catchError((e) {
      UIUtil.showToast(LocaleKeys.trade59.tr);
    });
  }

  cancelAllOrder() {
    var model = tabs.first;
    ContractApi.instance().cancelAllOrder().then((value) {
      model.orderData.value = OrderRes(current: 0, total: 0, data: [], size: 0);
      UIUtil.showSuccess(LocaleKeys.trade58.tr);
    }).catchError((e) {
      UIUtil.showToast(LocaleKeys.trade59.tr);
    });
  }

  set currentIndex(int value) {
    index = value;
    showExport.value = tabs[value].type == BehaviorType.historicalTrans;
  }

  showExportView() {
    var model = tabs[index];
    showBottomSheetView(model.rightModel!, bottomType: BottomViewType.exportView);
  }
}

extension AFContractTransactions on EntrustController {
  static Future<OrderRes> getContractCurrentList(
      {int page = 1, int pageSize = 10, String status = '', num? contractId, num? type, num? beginTime, num? endTime}) async {
    try {
      return await ContractApi.instance()
          .findCoOrder(page, pageSize, contractId, status, type: type, createTimeStart: beginTime, createTimeEnd: endTime)
        ..isError = false;
    } on dio.DioException catch (e) {
      return OrderRes(current: 0, total: 0, data: [], size: 0)
        ..isError = true
        ..exception = e;
    }
  }

  static Future<OrderRes> getTriggerOrderList(
      {int page = 1, int pageSize = 10, String status = '', num? contractId, num? type, num? beginTime, num? endTime}) async {
    try {
      return await ContractApi.instance()
          .findTriggerOrder(page, pageSize, contractId, status, type: type, createTimeStart: beginTime, createTimeEnd: endTime)
        ..isError = false;
    } on dio.DioException catch (e) {
      return OrderRes(current: 0, total: 0, data: [], size: 0)
        ..isError = true
        ..exception = e;
    }
  }

  static Future<TransactionHistoricalTrans> gethisTradeList(
      {int page = 1, int pageSize = 10, num? contractId, num? beginTime, num? endTime}) async {
    try {
      return await ContractApi.instance().hisTradeList(pageSize, page, contractId, beginTime: beginTime, endTime: endTime)
        ..isError = false;
    } on dio.DioException catch (e) {
      return TransactionHistoricalTrans()
        ..orderList = []
        ..isError = true
        ..exception = e;
    }
  }

  static Future<TransactionFlowFunds> getFlowFundsList(
      {int page = 1, int pageSize = 10, String symbol = 'USDT', num? type, num? beginTime, num? endTime}) async {
    try {
      return await ContractApi.instance()
          .flowFundsList(pageSize, page, symbol, type: type, beginTime: beginTime, endTime: endTime)
        ..isError = false;
    } on dio.DioException catch (e) {
      return TransactionFlowFunds()
        ..orderList = []
        ..isError = true
        ..exception = e;
    }
  }
}
