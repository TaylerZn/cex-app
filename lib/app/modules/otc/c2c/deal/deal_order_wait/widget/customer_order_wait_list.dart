import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/widget/customer_deal_order_mixin.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_wait/controllers/customer_order_wait_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerOrderWaitListView extends StatelessWidget {
  const CustomerOrderWaitListView({super.key, required this.controller});
  final CustomerOrderWaitController controller;
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
                    padding: EdgeInsets.fromLTRB(16.w, 20.w, 16.w, 100.h),
                    child: Column(
                      children: <Widget>[
                        controller.model.detailModel.status! > 2
                            ? CustomerDealSuccessTopView(controller: controller)
                            : CustomerDealWaitTopView(controller: controller),
                        controller.model.detailModel.status! > 2
                            ? CustomerDealSuccessMidView(controller: controller)
                            : CustomerDealWaitMidView(controller: controller)
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class CustomerDealWaitTopView extends StatelessWidget {
  const CustomerDealWaitTopView({super.key, required this.controller});
  final CustomerOrderWaitController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  LocaleKeys.c2c239.tr,
                  style: AppTextStyle.f_20_600.color111111,
                ),
              ],
            ).marginOnly(bottom: 6.h),
            Obx(
              () => controller.remainTimeStr.value.isNotEmpty
                  ? Row(
                      children: [
                        Text(
                          LocaleKeys.c2c240.tr,
                          style: AppTextStyle.f_12_400.color666666,
                        ),
                        Text(
                          controller.remainTimeStr.value,
                          style: AppTextStyle.f_12_400.color333333,
                        ).paddingSymmetric(horizontal: 4.w),
                        Text(
                          '${LocaleKeys.c2c241.tr}USDT',
                          style: AppTextStyle.f_12_400.color666666,
                        ),
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

class CustomerDealSuccessTopView extends StatelessWidget {
  const CustomerDealSuccessTopView({super.key, required this.controller});
  final CustomerOrderWaitController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipOval(
              child: MyImage(
                'assets/images/my/setting/kyc_ok.png',
                width: 36.w,
                height: 36.w,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    LocaleKeys.c2c247.tr,
                    style: AppTextStyle.f_15_500.color4D4D4D,
                  ),
                  controller.model.detailModel.status != 9
                      ? Text(
                          '${controller.model.detailModel.succesSideStr}${controller.model.detailModel.usdtNum} USDT',
                          style: AppTextStyle.f_12_400.color999999,
                        )
                      : const SizedBox(),
                ],
              ).paddingOnly(left: 8.h, right: 30.h),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.C2C_CHAT, arguments: controller.idNum!.toString());
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: MyImage(
                      'otc/c2c/c2c_cancel_chat'.svgAssets(),
                      width: 17.w,
                    ),
                  ),
                  Positioned(
                      right: -6.w,
                      top: -6.w,
                      child: MyButton(
                        text: controller.model.chartModel.countStr,
                        height: 12.h,
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        textStyle: AppTextStyle.f_10_500.colorWhite,
                        backgroundColor: AppColor.colorF53F57,
                        borderRadius: BorderRadius.circular(4),
                      ))
                ],
              ),
            )
          ],
        )
      ],
    ).marginOnly(bottom: 24.h);
  }
}

class CustomerDealWaitMidView extends StatelessWidget with CustomerOrderRow {
  const CustomerDealWaitMidView({super.key, required this.controller});
  final CustomerOrderWaitController controller;

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
              getRow(LocaleKeys.c2c220.tr, controller.model.detailModel.priceStr),
              getRow(LocaleKeys.c2c221.tr, controller.model.detailModel.volumeStr),
              getRow(LocaleKeys.c2c222.tr, controller.model.detailModel.totalPriceStr),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.h),
                height: 1,
                color: AppColor.colorEEEEEE,
              ),
              getRow(LocaleKeys.c2c219.tr, controller.model.detailModel.sequenceStr, haveCopy: true),
              getRow(LocaleKeys.c2c242.tr, controller.model.detailModel.createdTime),
              getRow(LocaleKeys.c2c243.tr, controller.model.detailModel.paymentAccountStr, haveCopy: true),
            ],
          ),
        )
      ],
    );
  }
}

class CustomerDealSuccessMidView extends StatelessWidget with CustomerOrderRow {
  const CustomerDealSuccessMidView({super.key, required this.controller});
  final CustomerOrderWaitController controller;

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
              getRow(LocaleKeys.c2c222.tr, controller.model.detailModel.totalPriceStr),
              getRow(LocaleKeys.c2c220.tr, controller.model.detailModel.priceStr),
              getRow(LocaleKeys.c2c221.tr, controller.model.detailModel.volumeStr),
              getRow(controller.model.detailModel.isBUy ? LocaleKeys.c2c250.tr : LocaleKeys.c2c121.tr,
                  controller.model.detailModel.paymentStr,
                  payKey: controller.model.detailModel.payKey),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.h),
                height: 1,
                color: AppColor.colorEEEEEE,
              ),
              getRow(controller.model.detailModel.isBUy ? LocaleKeys.c2c252.tr : LocaleKeys.c2c295.tr,
                  controller.model.detailModel.useNameStr),
              getRow(LocaleKeys.c2c242.tr, controller.model.detailModel.createdTime),
              getRow(LocaleKeys.c2c219.tr, controller.model.detailModel.sequenceStr, haveCopy: true),
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
                  side: const BorderSide(width: 1, color: AppColor.colorEEEEEE),
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
                  Text(LocaleKeys.c2c253.tr, style: AppTextStyle.f_12_500.color333333).marginOnly(left: 4.w),
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
    );
  }
}
