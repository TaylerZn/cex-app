import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_funds_info/history/controllers/info_history_controller.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_state_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssetsFundsInfoHistoryView
    extends GetView<AssetsFundsInfoHistoryController> {
  String source;
  String? coinSymbol;

  AssetsFundsInfoHistoryView({required this.source, this.coinSymbol});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsFundsInfoHistoryController>(
        tag: source,
        init: AssetsFundsInfoHistoryController(
            source: source, coinSymbol: coinSymbol),
        builder: (controller) {
          return controller.pageObx(
            (state) {
              return SmartRefresher(
                controller: controller.refreshController,
                onRefresh: () => controller.refreshData(true),
                onLoading: controller.loadMoreData,
                enablePullUp: true,
                enablePullDown: true,
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: state != null ? state.length + 1 : 0,
                  itemBuilder: (BuildContext c, int i) {
                    if (state?.length == i) {
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 16.w),
                          child: Text(LocaleKeys.assets74.tr,
                              style: AppTextStyle.f_11_400.colorBBBBBB));
                    } else {
                      var e = state![i];
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 16.w),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: AppColor.colorEEEEEE))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    e.name,
                                    style: AppTextStyle.f_14_600.color111111,
                                  ),
                                ),
                                8.horizontalSpace,
                                Text(
                                  (double.parse(e.value) > 0 ? '+' : '') +
                                      e.value,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: double.parse(e.value) > 0
                                          ? AppColor.upColor
                                          : AppColor.downColor,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              e.time,
                              style: AppTextStyle.f_13_400.color999999,
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              );
            },
            onRetryRefresh: () => controller.refreshData(false),
          );
        });
  }
}
