import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/handing_fee_agent/invite_history_handling_fee_agent_view_controller.dart';
import 'package:nt_app_flutter/app/modules/my/invite/invite_history/widget/invite_filter_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../handling_fee/widgets/invite_history_handling_fee_wiget.dart';

class InviteHistoryHandlingFeeAgentViewView
    extends GetView<InviteHistoryHandlingFeeAgentViewController> {
  const InviteHistoryHandlingFeeAgentViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserGetx>(builder: (userGetx) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            InviteFilterWidget(
              onTimeFilterChanged: (timeOption) {
                controller.updateTimeFilter(timeOption);
              },
              onCategoryChanged: (category) {
                controller.updateCategoryFilter(category);
              },
            ),
            Container(
              height: 59.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              color: AppColor.colorF5F5F5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.user286.trArgs(["USDT"]),
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.color333333),
                  ),
                  Obx(() => Text("+${controller.totalBonus.value ?? "0.00"}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.colorSuccess)))
                ],
              ),
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
                              padding: EdgeInsets.all(8.w),
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
                              ),
                            ),
                            ...items.map((item) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child:
                                    InviteHistoryHandlingFeeWidget(item: item),
                              );
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
        ),
      );
    });
  }
}
