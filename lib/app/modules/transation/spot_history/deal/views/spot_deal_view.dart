import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_history/deal/widgets/spot_deal_item.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/spot_history/filter_swap_coin_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../widgets/components/spot_history/filter_button.dart';
import '../../../../../widgets/components/spot_history/filter_trade_side_bottom_sheet.dart';
import '../controllers/spot_deal_controller.dart';

class SpotDealView extends GetView<SpotDealController> {
  const SpotDealView({super.key});

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
                  title: controller.marketInfo.value?.showName ??
                      LocaleKeys.trade178.tr,
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
                    title: controller.side.value?.side == null
                        ? LocaleKeys.trade117.tr
                        : (controller.side.value?.name ??
                            LocaleKeys.trade117.tr),
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
                  itemBuilder: (context, index) {
                    return SpotDealItem(item: state![index]);
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
