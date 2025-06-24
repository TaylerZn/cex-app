import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../widgets/components/spot_history/filter_button.dart';
import '../../../../../widgets/components/spot_history/filter_order_type_bottom_sheet.dart';
import '../../../../../widgets/components/spot_history/filter_swap_coin_bottom_sheet.dart';
import '../../../../../widgets/components/spot_history/filter_trade_side_bottom_sheet.dart';
import '../../../../../widgets/components/spot_history/filter_trade_status_bottom_sheet.dart';
import '../controllers/spot_history_entrust_controller.dart';
import '../widgets/spot_history_entrust_widget.dart';

class SpotHistoryEntrustView extends GetView<SpotHistoryEntrustController> {
  const SpotHistoryEntrustView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 38.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Obx(() {
                  return FilterButton(
                    title: controller.marketInfo.value?.showName ?? LocaleKeys.trade178.tr,
                    onTap: () async {
                      final res =
                          await FilterSwapCoinBottomSheet.showCoinBottomSheet(
                              marketInfo: controller.marketInfo.value);
                      controller.onChangeSymbol(res);
                    },
                  );
                }),
                6.horizontalSpace,
                Obx(() {
                  return FilterButton(
                    title: controller.orderType.value?.type == null
                        ? LocaleKeys.trade122.tr
                        : (controller.orderType.value?.name ?? LocaleKeys.trade122.tr),
                    onTap: () async {
                      final orderType = await showOrderTypeBottomSheet(
                          orderType: controller.orderType.value);
                      controller.onTypeChange(orderType);
                    },
                  );
                }),
                6.horizontalSpace,
                Obx(() {
                  return FilterButton(
                      title: controller.side.value?.side == null
                          ? LocaleKeys.trade117.tr
                          : (controller.side.value?.name ?? LocaleKeys.trade117.tr),
                      onTap: () async {
                        final res = await showTradeSideBottomSheet(
                            side: controller.side.value);
                        controller.onChangeSide(res);
                      });
                }),
                6.horizontalSpace,
                FilterButton(
                  title: LocaleKeys.trade118.tr,
                  onTap: () async {
                    final res = await showTradeStatusBottomSheet(
                        status: controller.orderStatus.value);
                    if (res != null) {
                      controller.onChangeOrderStatus(res);
                    }
                  },
                ),
              ],
            ),
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
                    return SpotHistoryEntrustWidget(
                      orderInfo: state![index],
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
