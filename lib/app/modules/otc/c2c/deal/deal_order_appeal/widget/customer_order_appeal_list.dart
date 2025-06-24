import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/widget/customer_deal_order_mixin.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_appeal/controllers/customer_order_appeal_controller.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerOrderAppeallListView extends StatelessWidget {
  const CustomerOrderAppeallListView({super.key, required this.controller});
  final CustomerOrderAppealController controller;
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
                        CustomerDealAppealTopView(controller: controller),
                        CustomerDealAppealMidView(controller: controller)
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class CustomerDealAppealTopView extends StatelessWidget {
  const CustomerDealAppealTopView({super.key, required this.controller});
  final CustomerOrderAppealController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  LocaleKeys.c2c288.tr,
                  style: AppTextStyle.f_20_600.color111111,
                ),
              ],
            ).marginOnly(bottom: 6.h),
            Row(
              children: [
                Text(
                  LocaleKeys.c2c255.tr,
                  style: AppTextStyle.f_12_400.color666666,
                ),
              ],
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

class CustomerDealAppealMidView extends StatelessWidget with CustomerOrderRow {
  const CustomerDealAppealMidView({super.key, required this.controller});
  final CustomerOrderAppealController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class CustomerDealAppealBottomView extends StatelessWidget with CustomerOrderRow {
  const CustomerDealAppealBottomView({super.key, required this.controller});
  final CustomerOrderAppealController controller;

  @override
  Widget build(BuildContext context) {
    return controller.model.detailModel.sequence == null
        ? const SizedBox()
        : DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
              ),
            ),
            child: controller.model.detailModel.isComplainUser
                ? Container(
                    padding: EdgeInsets.all(16.w),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    height: 80.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.goOrderhelp();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.colorWhite,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColor.colorABABAB,
                                    width: 1,
                                  ),
                                ),
                                height: 48.h,
                                child: Text(LocaleKeys.b2c34.tr, style: AppTextStyle.f_16_600.color111111)),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                controller.goOrderCancelAppeal();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.color111111,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 48.h,
                                  child: Text(LocaleKeys.c2c258.tr,
                                      style: AppTextStyle.f_16_600.copyWith(color: AppColor.colorWhite)))),
                        ),
                      ],
                    ))
                : Container(
                    padding: EdgeInsets.all(16.w),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    height: 80.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                controller.goOrderhelp();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.color111111,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 48.h,
                                  child: Text(LocaleKeys.b2c34.tr,
                                      style: AppTextStyle.f_16_600.copyWith(color: AppColor.colorWhite)))),
                        ),
                      ],
                    )),
          );
  }
}
