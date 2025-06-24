import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/commodity_history/filter_date_time_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../widgets/components/commodity_history/filter_date_time_button.dart';
import '../../../../../widgets/components/commodity_history/filter_transaction_type_bottom_sheet.dart';
import '../../../../../widgets/components/spot_history/filter_button.dart';
import '../controllers/commodity_history_transaction_controller.dart';
import '../widgets/commodity_history_transaction_item.dart';

class CommodityHistoryTransactionView
    extends GetView<CommodityHistoryTransactionController> {
  const CommodityHistoryTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 38.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Obx(() {
                  return FilterButton(
                    title: controller.transactionType.value?.type == null
                        ? LocaleKeys.trade53.tr
                        : controller.transactionType.value!.name,
                    onTap: () async {
                      final res = await showCommodityTransactionTypeBottomSheet(
                          transactionType: controller.transactionType.value);
                      controller.changeTransactionType(res);
                    },
                  );
                }),
                const Spacer(),
                FilterDateTimeButton(onTap: () async {
                  final res = await FilterDateTimeBottomSheet.show(
                      dateType: controller.dateType);
                  if (res != null) {
                    controller.changeDateType(res);
                  }
                }),
              ],
            ),
          ),
          Expanded(
            child: controller.pageObx(
              (state) {
                return SmartRefresher(
                  controller: controller.refreshController,
                  onRefresh: () => controller.refreshData(true),
                  onLoading: controller.loadMoreData,
                  enablePullUp: true,
                  enablePullDown: true,
                  child: ListView.builder(
                    itemCount: state?.length ?? 0,
                    itemBuilder: (context, index) {
                      return CommodityHistoryTransactionItem(
                        model: state![index],
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
  }
}
