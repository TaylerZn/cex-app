import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/model/invite_time_option_type.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/widget/invite_time_selector.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/app/widgets/components/spot_history/filter_trade_status_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../api/spot_goods/spot_goods_api.dart';
import '../../../../../../models/spot_goods/spot_order_res.dart';
import '../../../../../../widgets/components/spot_history/filter_order_type_bottom_sheet.dart';
import '../../../../../../widgets/components/spot_history/filter_trade_side_bottom_sheet.dart';
import 'package:intl/intl.dart';

class InviteHistoryHandlingFeeController
    extends GetListController<AgentBonusRecordItem> {
  Rx<InviteFilterModel> filterModel =
      InviteFilterModel(timeOption: InviteTimeFilterType.thisWeek).obs;

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  Future<List<AgentBonusRecordItem>> fetchData() async {
    try {
      AgentBonusRecordListModel? res =
          await UserApi.instance().agentNewBonusRecord(
        pageSize,
        pageIndex,
        filterModel.value.startTime?.toString() ?? '',
        filterModel.value.endTime?.toString() ?? '',
        '0',
      );

      if (res != null && res.list != null && res.list!.isNotEmpty) {
        return res.list!;
      } else {
        return [];
      }
    } catch (e) {
      print('Fetch data error: $e');
      throw e;
    }
  }

  // 更新筛选条件
  void setFilterModel(InviteFilterModel model) {
    filterModel.value = model;
    refreshData(false);
  }

  // 分组数据
  Map<String, List<AgentBonusRecordItem>> groupDataByDate() {
    Map<String, List<AgentBonusRecordItem>> groupedData = {};
    for (var item in dataList) {
      String date = (item.itemDate != null)
          ? MyTimeUtil.timestampToMDShortStr(item.itemDate!, toUtc: true)
          : "null/null";
      if (groupedData[date] == null) {
        groupedData[date] = [];
      }
      groupedData[date]!.add(item);
    }

    return groupedData;
  }

  String getMonth(String date) {
    List<String> dateParts = date.split('/');
    return dateParts[0];
  }

  String getDay(String date) {
    List<String> dateParts = date.split('/');
    return dateParts[1];
  }
}
