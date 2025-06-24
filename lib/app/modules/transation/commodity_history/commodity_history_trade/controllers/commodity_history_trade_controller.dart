import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../widgets/components/commodity_history/filter_date_time_bottom_sheet.dart';
import '../../../entrust/model/transaction_historical_model.dart';

class CommodityHistoryTradeController
    extends GetListController<TransactionHistoricalTransModel> {
  Rxn<ContractInfo> contractInfo = Rxn<ContractInfo>();

  DateType dateType = DateType(LocaleKeys.trade40.tr, 1);

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  void changeDateType(DateType res) {
    if (dateType == res) {
      return;
    }
    dateType = res;
    refreshData(false);
  }

  void changeContractInfo(ContractInfo? res) {
    if (contractInfo.value == res) {
      return;
    }
    contractInfo.value = res;
    refreshData(false);
  }

  @override
  Future<List<TransactionHistoricalTransModel>> fetchData() async {
    final res = await CommodityApi.instance().hisTradeList(
      pageSize,
      pageIndex,
      contractInfo.value?.id,
      dateType.getStartTimeEndTime().safeFirst,
      dateType.getStartTimeEndTime().safeLast,
    );
    return res.orderList as List<TransactionHistoricalTransModel>;
  }
}
