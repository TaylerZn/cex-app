import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/commodity_history/filter_date_time_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../widgets/components/commodity_history/filter_commodity_coin_bottom_sheet.dart';
import '../../../../../widgets/components/commodity_history/filter_date_time_bottom_sheet.dart';
import '../../../../../widgets/components/spot_history/filter_button.dart';
import '../controllers/commodity_history_trade_controller.dart';
import '../widgets/commodity_history_trade_item.dart';

class CommodityHistoryTradeView
    extends GetView<CommodityHistoryTradeController> {
  const CommodityHistoryTradeView({Key? key}) : super(key: key);

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
                    title: controller.contractInfo.value == null
                        ? LocaleKeys.trade4.tr
                        : (controller.contractInfo.value?.symbol ??
                        LocaleKeys.trade4.tr),
                    onTap: () async {
                      final res = await FilterCommodityCoinBottomSheet.showCoinBottomSheet(
                          contractInfo: controller.contractInfo.value);
                      controller.changeContractInfo(res);
                    },
                  );
                }),
                const Spacer(),
                FilterDateTimeButton(onTap: () async {
                  final res = await FilterDateTimeBottomSheet.show(dateType: controller.dateType);
                  if(res != null) {
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
                      return CommodityHistoryTradeItem(
                        item: state![index],
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
