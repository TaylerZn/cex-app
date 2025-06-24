// ignore_for_file: invalid_use_of_protected_member

import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:k_chart/utils/data_util.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/price_detail_view.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/ws/spot_goods_socket_manager.dart';

import '../../../../../models/contract/res/depth_info.dart';
import '../../../../../models/contract/res/history_trade_info.dart';
import '../../../../../ws/core/model/ws_receive_data.dart';
import '../../../mixin/price_controller_mixin.dart';
import '../../../widgets/price/widgets/kchart/model/sub_time.dart';

class SpotPriceController extends GetxController with PriceControllerMixin {
  static SpotPriceController get to => Get.find();

  RxPriceDetailState detailState = RxPriceDetailState();

  MarketInfoModel? _marketInfo;

  changeMarket(MarketInfoModel marketInfo) {
    if (_marketInfo != null) {
      unSubSpot(_marketInfo!);
      unSubKline(_marketInfo!, detailState.kChartState.subTime.value.subTime);
      detailState.kChartState.datas.clear();
      detailState.kChartState.bids.clear();
      detailState.kChartState.asks.clear();
      // detailState.priceTicker.value = null;
      detailState.asks.clear();
      detailState.buys.clear();
      detailState.historyTrade.clear();
    }
    _marketInfo = marketInfo;
    // detailState.amountPrecision.value = marketInfo.volume.toInt();
    // detailState.pricePrecision.value = marketInfo.price.toInt();
    // detailState.priceTicker.value = PriceTicker(
    //     esPrice: marketInfo.esPrice.toNum(),
    //     amount: marketInfo.amount.toNum(),
    //     close: marketInfo.close.toNum(),
    //     high: marketInfo.high.toNum(),
    //     low: marketInfo.low.toNum(),
    //     open: marketInfo.open.toNum(),
    //     rose: marketInfo.rose.toNum(),
    //     vol: marketInfo.vol.toNum());
    subSpot(marketInfo);
    subKline(marketInfo, detailState.kChartState.subTime.value.subTime);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }
}

///////////////////////////////////////////////////////////////
////////////////          合约ws      //////////////////
///////////////////////////////////////////////////////////////
extension SpotPriceControllerWS on SpotPriceController {
  subSpot(MarketInfoModel info) {
    /// 订阅24小时行情
    // SpotGoodsSocketManager().subTicker(info.symbol, (symbol, data) {
    //   if (data.tick == null || info.symbol != symbol) return;
    //   PriceTicker ticker = PriceTicker.fromJson(data.tick!);
    // detailState.priceTicker.update((val) {
    //   if (val == null) {
    //     val = ticker;
    //   } else {
    //     val.high = ticker.high;
    //     val.open = ticker.open;
    //     // val.close = ticker.close;
    //     val.low = ticker.low;
    //     val.rose = ticker.rose;
    //     val.vol = ticker.vol;
    //     val.esPrice = ticker.esPrice;
    //     val.amount = ticker.amount;
    //   }
    // });
    // });

    /// 订阅深度
    SpotGoodsSocketManager().subDepth(info.symbol, 0, (symbol, data) {
      if (ObjectUtil.isEmpty(data.tick) || info.symbol != symbol) {
        return;
      }
      _handleData(info.symbol, symbol, data);
    });

    /// 订阅历史成交
    SpotGoodsSocketManager().reqTradeTicker(info.symbol, (symbol, data) {
      if (info.symbol != symbol) return;
      if (data.data != null) {
        List<HistoryTradeInfo> historyTradeInfo =
            HistoryTradeInfo.fromJsonList(data.data!);

        /// 根据时间排序
        historyTradeInfo.sort((a, b) => b.ts.compareTo(a.ts));
        detailState.historyTrade.assignAll(historyTradeInfo);
      }
    });

    /// 订阅实时成交
    SpotGoodsSocketManager().subTradeTicker(info.symbol, (symbol, data) {
      if (info.symbol != symbol) return;
      if (data.tick != null) {
        HistoryTradeRes historyTradeRes = HistoryTradeRes.fromJson(data.tick!);
        List<HistoryTradeInfo> historyTradeInfo = historyTradeRes.data ?? [];

        /// 根据时间排序
        historyTradeInfo.sort((a, b) => b.ts.compareTo(a.ts));
        detailState.historyTrade
            .assignAll(historyTradeInfo + detailState.historyTrade);
      }
    });
  }

