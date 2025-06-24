import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/spot_history/filter_order_type_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/components/spot_history/filter_trade_side_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/no/loading_widget.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../widgets/components/spot_history/filter_button.dart';
import '../../../../../widgets/no/network_error_widget.dart';
import '../controllers/spot_current_entrust_controller.dart';
import '../widgets/spot_current_entrust_wiget.dart';

class SpotCurrentEntrustView extends GetView<SpotCurrentEntrustController> {
  const SpotCurrentEntrustView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 38.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemBuilder: (context, index) {
                    return SpotCurrentEntrustItem(
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
