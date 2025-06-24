import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/app/widgets/components/commodity_history/filter_transaction_type_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../widgets/components/commodity_history/filter_date_time_bottom_sheet.dart';
import '../../../entrust/model/transaction_flow_model.dart';

class CommodityHistoryTransactionController
    extends GetListController<TransactionFlowFundsModel> {
  Rxn<TransactionType> transactionType = Rxn<TransactionType>();

  DateType dateType = DateType(LocaleKeys.trade40.tr, 1);

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  void changeTransactionType(TransactionType? res) {
    if (transactionType.value == res) return;
    transactionType.value = res;
    refreshData(false);
  }

  void changeDateType(DateType res) {
    if (dateType == res) return;
    dateType = res;
    refreshData(false);
  }

  @override
  Future<List<TransactionFlowFundsModel>> fetchData() async {
    final res = await CommodityApi.instance().flowFundsList(
      pageSize,
      pageIndex,
      null,
      transactionType.value?.type,
      dateType.getStartTimeEndTime().safeFirst,
      dateType.getStartTimeEndTime().safeLast,
    );
    List<TransactionFlowFundsModel> list =
        res.orderList as List<TransactionFlowFundsModel>;
    return list;
  }
}
