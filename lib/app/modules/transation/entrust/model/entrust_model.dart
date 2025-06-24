import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/iconfont/icon_fonts.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_enum.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//

class TransactionModel {
  BehaviorType type;
  Rx<TransactionBaseModel> data = TransactionBaseModel().obs;
  Rx<OrderRes> orderData = OrderRes(current: 0, total: 0, data: [], size: -1).obs;

  String? desText;
  FillterModel? rightModel;
  List<FillterModel>? filterModelArray;
  RefreshController refreshVC = RefreshController();
  num? filterContractId;
  num filterType = 1;
  String filterStateStr = '[2,4,6]';
  num? filterHistoryBeginTime; //历史委托
  num? filterHistoryEndTime; //历史委托

  num? filterHistoryTradeBeginTime;
  num? filterHistoryTradeEndTime;

  num? filterHistoryContractId; //历史成交
  num? filterFlowType; //资金流水
  num? filterFlowBeginTime; //资金流水
  num? filterFlowEndTime; //资金流水

  Function()? callback;
  TransactionModel(this.type, this.callback) {
    switch (type) {
      case BehaviorType.currentEntrust: //当前委托
        filterModelArray = [
          FillterModel(type, FilterType.contract, ({String? stateStr, num? index}) {
            filterContractId = index;
            callback?.call();
          }),
          FillterModel(type, FilterType.orderType, ({String? stateStr, num? index}) {
            filterType = index!;
            callback?.call();
          })
        ];
        rightModel = FillterModel(type, FilterType.rightType, ({String? stateStr, num? index}) {});
        break;
      case BehaviorType.historyEntrust: //历史委托
        filterModelArray = [
          FillterModel(type, FilterType.contract, ({String? stateStr, num? index}) {
            filterContractId = index;
            callback?.call();
          }),
          FillterModel(type, FilterType.orderType, ({String? stateStr, num? index}) {
            filterType = index!;
            filterStateStr = filterType == 99 ? '[1,2,3,4]' : '[2,4,6]';
            callback?.call();
          }),
          FillterModel(type, FilterType.status, ({String? stateStr, num? index}) {
            filterStateStr = stateStr!;
            callback?.call();
          })
        ];
        rightModel = FillterModel(type, FilterType.rightType, ({String? stateStr, num? index}) {
          var timeArr = getTime(dayStr: index!.toInt());

          filterHistoryBeginTime = (timeArr.first / 1000).floor();
          filterHistoryEndTime = (timeArr.last / 1000).ceil();
          callback?.call();
        });
        var timeArr = getTime();
        filterHistoryBeginTime = (timeArr.first / 1000).floor();
        filterHistoryEndTime = (timeArr.last / 1000).ceil();
        filterType = 0;
        break;

      case BehaviorType.historicalTrans: //历史成交
        filterModelArray = [
          FillterModel(type, FilterType.contract, ({String? stateStr, num? index}) {
            filterHistoryContractId = index;
            callback?.call();
          })
        ];
        // rightModel = FillterModel(type, FilterType.rightType, null);
        rightModel = FillterModel(type, FilterType.rightType, ({String? stateStr, num? index}) {
          var timeArr = getTime(dayStr: index!.toInt());
          filterHistoryTradeBeginTime = timeArr.first;
          filterHistoryTradeEndTime = timeArr.last;
          callback?.call();
        });
        var timeArr = getTime();
        filterHistoryTradeBeginTime = timeArr.first;
        filterHistoryTradeEndTime = timeArr.last;
        break;
      case BehaviorType.flowFunds: //资金流水
        filterModelArray = [
          FillterModel(type, FilterType.fundType, ({String? stateStr, num? index}) {
            filterFlowType = index == 0 ? null : index;
            callback?.call();
          })
        ];
        rightModel = FillterModel(type, FilterType.rightType, ({String? stateStr, num? index}) {
          var timeArr = getTime(dayStr: index!.toInt());
          filterFlowBeginTime = timeArr.first;
          filterFlowEndTime = timeArr.last;
          callback?.call();
        });
        var timeArr = getTime();
        filterFlowBeginTime = timeArr.first;
        filterFlowEndTime = timeArr.last;

        break;
      case BehaviorType.locationHistory:
        break;
      case BehaviorType.capitalCost:
        break;
      default:
    }
  }

