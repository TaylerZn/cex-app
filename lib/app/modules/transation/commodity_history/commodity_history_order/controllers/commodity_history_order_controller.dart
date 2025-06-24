import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/app/widgets/components/commodity_history/filter_commodity_order_type_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/components/commodity_history/filter_date_time_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../models/contract/res/order_info.dart';
import '../../../../../models/contract/res/public_info.dart';
import '../../../../../widgets/components/spot_history/filter_trade_side_bottom_sheet.dart';
import '../../../../../widgets/components/spot_history/filter_trade_status_bottom_sheet.dart';

class CommodityHistoryOrderController extends GetListController<OrderInfo> {
  Rxn<ContractInfo> contractInfo = Rxn<ContractInfo>();
  DateType dateType = DateType(LocaleKeys.trade40.tr, 1);
  Rx<OrderType> orderType = OrderType(LocaleKeys.trade115.tr, null).obs;

  // BUY 买入 SELL 卖出 空表示全部
  Rxn<SideType> side = Rxn();

  // 状态：
  // 2-完全成交
  // 4-已撤单
  // 6-异常订单
  RxList<Status> orderStatus = RxList([
    Status(LocaleKeys.trade141.tr, 2),
    Status(LocaleKeys.trade142.tr, 4),
    Status(LocaleKeys.trade143.tr, 6),
  ]);

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  String getStatus() {
    return orderStatus.map((e) => e.status).toSet().toList().toString();
  }

  void changeContractInfo(ContractInfo? res) {
    if (contractInfo.value == res) {
      return;
    }
    contractInfo.value = res;
    refreshData(false);
  }

  void changeDateType(DateType res) {
    if (dateType == res) {
      return;
    }
    dateType = res;
    refreshData(false);
  }

  void changeOrderType(OrderType res) {
    if (orderType.value == res) {
      return;
    }
    orderType.value = res;
    if(res.type == 2) {
      orderStatus.value = [
        Status(LocaleKeys.trade124.tr, 1), // 已过期
        Status(LocaleKeys.trade141.tr, 2), // 已完成
        Status(LocaleKeys.assets112.tr, 3), // 失败
        Status(LocaleKeys.trade125.tr, 4), // 已取消
      ];
    } else {
      orderStatus.value = [
        Status(LocaleKeys.trade141.tr, 2), // 已完成
        Status(LocaleKeys.trade125.tr, 4), // 已取消
        Status(LocaleKeys.trade124.tr, 6), // 过期
      ];
    }
    refreshData(false);
  }

  void changeSide(SideType? res) {
    if (side.value == res) {
      return;
    }
    side.value = res;
    refreshData(false);
  }

  void changeOrderStatus(List<Status> res) {
    orderStatus.value = res;
    refreshData(false);
  }

  @override
  Future<List<OrderInfo>> fetchData() async {
    OrderRes res;

    /// 查询全部
    if (orderType.value.type == null) {
      final res = await CommodityApi.instance().findCoOrder(
        pageIndex,
        pageSize,
        contractInfo.value?.id,
        getStatus(),
        dateType.getStartTimeEndTime().first ~/ 1000,
        dateType.getStartTimeEndTime().last ~/ 1000,
      );
     return res.data;
    }

    /// 1 市价单 2 止盈止损单 3 强平价格单
    if (orderType.value.type == 1 || orderType.value.type == 3) {
      res = await CommodityApi.instance().findCoOrder(
        pageIndex++,
        pageSize,
        contractInfo.value?.id,
        getStatus(),
        //'[2,4,6]',
        dateType.getStartTimeEndTime().first ~/ 1000,
        dateType.getStartTimeEndTime().last ~/ 1000,
        orderType.value.type == 1 ? 2 : 6, // 市价2 强平价格 6
      );
    } else {
      res = await CommodityApi.instance().findTriggerOrder(
        pageIndex++,
        pageSize,
        contractInfo.value?.id,
        getStatus(), //'[2,4,6]',
        dateType.getStartTimeEndTime().first ~/ 1000,
        dateType.getStartTimeEndTime().last ~/ 1000,
      );
    }
    return res.data;
  }
}
