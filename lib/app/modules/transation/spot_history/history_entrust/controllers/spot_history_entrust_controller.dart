import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/widgets/components/spot_history/filter_trade_status_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../api/spot_goods/spot_goods_api.dart';
import '../../../../../models/spot_goods/spot_order_res.dart';
import '../../../../../widgets/basic/list_view/get_list_controller.dart';
import '../../../../../widgets/components/spot_history/filter_order_type_bottom_sheet.dart';
import '../../../../../widgets/components/spot_history/filter_trade_side_bottom_sheet.dart';

class SpotHistoryEntrustController extends GetListController<SpotOrderInfo> {
  // 1限价 2是市价 空表示全部
  Rxn<OrderType> orderType = Rxn();

  // BUY 买入 SELL 卖出 空表示全部
  Rxn<SideType> side = Rxn();

  // 状态：
  // 2-完全成交
  // 4-已撤单
  // 6-异常订单
  RxList<Status> orderStatus = RxList([
    Status(LocaleKeys.trade141.tr, 2),
  ]);
  Rxn<MarketInfoModel> marketInfo = Rxn();

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  void onTypeChange(OrderType? type) {
    if (orderType.value == type) return;
    orderType.value = type;
    refreshData(false);
  }

  void onChangeSide(SideType? side) {
    if (this.side.value == side) return;
    this.side.value = side;
    refreshData(false);
  }

  void onChangeOrderStatus(List<Status> statusList) {
    orderStatus.value = statusList;
    refreshData(false);
  }

  void onChangeSymbol(MarketInfoModel? symbol) {
    if (marketInfo.value == symbol) return;
    marketInfo.value = symbol;
    refreshData(false);
  }

  String getStatus() {
    return orderStatus.map((e) => e.status).join(',');
  }

  @override
  Future<List<SpotOrderInfo>> fetchData() async {
    final res = await SpotGoodsApi.instance().entrustHistory(
        pageIndex,
        pageSize,
        0,
        orderType.value?.type,
        side.value?.side,
        getStatus(),
        marketInfo.value?.symbol);
    return res.orderList ?? [];
  }
}
