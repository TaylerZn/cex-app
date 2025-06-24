// ignore_for_file: invalid_use_of_protected_member

import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:nt_app_flutter/app/models/contract/res/depth_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/history_trade_info.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commdity_kchar_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/mixin/price_controller_mixin.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/ws/core/model/ws_receive_data.dart';
import 'package:nt_app_flutter/app/ws/standard_socket_manager.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../models/contract/res/public_info.dart';

class CommodityPriceController extends GetxController
    with PriceControllerMixin {
  final currentTabIndex = 0.obs;

  static CommodityPriceController get to => Get.find();

  /// 委托关单
  RxList<DepthEntity> buys = RxList<DepthEntity>();
  RxList<DepthEntity> asks = RxList<DepthEntity>();

  /// 深度
  RxList<DepthEntity> depthBuys = RxList();
  RxList<DepthEntity> depthAsks = RxList();

  /// 历史成交
  RxList<HistoryTradeInfo> historyTradeList = RxList<HistoryTradeInfo>();

  Rxn<ContractInfo> contractInfo = Rxn(null);

  changeContractInfo(ContractInfo contractInfo) {
    CommodityKChartController.to.changeContractInfo(contractInfo);
    this.contractInfo.value = contractInfo;
    unSubContract(contractInfo);
    subContract(contractInfo);
  }

  @override
  void onClose() {
    unSubContract(contractInfo.value!);
    super.onClose();
  }
}

/// commodity price controller extension
extension CommodityPriceControllerX on CommodityPriceController {
  subContract(ContractInfo info) {
    /// 订阅盘口数据
    StandardSocketManager.instance.subDepth(info.subSymbol, 0, (symbol, data) {
      if (ObjectUtil.isEmpty(data.tick) ||
          contractInfo.value?.subSymbol != symbol) {
        return;
      }
      _handleData(info.subSymbol, symbol, data);
    });

    /// 订阅历史成交
    StandardSocketManager().reqTradeTicker(info.subSymbol, (symbol, data) {
      if (contractInfo.value?.subSymbol != symbol || data.data == null) return;
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
        historyTradeList.assignAll(historyTradeInfo);
      } catch (error) {
        Get.log(error.toString());
      }
    });

    /// 实时成交
    StandardSocketManager().subTradeTicker(info.subSymbol, (symbol, data) {
      if (contractInfo.value?.subSymbol != symbol || data.tick == null) return;
      try {
        HistoryTradeInfo lastTrade = HistoryTradeInfo.fromJson(data.tick!);
        HistoryTradeInfo firstTrade = historyTradeList.first;
        if (lastTrade.price.toDecimal() >= firstTrade.price.toDecimal()) {
          lastTrade.priceColor = AppColor.upColor;
        } else {
          lastTrade.priceColor = AppColor.downColor;
        }
        historyTradeList.insert(0, lastTrade);
      } catch (e) {}
    });

    /// 订阅深度
    reqDepthTrade(info);
    subDepthTrade(info);
  }

  unSubContract(ContractInfo info) {
    StandardSocketManager().unSubDepth(info.subSymbol, 0);
    StandardSocketManager().unSubTradeTicker(info.subSymbol);
    StandardSocketManager.instance.unSubDepthTrade(info.subSymbol);
  }

  _handleData(String subSymbol, String symbol, WSReceiveData data) {
    if (ObjectUtil.isEmpty(data.tick) ||
        subSymbol != symbol ||
        contractInfo.value?.subSymbol != subSymbol) {
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
    asks.sort((a, b) => a.price.compareTo(a.price));

    var buys = <DepthEntity>[];
    buys.addAll(depthTick.buys
            ?.map((e) => DepthEntity(
                e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
            .toList() ??
        []);
    buys.removeWhere((element) => element.vol.toDecimal() == Decimal.zero);
    buys = mergeDepthEntities(buys);
    buys.sort((a, b) => b.price.compareTo(a.price));
    this.asks.assignAll(asks);
    this.buys.assignAll(buys);
  }

  /// 订阅深度
  reqDepthTrade(ContractInfo info) {
    StandardSocketManager.instance.reqDepthHistory(info.subSymbol,
        (symbol, data) {
      if (ObjectUtil.isEmpty(data.tick) ||
          contractInfo.value?.subSymbol != symbol) {
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
      asks.sort((a, b) => a.price.compareTo(a.price));

      var buys = <DepthEntity>[];
      buys.addAll(depthTick.buys
              ?.map((e) => DepthEntity(
                  e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
              .toList() ??
          []);
      buys.removeWhere((element) => element.vol.toDecimal() == Decimal.zero);
      buys = mergeDepthEntities(buys);
      buys.sort((a, b) => a.price.compareTo(b.price));
      depthAsks.assignAll(asks);
      depthBuys.assignAll(buys);
    });
  }

  /// 订阅实时深度
  subDepthTrade(ContractInfo info) {
    StandardSocketManager.instance.subDepthTrade(info.subSymbol,
        (symbol, data) {
      if (ObjectUtil.isEmpty(data.tick) ||
          contractInfo.value?.subSymbol != symbol) {
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
      asks.sort((a, b) => a.price.compareTo(a.price));

      var buys = <DepthEntity>[];
      buys.addAll(depthTick.buys
              ?.map((e) => DepthEntity(
                  e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
              .toList() ??
          []);
      buys.removeWhere((element) => element.vol.toDecimal() == Decimal.zero);
      buys = mergeDepthEntities(buys);
      buys.sort((a, b) => a.price.compareTo(b.price));
      depthAsks.assignAll(asks);
      depthBuys.assignAll(buys);
    });
  }
}