  List<int> getTime({int dayStr = 7}) {
    DateTime now = DateTime.now();
    DateTime oneWeekAgo = now.subtract(Duration(days: dayStr));
    return [oneWeekAgo.millisecondsSinceEpoch, now.millisecondsSinceEpoch];
  }
}

class FillterModel {
  BehaviorType type;
  FilterType filterType;
  String title = '';
  String? rightText;
  String? rightBtn;
  IconData? rightIcon;
  RxList<String> actionArray = <String>[].obs;
  BottomViewType bottomType = BottomViewType.defaultView;
  var topTitle = ''.obs;
  var timeIndex = 1.obs;

  Function({num? index, String? stateStr})? callback;
  int currentIndex = 0;
  List<FilterStateModel> stateArray = [];
  var controller = TextEditingController();
  var nameArray = ContractDataStoreController.to.contractList.map((e) => '${e.firstName}${e.secondName}').toList();

  FillterModel(this.type, this.filterType, this.callback) {
    topTitle.value = filterType.value;
    controller.addListener(() {
      String keyword = controller.text.trim();
      if (keyword.isNotEmpty) {
        currentIndex = -1;
        actionArray.value = actionArray.where((element) => element.contains(keyword.toUpperCase())).toList();
      } else {
        switch (type) {
          case BehaviorType.currentEntrust:
            actionArray.value = [LocaleKeys.trade115.tr, ...nameArray];
            break;
          case BehaviorType.historyEntrust: //历史委托
            actionArray.value = [LocaleKeys.trade115.tr, ...nameArray];
            break;
          case BehaviorType.historicalTrans: //历史成交
            actionArray.value = [LocaleKeys.trade115.tr, ...nameArray];

          default:
        }

        var model = ContractDataStoreController.to.contractList
            .firstWhere((e) => e.contractOtherName == topTitle.value, orElse: () => ContractInfo.fromJson({}));

        var modelindex = actionArray.indexOf('${model.firstName}${model.secondName}');
        currentIndex = modelindex < 0 ? 0 : modelindex;
      }
    });
    switch (type) {
      case BehaviorType.currentEntrust: //当前委托
        if (filterType == FilterType.contract) {
          title = LocaleKeys.trade121.tr;
          actionArray.value = [LocaleKeys.trade115.tr, ...nameArray];
        } else if (filterType == FilterType.orderType) {
          title = LocaleKeys.trade122.tr;
          actionArray.value = [LocaleKeys.trade116.tr, LocaleKeys.trade41.tr, LocaleKeys.trade30.tr];
        } else {
          rightBtn = LocaleKeys.trade57.tr;
        }

        break;
      case BehaviorType.historyEntrust: //历史委托
        if (filterType == FilterType.contract) {
          title = LocaleKeys.trade121.tr;
          actionArray.value = [LocaleKeys.trade115.tr, ...nameArray];
        } else if (filterType == FilterType.orderType) {
          title = LocaleKeys.trade122.tr;
          topTitle.value = LocaleKeys.trade115.tr;

          actionArray.value = [
            LocaleKeys.trade115.tr,
            LocaleKeys.trade116.tr,
            LocaleKeys.trade41.tr,
            LocaleKeys.trade30.tr,
            LocaleKeys.trade288.tr,
          ];
        } else if (filterType == FilterType.status) {
          title = LocaleKeys.trade118.tr;
          stateArray = [
            FilterStateModel()
              ..name = LocaleKeys.trade123.tr
              ..value = 2,
            FilterStateModel()
              ..name = LocaleKeys.trade124.tr
              ..value = 6,
            FilterStateModel()
              ..name = LocaleKeys.trade125.tr
              ..value = 4,
          ];
          bottomType = BottomViewType.multipleChoice;
        } else {
          rightIcon = MyIconFonts.filter;
          actionArray.value = [LocaleKeys.trade126.tr, LocaleKeys.trade127.tr, LocaleKeys.trade128.tr, LocaleKeys.trade129.tr];
          currentIndex = 1;
        }

        break;

      case BehaviorType.historicalTrans: //历史成交
        if (filterType == FilterType.contract) {
          title = LocaleKeys.trade121.tr;
          actionArray.value = [LocaleKeys.trade115.tr, ...nameArray];

          // topTitle.value = nameArray.isNotEmpty ? nameArray.first : 'BTCUSDT';
        } else {
          rightIcon = MyIconFonts.filter;
          actionArray.value = [LocaleKeys.trade126.tr, LocaleKeys.trade127.tr, LocaleKeys.trade128.tr, LocaleKeys.trade129.tr];
          currentIndex = 1;
        }
        break;
      case BehaviorType.flowFunds: //资金流水
        if (filterType == FilterType.fundType) {
          title = LocaleKeys.trade53.tr;
          actionArray.value = [
            LocaleKeys.trade115.tr,
            LocaleKeys.trade131.tr,
            LocaleKeys.trade132.tr,
            LocaleKeys.trade133.tr,
            LocaleKeys.trade134.tr,
            LocaleKeys.trade135.tr,
            LocaleKeys.trade136.tr,
            LocaleKeys.trade137.tr,
            LocaleKeys.trade138.tr,
            LocaleKeys.trade139.tr,
            LocaleKeys.trade392.tr,
          ];
        } else {
          rightIcon = MyIconFonts.filter;
          actionArray.value = [LocaleKeys.trade126.tr, LocaleKeys.trade127.tr, LocaleKeys.trade128.tr, LocaleKeys.trade129.tr];
          currentIndex = 1;
        }

        break;
      case BehaviorType.locationHistory:
        break;
      case BehaviorType.capitalCost:
        break;
      default:
    }
  }

