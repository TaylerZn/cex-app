import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/handling_fee/controllers/invite_history_handling_fee_controller.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/handling_fee/widgets/invite_history_handling_fee_wiget.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/widget/invite_time_selector.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/app/widgets/no/network_error_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InviteHistoryHandlingFeeView
    extends GetView<InviteHistoryHandlingFeeController> {
  const InviteHistoryHandlingFeeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InviteTimeSelector(
          filterModel: controller.filterModel.value,
          onFilterChanged: (model) {
            controller.setFilterModel(model);
          },
        ),
        Expanded(

          child: controller.pageObx(
            (data) {
              var groupedData = controller.groupDataByDate();
              var dates = groupedData.keys.toList();
              return SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  await controller.refreshData(true);
                },
                onLoading: () async {
                  await controller.loadMoreData();
                },
                child: ListView.builder(
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    String date = dates[index];
                    List<AgentBonusRecordItem> items = groupedData[date]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: controller.getMonth(date),
                                    style: TextStyle(
                                      color: AppColor.color111111,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '/' + controller.getDay(date),
                                    style: TextStyle(
                                      color: AppColor.color999999,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        ...items.map((item) {
                          return InviteHistoryHandlingFeeWidget(item: item);
                        }).toList(),
                      ],
                    );
                  },
                ),
              );
            },
            onRetryRefresh: () => controller.refreshData(false),
          ),
        ),
      ],
    );
  }
}
