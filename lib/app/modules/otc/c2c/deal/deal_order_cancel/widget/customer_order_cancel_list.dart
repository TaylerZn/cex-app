import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/widget/customer_deal_order_mixin.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_cancel/controllers/customer_order_cancel_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerOrderCancelListView extends StatelessWidget {
  const CustomerOrderCancelListView({super.key, required this.controller});
  final CustomerOrderCancelController controller;
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
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10, 16.w, 100.h),
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
  final CustomerOrderCancelController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipOval(
              child: MyImage(
                'assets/images/otc/c2c/c2c_cancel.png',
                width: 50.w,
                height: 50.w,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    LocaleKeys.c2c151.tr,
                    style: AppTextStyle.f_20_600.color111111,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    LocaleKeys.c2c265.tr,
                    style: AppTextStyle.f_12_400.color666666.ellipsis,
                  ),
                ],
              ).paddingOnly(left: 8.h, right: 30.h),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.C2C_CHAT,
                    arguments: controller.idNum!.toString());
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 33,
                    height: 31,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: MyImage(
                      'otc/c2c/c2c_cancel_chat'.svgAssets(),
                      width: 17.w,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    ).marginOnly(bottom: 24.h);
  }
}

class CustomerDealOrderMidView extends StatelessWidget with CustomerOrderRow {
  const CustomerDealOrderMidView({super.key, required this.controller});
  final CustomerOrderCancelController controller;

  @override
  Widget build(BuildContext context) {
    return controller.model.detailModel.isBUy
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 1, color: AppColor.colorEEEEEE),
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
                            style: AppTextStyle.f_14_500.copyWith(
                                color:
                                    controller.model.detailModel.sideStrColor)),
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
                    getRow(LocaleKeys.c2c222.tr,
                        controller.model.detailModel.totalPriceStr),
                    getRow(LocaleKeys.c2c220.tr,
                        controller.model.detailModel.priceStr),
                    getRow(LocaleKeys.c2c221.tr,
                        controller.model.detailModel.volumeStr),
                    getRow(LocaleKeys.c2c121.tr,
                        controller.model.detailModel.paymentStr,
                        payKey: controller.model.detailModel.payKey),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.h),
                      height: 1,
                      color: AppColor.colorEEEEEE,
                    ),
                    getRow(
                        controller.model.detailModel.isBUy
                            ? LocaleKeys.c2c251.tr
                            : LocaleKeys.c2c295.tr,
                        controller.model.detailModel.seller?.otcNickName ?? ''),
                    getRow(LocaleKeys.c2c242.tr,
                        controller.model.detailModel.createdTime),
                    getRow(LocaleKeys.c2c219.tr,
                        controller.model.detailModel.sequenceStr,
                        haveCopy: true),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.goOrderhelp();
                },
                child: Container(
                    margin: EdgeInsets.only(top: 16.h),
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: AppColor.colorEEEEEE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        MyImage(
                          'otc/c2c/c2c_success_answer'.svgAssets(),
                          width: 14.w,
                          height: 14.w,
                        ),
                        Text(LocaleKeys.c2c253.tr,
                                style: AppTextStyle.f_12_500.color333333)
                            .marginOnly(left: 4.w),
                        const Spacer(),
                        MyImage(
                          'default/go'.svgAssets(),
                          width: 14.w,
                          height: 14.w,
                        ),
                      ],
                    )),
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
                    side:
                        const BorderSide(width: 1, color: AppColor.colorEEEEEE),
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
                            style: AppTextStyle.f_14_500.copyWith(
                                color:
                                    controller.model.detailModel.sideStrColor)),
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
                    getRow(LocaleKeys.c2c222.tr,
                        controller.model.detailModel.totalPriceStr),
                    getRow(LocaleKeys.c2c220.tr,
                        controller.model.detailModel.priceStr),
                    getRow(LocaleKeys.c2c221.tr,
                        controller.model.detailModel.volumeStr),
                    getRow(LocaleKeys.c2c121.tr,
                        controller.model.detailModel.paymentStr,
                        payKey: controller.model.detailModel.payKey),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.h),
                      height: 1,
                      color: AppColor.colorEEEEEE,
                    ),
                    getRow(LocaleKeys.c2c295.tr,
                        controller.model.detailModel.paymentAccountStr),
                    getRow(LocaleKeys.c2c242.tr,
                        controller.model.detailModel.createdTime),
                    getRow(LocaleKeys.c2c219.tr,
                        controller.model.detailModel.sequenceStr,
                        haveCopy: true),
                  ],
                ),
              )
            ],
          );
  }
}