  stateFilter() {
    var array = stateArray.where((element) => element.select).map((e) => e.value).toList();
    callback?.call(stateStr: jsonEncode(array.isNotEmpty ? array : [2, 4, 6]));
  }

  set filterIndex(int i) {
    if (i == currentIndex) return;
    currentIndex = i;

    if (filterType == FilterType.contract) {
      var model = ContractDataStoreController.to.contractList
          .firstWhere((e) => '${e.firstName}${e.secondName}' == actionArray[i], orElse: () => ContractInfo.fromJson({}));
      //合约筛选
      topTitle.value = model.contractName.isEmpty ? LocaleKeys.trade115.tr : model.contractOtherName;
      callback?.call(index: model.contractName.isEmpty ? null : model.id);
      actionArray.value = [LocaleKeys.trade115.tr, ...nameArray];

      var modelindex = actionArray.indexOf('${model.firstName}${model.secondName}');
      currentIndex = modelindex < 0 ? 0 : modelindex;
    } else if (filterType == FilterType.orderType) {
      //订单类型
      topTitle.value = actionArray[i];
      var index = type == BehaviorType.historyEntrust ? [0, 1, 2, 99, 6][i] : [1, 2, 99][i];
      callback?.call(index: index);
    } else if (filterType == FilterType.fundType) {
      //资金流水
      topTitle.value = actionArray[i];
      callback?.call(index: i == actionArray.length - 1 ? 13 : i);
    } else if (filterType == FilterType.rightType) {
      //资金流水 历史委托 时间筛选
      callback?.call(index: [1, 7, 30, 90][i]);
    }
    // }
  }

  textClear() {
    if (filterType == FilterType.contract) {
      controller.clear();
    }
  }
}

class FilterStateModel {
  String name = '';
  int value = 2;
  bool select = false;
}
