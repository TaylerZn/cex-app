import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../models/contract/res/public_info.dart';
import '../../../../../widgets/basic/list_view/get_list_controller.dart';
import '../../../../../widgets/components/commodity_history/filter_commodity_order_type_bottom_sheet.dart';

class CommodityOpenOrderController extends GetListController<OrderInfo> {
  Rxn<ContractInfo> contractInfo = Rxn<ContractInfo>();
  Rx<OrderType> orderType = OrderType(LocaleKeys.trade115.tr, null).obs;

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  Future<void> onCloseAll() async {
    try {
      await CommodityApi.instance().cancelAllOrder();
      UIUtil.showSuccess(LocaleKeys.trade55.tr);
    } catch (e) {
      UIUtil.showError(LocaleKeys.trade56.tr);
    }
  }

  void changeContractInfo(ContractInfo? res) {
    if (contractInfo.value == res) {
      return;
    }
    contractInfo.value = res;
    refreshData(false);
  }

  void changeOrderType(OrderType res) {
    if (orderType.value == res) {
      return;
    }
    orderType.value = res;
    refreshData(false);
  }

  @override
  Future<List<OrderInfo>> fetchData() async {
    if (orderType.value.type == null) {
      final res = await CommodityApi.instance().findCoOrder(
          pageIndex, pageSize, contractInfo.value?.id, '[0,1,3,5]');
      final res1 = await CommodityApi.instance().findTriggerOrder(
          pageIndex++, pageSize, contractInfo.value?.id, '[0,1,3,5]');
      return res.data + res1.data;
    }

    OrderRes res;
    if (orderType.value.type == 1) {
      res = await CommodityApi.instance().findCoOrder(
          pageIndex++, pageSize, contractInfo.value?.id, '[0,1,3,5]');
    } else {
      res = await CommodityApi.instance().findTriggerOrder(
          pageIndex++, pageSize, contractInfo.value?.id, '[0,1,3,5]');
    }
    return res.data;
  }
}
