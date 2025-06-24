import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../api/spot_goods/spot_goods_api.dart';
import '../../../../../models/spot_goods/spot_trade_res.dart';
import '../../../../../widgets/components/spot_history/filter_trade_side_bottom_sheet.dart';

class SpotDealController extends GetListController<SpotTradeInfo> {
  // BUY 买入 SELL 卖出 空表示全部
  Rxn<SideType> side = Rxn();
  Rxn<MarketInfoModel> marketInfo = Rxn();

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  void onChangeSymbol(MarketInfoModel? symbol) {
    if (marketInfo.value == symbol) return;
    marketInfo.value = symbol;
    refreshData(false);
  }

  void onChangeSide(SideType? side) {
    if (this.side.value == side) return;
    this.side.value = side;
    refreshData(false);
  }

  @override
  Future<List<SpotTradeInfo>> fetchData() async {
    final res = await SpotGoodsApi.instance().tradeList(
        pageIndex, pageSize, side.value?.side, marketInfo.value?.symbol);
    return res.orderList;
  }
}
