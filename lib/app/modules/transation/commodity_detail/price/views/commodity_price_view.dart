import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_chart/chart_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/widgets/commodity_k_chart_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/coin_24h_info_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/trade_date_change_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../../widgets/components/transaction/depth_chart.dart';
import '../../../widgets/price/widgets/entrust_list_view.dart';
import '../../../widgets/price/widgets/last_transation_list_view.dart';
import '../../../widgets/price/widgets/my_tab_bar.dart';
import '../../../widgets/trade_notify_widget.dart';
import '../controllers/commodity_price_controller.dart';

class CommodityPriceView extends GetView<CommodityPriceController> {
  const CommodityPriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TradeNotifyWidget(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(() {
            return GetBuilder<CommodityDataStoreController>(
              id: controller.contractInfo.value?.subSymbol ?? '',
              builder: (logic) {
                return Coin24HInfoWidget(
                  contractInfo: controller.contractInfo.value,
                ).marginSymmetric(horizontal: 16.w, vertical: 10.h);
              },
            );
          }),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          sliver: const SliverToBoxAdapter(
            child: CommodityKChartWidget(true),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(() {
            return TradeDateChangeWidget(
              contractInfo: controller.contractInfo.value,
              key: ValueKey(controller.contractInfo.value?.subSymbol),
            );
          }),
        ),
        SliverPinnedHeader(
          child: Obx(() {
            return MyTabBar(
              onValueChanged: (value) =>
                  controller.currentTabIndex.value = value,
              currentIndex: controller.currentTabIndex.value,
            );
          }),
        ),
        SliverToBoxAdapter(
          child: Obx(() {
            return [
                TradeListView(
                  asks: controller.asks.value,
                  buys: controller.buys.value,
                  amountPrecision: controller.contractInfo.value?.multiplier
                          .numDecimalPlaces() ??
                      2,
                  pricePrecision: controller.contractInfo.value?.coinResultVo
                          ?.symbolPricePrecision
                          .toInt() ??
                      2,
                ),
                DepthChart(
                  controller.depthBuys.value,
                  controller.depthAsks.value,
                  ChartColors(),
                  height: 250.h,
                ),
                TradeHistoryListView(
                  historyTradeInfo: controller.historyTradeList.value,
                  amountPrecision: controller.contractInfo.value?.multiplier
                          .numDecimalPlaces() ??
                      2,
                  pricePrecision: controller.contractInfo.value?.coinResultVo
                          ?.symbolPricePrecision
                          .toInt() ??
                      2,
                  baseSymbol: controller.contractInfo.value?.firstName ?? '--',
                  quoteSymbol: controller.contractInfo.value?.quote ?? '--',
                ),
              ][controller.currentTabIndex.value];
          }),
        ),
      ],
    );
  }
}
