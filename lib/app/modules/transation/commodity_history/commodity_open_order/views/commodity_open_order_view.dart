import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../utils/utilities/ui_util.dart';
import '../../../../../widgets/components/commodity_history/filter_commodity_coin_bottom_sheet.dart';
import '../../../../../widgets/components/commodity_history/filter_commodity_order_type_bottom_sheet.dart';
import '../../../../../widgets/components/spot_history/filter_button.dart';
import '../../../commodiy_entrust/controllers/commondiy_entrust_controller.dart';
import '../../../contract_entrust/widgets/current_entrust_item.dart';
import '../controllers/commodity_open_order_controller.dart';

class CommodityOpenOrderView extends GetView<CommodityOpenOrderController> {
  const CommodityOpenOrderView({super.key});

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
                const Spacer(),
                MyButton(
                  text: LocaleKeys.trade57.tr,
                  onTap: controller.onCloseAll,
                  height: 24.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  color: AppColor.colorTextPrimary,
                  textStyle: AppTextStyle.f_12_600.colorTextPrimary,
                  border:
                      Border.all(color: AppColor.colorBorderStrong, width: 1),
                  backgroundColor: AppColor.colorAlwaysWhite,
                ),
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
                      OrderInfo orderInfo = state![index];
                      return CurrentEntrustItem(
                        orderInfo: orderInfo,
                        isCommodity: true,
                        onTap: () async {
                          try {
                            CommodityEntrustController.to.onCancelOrder(orderInfo);
                            CommodityEntrustController.to.fetchData();
                            UIUtil.showSuccess(LocaleKeys.trade58.tr);
                          } catch (e) {
                            UIUtil.showToast(LocaleKeys.trade59.tr);
                          }
                        },
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
