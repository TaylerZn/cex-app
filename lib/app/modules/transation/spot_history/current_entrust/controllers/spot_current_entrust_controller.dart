import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/spot_goods/spot_goods_api.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/app/widgets/components/spot_history/filter_order_type_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/components/spot_history/filter_trade_side_bottom_sheet.dart';

import '../../../../../models/spot_goods/spot_order_res.dart';

class SpotCurrentEntrustController extends GetListController<SpotOrderInfo> {
  // 1限价 2是市价 空表示全部
  Rxn<OrderType> orderType = Rxn();

  // BUY 买入 SELL 卖出 空表示全部
  Rxn<SideType> side = Rxn();

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  void onTypeChange(OrderType? type) {
    if (orderType.value == type) return;
    orderType.value = type ?? OrderType('订单类型', null);
    refreshData(false);
  }

  void onChangeSide(SideType? side) {
    if (this.side.value == side) return;
    this.side.value = side ?? SideType('方向', '');
    refreshData(false);
  }

  @override
  Future<List<SpotOrderInfo>> fetchData() async {
    final res = await SpotGoodsApi.instance().orderListNew(
        orderType.value?.type, side.value?.side, pageIndex, pageSize, null);
    return res.orderList ?? [];
  }
}
