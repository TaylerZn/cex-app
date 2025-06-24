// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:collection';

import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:k_chart/utils/data_util.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/price_detail_view.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../models/contract/res/depth_info.dart';
import '../../../../../models/contract/res/history_trade_info.dart';
import '../../../../../ws/contract_socket_manager.dart';
import '../../../../../ws/core/model/ws_receive_data.dart';
import '../../../mixin/price_controller_mixin.dart';
import '../../../widgets/price/widgets/kchart/model/sub_time.dart';

class ContractPriceController extends GetxController with PriceControllerMixin {
  static ContractPriceController get to => Get.find();

  RxPriceDetailState detailState = RxPriceDetailState();

  ContractInfo? contractInfo;

  /// k线正在加载更多
  bool hasMore = true;
  bool isLoadingMore = false;
  LinkedHashMap<int, KLineEntity> kLineData = LinkedHashMap();

  @override
  void onInit() {
    super.onInit();
    ContractInfo contractInfo = Get.arguments;
    contractInfo = ContractDataStoreController.to
            .getContractInfoByContractId(contractInfo.id) ??
        contractInfo;
    changeContractInfo(contractInfo);
  }

  changeContractInfo(ContractInfo contractInfo) {
    if (this.contractInfo != null) {
      unSubContract(this.contractInfo!);
      unSubKline(
          this.contractInfo!, detailState.kChartState.subTime.value.subTime);
      detailState.kChartState.datas.clear();
      detailState.kChartState.bids.clear();
      detailState.kChartState.asks.clear();
      detailState.asks.clear();
      detailState.buys.clear();
      detailState.historyTrade.clear();
      detailState.contractInfo.value = contractInfo;
    }
    hasMore = true;
    isLoadingMore = false;
    this.contractInfo = contractInfo;
    subContract(contractInfo);
    subKline(contractInfo, detailState.kChartState.subTime.value.subTime);
    subDepthTrade(contractInfo);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    unSubContract(contractInfo!);
    unSubKline(contractInfo!, detailState.kChartState.subTime.value.subTime);
    unSubDepthTrade(contractInfo!);
    super.onClose();
  }
}

extension PriceControllerAPi on ContractPriceController {
  unSubDepthTrade(ContractInfo info) {
    ContractSocketManager.instance.unSubDepthTrade(info.subSymbol);
  }

