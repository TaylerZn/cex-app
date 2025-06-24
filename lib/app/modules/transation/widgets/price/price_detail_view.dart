import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_chart/chart_style.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/coin_24h_info_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/entrust_list_view.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/kchart/kchart_detail_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/kchart/model/sub_time.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/last_transation_list_view.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/trade_date_change_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../models/contract/res/history_trade_info.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../widgets/components/transaction/depth_chart.dart';
import '../trade_notify_widget.dart';
import 'widgets/my_tab_bar.dart';

class RxPriceDetailState {
  Rxn<ContractInfo> contractInfo = Rxn();
  RxInt currentTabIndex = 0.obs;

  /// 委托关单
  RxList<DepthEntity> buys = RxList<DepthEntity>();
  RxList<DepthEntity> asks = RxList<DepthEntity>();

  /// 历史成交
  RxList<HistoryTradeInfo> historyTrade = RxList<HistoryTradeInfo>();

  /// K线图
  RxKChartState kChartState = RxKChartState();
}

class PriceDetailView extends StatelessWidget {
  const PriceDetailView({
    super.key,
    required this.detailState,
    required this.onTabChanged,
    required this.onSubTimeChanged,
    required this.onMainStateChanged,
    required this.onSecondaryStateChanged,
    required this.onLoadMore,
  });

  final RxPriceDetailState detailState;
  final ValueChanged<int> onTabChanged;

  final ValueChanged<SubTime> onSubTimeChanged;
  final ValueChanged<MainState> onMainStateChanged;
  final ValueChanged<SecondaryState> onSecondaryStateChanged;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TradeNotifyWidget(
            margin: EdgeInsets.symmetric(horizontal: 16.w,).copyWith(top: 8.h),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(() {
            return Coin24HInfoWidget(
              contractInfo: detailState.contractInfo.value,
              isShowMarkPrice: true,
            ).marginOnly(left: 16.w, right: 16.w, bottom: 10.h,top: 8.h);
          }),
        ),
        SliverToBoxAdapter(
          child: KChartDetailWidget(
            state: detailState.kChartState,
            onSubTimeChanged: onSubTimeChanged,
            onMainStateChanged: onMainStateChanged,
            onSecondaryStateChanged: onSecondaryStateChanged,
            onLoadMore: onLoadMore,
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(() {
            return TradeDateChangeWidget(
              contractInfo: detailState.contractInfo.value,
            );
          }),
        ),
        SliverPinnedHeader(
          child: Obx(() {
            return MyTabBar(
              onValueChanged: onTabChanged,
              currentIndex: detailState.currentTabIndex.value,
            );
          }),
        ),
        SliverToBoxAdapter(
          child: Obx(() {
            return [
                TradeListView(
                  asks: detailState.asks.value,
                  buys: detailState.buys.value,
                  amountPrecision: detailState.contractInfo.value?.multiplier
                          .numDecimalPlaces() ??
                      2,
                  pricePrecision: detailState.contractInfo.value?.coinResultVo
                          ?.symbolPricePrecision
                          .toInt() ??
                      2,
                ),
                DepthChart(
                  detailState.kChartState.bids.value,
                  detailState.kChartState.asks.value,
                  ChartColors(),
                  height: 250.h,
                ),
                TradeHistoryListView(
                  historyTradeInfo: detailState.historyTrade.value,
                  amountPrecision: detailState.contractInfo.value?.multiplier
                          .numDecimalPlaces() ??
                      2,
                  pricePrecision: detailState.contractInfo.value?.coinResultVo
                          ?.symbolPricePrecision
                          .toInt() ??
                      2,
                  baseSymbol: detailState.contractInfo.value?.base ?? '--',
                  quoteSymbol: detailState.contractInfo.value?.quote ?? '--',
                ),
              ][detailState.currentTabIndex.value];

          }),
        ),
      ],
    );
  }
}
