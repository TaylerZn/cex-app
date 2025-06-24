import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/commodity_history/filter_date_time_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../widgets/components/commodity_history/filter_commodity_coin_bottom_sheet.dart';
import '../../../../../widgets/components/commodity_history/filter_commodity_order_type_bottom_sheet.dart';
import '../../../../../widgets/components/commodity_history/filter_date_time_button.dart';
import '../../../../../widgets/components/spot_history/filter_button.dart';
import '../../../../../widgets/components/spot_history/filter_trade_status_bottom_sheet.dart';
import '../controllers/commodity_history_order_controller.dart';
import '../widgets/commodity_history_order_item.dart';

class CommodityHistoryOrderView
    extends GetView<CommodityHistoryOrderController> {
  const CommodityHistoryOrderView({super.key});

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
                      final res = await FilterCommodityCoinBottomSheet
                          .showCoinBottomSheet(
                              contractInfo: controller.contractInfo.value);
                      controller.changeContractInfo(res);
                    },
                  );
                }),
                6.horizontalSpace,
                Obx(() {
                  return FilterButton(
                      title: controller.orderType.value.name,
                      onTap: () async {
                        final res = await showCommodityOrderTypeBottomSheet(
                            orderType: controller.orderType.value);
                        if (res != null) {
                          controller.changeOrderType(res);
                        }
                      });
                }),
                6.horizontalSpace,
                FilterButton(
                    title: LocaleKeys.trade43.tr,
                    onTap: () async {
                      final res = await showTradeStatusBottomSheet(
                          // ignore: invalid_use_of_protected_member
                          statusList: controller.orderType.value.type == 2
                              ? [
                                  Status(LocaleKeys.trade124.tr, 1), // 已过期
                                  Status(LocaleKeys.trade141.tr, 2), // 已完成
                                  Status(LocaleKeys.assets112.tr, 3), // 失败
                                  Status(LocaleKeys.trade125.tr, 4), // 已取消
                                ]
                              : [
                                  Status(LocaleKeys.trade141.tr, 2), // 已完成
                                  Status(LocaleKeys.trade125.tr, 4), // 已取消
                                  Status(LocaleKeys.trade124.tr, 6), // 过期
                                ],
                          status: controller.orderStatus.value);
                      if (res != null) {
                        controller.changeOrderStatus(res);
                      }
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
                      return CommodityHistoryOrderItem(
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