  subDepthTrade(ContractInfo info) {
    ContractSocketManager.instance.subDepthTrade(info.subSymbol,
        (symbol, data) {
      if (info.subSymbol != symbol || data.tick == null) return;
      if (ObjectUtil.isEmpty(data.tick) || contractInfo?.subSymbol != symbol) {
        return;
      }
      DepthTick depthTick = DepthTick.fromJson(data.tick!);
      var asks = <DepthEntity>[];
      asks.addAll(depthTick.asks
              ?.map((e) => DepthEntity(
                  e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
              .toList() ??
          []);
      asks.removeWhere((element) => element.vol.toDecimal() == Decimal.zero);
      asks = mergeDepthEntities(asks);

      var buys = <DepthEntity>[];
      buys.addAll(depthTick.buys
              ?.map((e) => DepthEntity(
                  e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
              .toList() ??
          []);
      buys.removeWhere((element) => element.vol.toDecimal() == Decimal.zero);
      buys = mergeDepthEntities(buys);
      detailState.kChartState.asks.assignAll(asks);
      detailState.kChartState.bids.assignAll(buys.reversed.toList());
    });
  }
}

///////////////////////////////////////////////////////////////
////////////////          合约ws      //////////////////
///////////////////////////////////////////////////////////////
extension PriceControllerWS on ContractPriceController {
  subContract(ContractInfo info) {
    /// 订阅盘口数据
    ContractSocketManager.instance.subDepth(info.subSymbol, 0, (symbol, data) {
      if (ObjectUtil.isEmpty(data.tick) || info.subSymbol != symbol) {
        return;
      }
      _handleData(info.subSymbol, symbol, data);
    });

    /// 订阅历史成交
    ContractSocketManager().reqTradeTicker(info.subSymbol, (symbol, data) {
      if (info.subSymbol != symbol || data.data == null) return;
      try {
        List<HistoryTradeInfo> historyTradeInfo =
            HistoryTradeInfo.fromJsonList(data.data!);

        /// 根据时间排序
        historyTradeInfo.sort((a, b) => b.ts.compareTo(a.ts));

        /// 前后两个价格比较，上涨绿色，下降红色
        for (int i = historyTradeInfo.length - 1; i > 0; i--) {
          if (i == historyTradeInfo.length - 1) {
            historyTradeInfo[i].priceColor = AppColor.downColor;
          } else {
            if (historyTradeInfo[i - 1].price.toDecimal() >
                historyTradeInfo[i].price.toDecimal()) {
              historyTradeInfo[i - 1].priceColor = AppColor.upColor;
            } else {
              historyTradeInfo[i - 1].priceColor = AppColor.downColor;
            }
          }
        }
        detailState.historyTrade.assignAll(historyTradeInfo);
      } catch (error) {
        Get.log(error.toString());
      }
    });

    /// 实时成交
    ContractSocketManager().subTradeTicker(info.subSymbol, (symbol, data) {
      if (info.subSymbol != symbol || data.tick == null) return;
      try {
        HistoryTradeRes historyTradeRes = HistoryTradeRes.fromJson(data.tick!);
        List<HistoryTradeInfo> historyTradeInfo = historyTradeRes.data ?? [];

        /// 根据时间排序
        historyTradeInfo.sort((a, b) => b.ts.compareTo(a.ts));

        /// 前后两个价格比较，上涨绿色，下降红色
        for (int i = historyTradeInfo.length - 1; i > 0; i--) {
          if (i == historyTradeInfo.length - 1) {
            historyTradeInfo[i].priceColor = AppColor.downColor;
          } else {
            if (historyTradeInfo[i - 1].price.toDecimal() >
                historyTradeInfo[i].price.toDecimal()) {
              historyTradeInfo[i - 1].priceColor = AppColor.upColor;
            } else {
              historyTradeInfo[i - 1].priceColor = AppColor.downColor;
            }
          }
        }
        detailState.historyTrade.insertAll(0, historyTradeInfo);
      } catch (e) {
        bobLog('永续合约 subTradeTicker error ${e.toString()}');
      }
    });
  }

  subKline(ContractInfo contractInfo, String subTime) {
    detailState.kChartState.isLoading.value = true;
    detailState.kChartState.datas.clear();
    kLineData.clear();
    ContractSocketManager().reqKline(contractInfo.subSymbol, subTime,
        (symbol, data) {
      if (symbol != contractInfo.subSymbol || data.data == null) return;
      try {
        /// 停止加载
        detailState.kChartState.isLoading.value = false;
        List<KLineEntity> list = data.data
            .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<KLineEntity>();
        for (var element in list) {
          if (element.isValidData()) {
            kLineData[element.time ?? 0] = element;
          }
        }

        /// 去重复
        list = kLineData.values.toList();
        if (list.isNotEmpty) {
          /// 排序
          list.sort((a, b) => a.time?.compareTo(b.time ?? 0) ?? 0);

          /// 计算
          DataUtil.calculate(list);
          detailState.kChartState.datas.assignAll(list);
        }
      } catch (e) {
        bobLog('永续合约 reqKline error ${e.toString()}');
      }
    });
    ContractSocketManager().subKline(contractInfo.subSymbol, subTime,
        (symbol, data) {
      /// 对应的订阅，非空的数据，且k线数据不为空，列表数据未回来避免只显示一条数据
      if (symbol != contractInfo.subSymbol || data.tick == null) return;
      try {
        KLineEntity kLineEntity = KLineEntity.fromJson(data.tick!);

        /// 无效数据过滤
        if (!kLineEntity.isValidData()) {
          return;
        }

        /// 第一次数据，先存储
        if (kLineData.isEmpty) {
          kLineData[kLineEntity.time ?? 0] = kLineEntity;
          return;
        }

        /// 计算主副图
        kLineData[kLineEntity.time ?? 0] = kLineEntity;
        List<KLineEntity> list = kLineData.values.toList();
        list.sort((a, b) => a.time?.compareTo(b.time ?? 0) ?? 0);
        DataUtil.calculate(list);
        detailState.kChartState.datas.assignAll(list);
      } catch (error) {
        Get.log('永续合约 reqKline error ${error.toString()}');
      }
    });
  }

  unSubKline(ContractInfo contractInfo, String subTime) {
    ContractSocketManager().unSubKline(contractInfo.subSymbol, subTime);
  }

  unSubContract(ContractInfo info) {
    ContractSocketManager().unSubDepth(info.subSymbol, 0);
    ContractSocketManager().unSubTradeTicker(info.subSymbol);
  }
}

///////////////////////////////////////////////////////////////
////////////////          交互相关API      //////////////////
///////////////////////////////////////////////////////////////
extension PriceControllerInterface on ContractPriceController {
  void onTabChanged(int value) {
    detailState.currentTabIndex.value = value;
  }

  void onSubTimeChanged(SubTime value) {
    if (contractInfo == null) return;
    hasMore = true;
    isLoadingMore = false;
    unSubKline(contractInfo!, detailState.kChartState.subTime.value.subTime);
    detailState.kChartState.subTime.value = value;
    subKline(contractInfo!, detailState.kChartState.subTime.value.subTime);
  }

  void onMainStateChanged(MainState value) {
    if (detailState.kChartState.mainState.value == value) {
      detailState.kChartState.mainState.value = MainState.NONE;
    } else {
      detailState.kChartState.mainState.value = value;
    }
  }

  void onSecondaryStateChanged(SecondaryState value) {
    if (detailState.kChartState.secondaryState.value == value) {
      detailState.kChartState.secondaryState.value = SecondaryState.NONE;
    } else {
      detailState.kChartState.secondaryState.value = value;
    }
  }

  /// 加载更多
  void onLoadMore() {
    if (contractInfo == null ||
        detailState.kChartState.datas.isEmpty ||
        isLoadingMore ||
        !hasMore) {
      return;
    }
    isLoadingMore = true;
    int endIdx = detailState.kChartState.datas.first.time! ~/ 1000;
    ContractSocketManager.instance.reqKline(
        contractInfo!.subSymbol, detailState.kChartState.subTime.value.subTime,
        (symbol, data) {
      if (symbol == contractInfo!.subSymbol && data.data != null) {
        isLoadingMore = false;
        List<KLineEntity> list = data.data
            .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<KLineEntity>();
        list.removeWhere((element) =>
            kLineData.containsKey(element.time ?? 0) || !element.isValidData());

        hasMore = list.isNotEmpty;
        if (list.isNotEmpty) {
          for (var element in list) {
            kLineData[element.time ?? 0] = element;
          }
          list = kLineData.values.toList();
          list.sort((a, b) => a.time?.compareTo(b.time ?? 0) ?? 0);

          /// 计算
          DataUtil.calculate(list);
          detailState.kChartState.datas.assignAll(list);
        }
      }
    }, endIdx: endIdx);
  }

  _handleData(String subSymbol, String symbol, WSReceiveData data) {
    if (ObjectUtil.isEmpty(data.tick) || subSymbol != symbol) {
      return;
    }
    DepthTick depthTick = DepthTick.fromJson(data.tick!);
    var asks = <DepthEntity>[];
    asks.addAll(depthTick.asks
            ?.map((e) => DepthEntity(
                e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
            .toList() ??
        []);
    asks.removeWhere((element) => element.vol.toDecimal() == Decimal.zero);
    asks = mergeDepthEntities(asks);
    asks.sort((a, b) => a.price.compareTo(b.price));

    var buys = <DepthEntity>[];
    buys.addAll(depthTick.buys
            ?.map((e) => DepthEntity(
                e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
            .toList() ??
        []);
    buys.removeWhere((element) => element.vol.toDecimal() == Decimal.zero);
    buys = mergeDepthEntities(buys);
    buys.sort((a, b) => b.price.compareTo(a.price));
    detailState.asks.assignAll(asks);
    detailState.buys.assignAll(buys);
  }
}
