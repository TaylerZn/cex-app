import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/model/invite_time_filter_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/number_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:intl/intl.dart';

class InviteHistoryHandlingFeeAgentViewController
    extends GetListController<AgentBonusRecordItem> {
  var selectedTimeOption = InviteTimeFilterType.thisWeek.obs;
  var selectedCategory = ''.obs;
  RxnString totalBonus = RxnString(null);

  @override
  void onReady() {
    super.onReady();
    refreshData(false);
  }

  @override
  Future<List<AgentBonusRecordItem>> fetchData() async {
    try {
      // 根据selectedTimeOption来设置startTime和endTime
      String startTime = selectedTimeOption.value.getStartTime();
      String endTime = selectedTimeOption.value.getEndTime();

      AgentBonusRecordListModel? res =
          await UserApi.instance().agentNewBonusRecord(
        pageSize,
        pageIndex,
        startTime,
        endTime,
        selectedCategory.value,
      );
      if (res != null && res.list != null) {
        // totalBonus.value = res.totalAmount!;
        totalBonus.value = NumberUtil.mConvert(res.totalAmount!,
            count: 6, isTruncate: true); //收益不能四舍五入 应显示小数点后6位
        return res.list!;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  void updateTimeFilter(InviteTimeFilterType newTimeOption) {
    selectedTimeOption.value = newTimeOption;
    refreshData(false);
  }

  void updateCategoryFilter(String newCategory) {
    selectedCategory.value = newCategory;
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