  subKline(MarketInfoModel marketInfo, String subTime) {
    detailState.kChartState.isLoading.value = true;
    detailState.kChartState.datas.clear();
    SpotGoodsSocketManager().reqKline(marketInfo.symbol, subTime,
        (symbol, data) {
      detailState.kChartState.isLoading.value = false;
      if (symbol == marketInfo.symbol && data.data != null) {
        detailState.kChartState.datas.value = data.data
            .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<KLineEntity>();
        if (detailState.kChartState.datas.isNotEmpty) {
          DataUtil.calculate(detailState.kChartState.datas);
        }
      }
    });
    SpotGoodsSocketManager().subKline(marketInfo.symbol, subTime,
        (symbol, data) {
      if (symbol == marketInfo.symbol && data.data != null) {
        detailState.kChartState.datas.value = data.data
            .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<KLineEntity>();
        if (detailState.kChartState.datas.isNotEmpty) {
          DataUtil.calculate(detailState.kChartState.datas.value);
        }
      }
    });
  }

  unSubKline(MarketInfoModel marketInfo, String subTime) {
    SpotGoodsSocketManager().unSubKline(marketInfo.symbol, subTime);
  }

  unSubSpot(MarketInfoModel info) {
    SpotGoodsSocketManager().unSubTicker(info.symbol);
    SpotGoodsSocketManager().unSubDepth(info.symbol, 0);
    SpotGoodsSocketManager().unSubTradeTicker(info.symbol);
  }
}

///////////////////////////////////////////////////////////////
////////////////          交互相关API      //////////////////
///////////////////////////////////////////////////////////////
extension SpotPriceControllerInterface on SpotPriceController {
  void onTabChanged(int value) {
    detailState.currentTabIndex.value = value;
  }

  void onSubTimeChanged(SubTime value) {
    if (_marketInfo == null) return;
    unSubKline(_marketInfo!, detailState.kChartState.subTime.value.subTime);
    detailState.kChartState.subTime.value = value;
    subKline(_marketInfo!, detailState.kChartState.subTime.value.subTime);
  }

  void onMainStateChanged(MainState value) {
    detailState.kChartState.mainState.value = value;
  }

  void onSecondaryStateChanged(SecondaryState value) {
    detailState.kChartState.secondaryState.value = value;
  }

  /// 加载更多
  void onLoadMore() {
    if (_marketInfo == null || detailState.kChartState.datas.isEmpty) {
      return;
    }
    int endIdx = detailState.kChartState.datas.first.time! ~/ 1000;
    SpotGoodsSocketManager.instance.reqKline(
      _marketInfo!.symbol,
      detailState.kChartState.subTime.value.subTime,
      (symbol, data) {
        if (symbol == _marketInfo!.symbol && data.data != null) {
          List<KLineEntity> tempDatas = data.data
              .map((item) => KLineEntity.fromJson(item as Map<String, dynamic>))
              .toList()
              .cast<KLineEntity>();
          if (tempDatas.isNotEmpty) {
            detailState.kChartState.datas.value.insertAll(0, tempDatas);
            detailState.kChartState.datas.value
                .sort((a, b) => a.time?.compareTo(b.time ?? 0) ?? 0);
            if (detailState.kChartState.datas.isNotEmpty) {
              DataUtil.calculate(detailState.kChartState.datas);
            }
            detailState.kChartState.datas.refresh();
          }
        }
      },
      endIdx: endIdx,
    );
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

    for (var element in asks) {
      element.vol = element.vol * (_marketInfo?.volume ?? 1);
    }

    var buys = <DepthEntity>[];
    buys.addAll(depthTick.buys
            ?.map((e) => DepthEntity(
                e.safeFirst?.toDouble() ?? 0, e.safeLast?.toDouble() ?? 0))
            .toList() ??
        []);
    buys.removeWhere((element) => element.vol.toDecimal() == Decimal.zero);
    buys = mergeDepthEntities(buys);
    buys.sort((a, b) => b.price.compareTo(a.price));
    for (var element in buys) {
      element.vol = element.vol * (_marketInfo?.volume ?? 1);
    }
    detailState.asks.assignAll(asks);
    detailState.buys.assignAll(buys);

    // 为了计算深度图
    List<DepthEntity> dAsks =
        asks.map((e) => DepthEntity(e.price, e.vol)).toList();
    List<DepthEntity> dBuys =
        buys.map((e) => DepthEntity(e.price, e.vol)).toList();

    for (int i = 1; i < dAsks.length; i++) {
      dAsks[i].vol = dAsks[i].vol + dAsks[i - 1].vol;
    }
    for (int i = 1; i < dBuys.length; i++) {
      dBuys[i].vol = dBuys[i].vol + dBuys[i - 1].vol;
    }
    detailState.kChartState.asks.assignAll(dAsks);
    detailState.kChartState.bids.assignAll(dBuys.reversed.toList());
  }
}
