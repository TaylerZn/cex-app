import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/models/otc/b2c/order_history_res.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';

class B2cOrderHistoryController
    extends GetListController<B2cOrderHistoryListModel> {
  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  @override
  Future<List<B2cOrderHistoryListModel>> fetchData() async {
    B2COrderTransctionListModel? res =
        await OtcApi.instance().b2cOrderTransctionList(
      null,
      pageSize,
      pageIndex,
    );
    print(res);
    if (res != null && res.dataList != null && res.dataList!.isNotEmpty) {
      return res.dataList as List<B2cOrderHistoryListModel>;
    }
    return [];
  }
}
