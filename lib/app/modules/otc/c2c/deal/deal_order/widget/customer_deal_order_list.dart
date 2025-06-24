import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/controllers/customer_deal_order_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/widget/customer_deal_order_mixin.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerDealOrderListView extends StatelessWidget {
  const CustomerDealOrderListView({super.key, required this.controller});
  final CustomerDealOrderController controller;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshVC,
      enablePullDown: true,
      onRefresh: () async {
        await controller.getData();
        controller.refreshVC.refreshToIdle();
        controller.refreshVC.loadComplete();
      },
      child: CustomScrollView(
        slivers: [
          controller.model.detailModel.sequence == null
              ? const FollowOrdersLoading()
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
                    child: Column(
                      children: <Widget>[
                        CustomerDealOrderTopView(controller: controller),
                        CustomerDealOrderMidView(controller: controller)
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class CustomerDealOrderTopView extends StatelessWidget {
  const CustomerDealOrderTopView({super.key, required this.controller});
  final CustomerDealOrderController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  controller.isBuy
                      ? LocaleKeys.c2c216.tr
                      : controller.model.detailModel.status == 1
                          ? LocaleKeys.c2c268.tr
                          : LocaleKeys.c2c293.tr, //已付款
                  style: AppTextStyle.f_20_600.color111111,
                ),
              ],
            ).marginOnly(bottom: 6.h),
            controller.model.detailModel.status == 2
                ? Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.c2c294.tr,
                          style: AppTextStyle.f_12_400.color666666,
                        ),
                      ),
                    ],
                  )
                : Obx(
                    () => controller.limitTimeStr.value.isNotEmpty
                        ? Row(
                            children: [
                              Text(
                                LocaleKeys.c2c217.tr,
                                style: AppTextStyle.f_12_400.color666666,
                              ),
                              SizedBox(width: 4.h),
                              Text(
                                controller.limitTimeStr.value,
                                style: AppTextStyle.f_12_400.color333333,
                              )
                            ],
                          )
                        : Text(
                            '',
                            style: AppTextStyle.f_12_400.color666666,
                          ),
                  ),
            CustomerDealOrderTop(
                icon: controller.model.chartModel.icon,
                usernameStr: controller.model.chartModel.usernameStr,
                latestNewsStr: controller.model.chartModel.latestNewsStr,
                countStr: controller.model.chartModel.countStr,
                orderId: controller.model.detailModel.idNum)
          ],
        )
      ],
    );
  }
}

class CustomerDealOrderMidView extends StatelessWidget with CustomerOrderRow {
  const CustomerDealOrderMidView({super.key, required this.controller});
  final CustomerDealOrderController controller;

  @override
  Widget build(BuildContext context) {
    return controller.isBuy
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: AppColor.colorEEEEEE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(controller.model.detailModel.sideStr,
                            style: AppTextStyle.f_14_500.copyWith(color: controller.model.detailModel.sideStrColor)),
                        Row(
                          children: <Widget>[
                            MarketIcon(
                              iconName: controller.model.detailModel.coinStr,
                              width: 16,
                            ),
                            Text(
                              controller.model.detailModel.coinStr,
                              style: AppTextStyle.f_14_500.color111111,
                            ).marginOnly(left: 4.w),
                          ],
                        )
                      ],
                    ).marginOnly(bottom: 8.h),
                    getRow(LocaleKeys.c2c219.tr, controller.model.detailModel.sequenceStr, haveCopy: true),
                    getRow(LocaleKeys.c2c220.tr, controller.model.detailModel.priceStr),
                    getRow(LocaleKeys.c2c221.tr, controller.model.detailModel.volumeStr),
                    getRow(LocaleKeys.c2c222.tr, controller.model.detailModel.totalPriceStr),
                    getRow(LocaleKeys.c2c223.tr, controller.model.detailModel.paymentStr,
                        payKey: controller.model.detailModel.payKey),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.h),
                      height: 1,
                      color: AppColor.colorEEEEEE,
                    ),
                    Text(LocaleKeys.c2c224.tr, style: AppTextStyle.f_12_500.color333333).marginOnly(bottom: 10.h),
                    Text(LocaleKeys.c2c225.tr, style: AppTextStyle.f_12_400_15.color666666)
                  ],
                ),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: AppColor.colorEEEEEE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(controller.model.detailModel.sideStr,
                            style: AppTextStyle.f_14_500.copyWith(color: controller.model.detailModel.sideStrColor)),
                        Row(
                          children: <Widget>[
                            MarketIcon(
                              iconName: controller.model.detailModel.coinStr,
                              width: 16,
                            ),
                            Text(
                              controller.model.detailModel.coinStr,
                              style: AppTextStyle.f_14_500.color111111,
                            ).marginOnly(left: 4.w),
                          ],
                        )
                      ],
                    ).marginOnly(bottom: 8.h),
                    getRow(LocaleKeys.c2c220.tr, controller.model.detailModel.priceStr),
                    getRow(LocaleKeys.c2c221.tr, controller.model.detailModel.volumeStr),
                    getRow(LocaleKeys.c2c222.tr, controller.model.detailModel.totalPriceStr),
                    getRow(LocaleKeys.c2c121.tr, controller.model.detailModel.paymentStr,
                        payKey: controller.model.detailModel.payKey),
                    getRow(LocaleKeys.c2c122.tr, controller.model.detailModel.paymentAccountStr),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.h),
                      height: 1,
                      color: AppColor.colorEEEEEE,
                    ),
                    getRow(LocaleKeys.c2c295.tr, controller.model.detailModel.buyer?.otcNickName ?? '--'),
                    getRow(LocaleKeys.c2c273.tr, controller.model.detailModel.buyer?.realName ?? '--'),
                    getRow(LocaleKeys.c2c242.tr, controller.model.detailModel.createdTime),
                    getRow(LocaleKeys.c2c219.tr, controller.model.detailModel.sequenceStr, haveCopy: true),
                  ],
                ),
              )
            ],
          );
  }
}
