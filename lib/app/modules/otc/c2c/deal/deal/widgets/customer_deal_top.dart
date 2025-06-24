import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal/controllers/customer_deal_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_list.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerDealTopView extends StatelessWidget {
  const CustomerDealTopView({super.key, required this.controller});
  final CustomerDealController controller;
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
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 30.w, 16.w, 100.h),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Expanded(
                          child: Stack(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          controller.isBuy
                                              ? controller.coinSymbolStr!
                                              : ' ',
                                          style: getStyle(
                                              color: AppColor.color666666)),
                                      4.horizontalSpace,
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: 270.w,
                                        ),
                                        child: Obx(() => AutoSizeText(
                                            controller.str.value,
                                            maxLines: 1,
                                            minFontSize: 4,
                                            style: getTextFiledStyle(
                                                color: AppColor.color111111))),
                                      ),
                                    ],
                                  )),
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 5,
                                bottom: 5,
                                child: Obx(() => TextField(
                                      // autofocus: true,
                                      // cursorHeight: 48.w,
                                      enableInteractiveSelection: false,
                                      focusNode: controller.focusNode,
                                      textAlign: TextAlign.center,
                                      controller:
                                          controller.textController.value,
                                      // style: AppTextStyle.h0_600.copyWith(color: Colors.transparent),
                                      style: getTextFiledStyle(
                                          color: Colors.transparent),

                                      decoration: InputDecoration(
                                        hintStyle: getTextFiledStyle(
                                            color: AppColor.colorABABAB),
                                        hintText: '  0',
                                        border: InputBorder.none,
                                      ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\.?\d{0,2}')),
                                      ],
                                      onChanged: (value) {
                                        controller.str.value = value;
                                        controller.checkText();
                                      },
                                    )),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              controller.setMaxAmount();
                            },
                            child: Text(LocaleKeys.c2c204.tr,
                                style: getStyle(color: AppColor.color0075FF)))
                      ],
                    ),
                    Obx(() => controller.showError.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.model.limitAmountStr,
                                style: AppTextStyle.f_12_400.colorF53F57,
                              ),
                              const SizedBox(width: 24)
                            ],
                          )
                        : Obx(() => controller.model.avaiableNum.isEmpty
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.model.avaiableNum.value,
                                    style: AppTextStyle.f_14_500.color111111,
                                  ),
                                  const SizedBox(width: 24)
                                ],
                              ))),
                    Container(
                      height: 45.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      margin: EdgeInsets.only(top: 40.h, bottom: 30.h),
                      decoration: ShapeDecoration(
                        color: AppColor.colorF5F5F5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(controller.model.sideStr,
                              style: AppTextStyle.f_14_500.color111111),
                          Row(
                            children: <Widget>[
                              MarketIcon(
                                iconName: controller.model.coinStr,
                                width: 16.w,
                              ),
                              Text(
                                controller.model.coinStr,
                                style: AppTextStyle.f_14_500.color111111,
                              ).marginOnly(left: 4.w, right: 4.w),
                              Text(
                                controller.model.priceStr,
                                style: AppTextStyle.f_14_500.upColor,
                              ).marginOnly(right: 6.w),
                              GestureDetector(
                                  onTap: () {
                                    controller.refreshPrice();
                                  },
                                  child: AnimatedBuilder(
                                    animation: controller.animationController,
                                    builder: (context, child) {
                                      return Transform.rotate(
                                        angle: controller
                                                .animationController.value *
                                            2.0 *
                                            3.14159, // 2 * pi for full rotation
                                        child: child,
                                      );
                                    },
                                    child: MyImage(
                                      'otc/c2c/c2c_refreshIndicator'
                                          .svgAssets(),
                                      width: 12.w,
                                      height: 12.w,
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.model.side == null
                              ? ''
                              : controller.model.isBUy
                                  ? LocaleKeys.c2c205.tr
                                  : LocaleKeys.c2c121.tr,
                          style: AppTextStyle.f_16_500.color0C0D0F,
                        ),
                        controller.model.side == null
                            ? const SizedBox()
                            : controller.model.isBUy
                                ? const SizedBox()
                                : Obx(() => controller
                                        .model.userBalanceStr.value.isNotEmpty
                                    ? Row(
                                        children: <Widget>[
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: LocaleKeys.b2c6.tr,
                                                    style: AppTextStyle
                                                        .f_12_500.color999999),
                                                TextSpan(
                                                    text: controller.model
                                                        .userBalanceStr.value,
                                                    style: AppTextStyle
                                                        .f_12_500.color4D4D4D),
                                              ],
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              try {
                                                final bool res =
                                                    await Get.toNamed(
                                                        Routes.ASSETS_TRANSFER,
                                                        arguments: {
                                                      "from": 3,
                                                      "to": 4
                                                    });
                                                if (res) {
                                                  UIUtil.showSuccess(
                                                      LocaleKeys.assets10.tr);
                                                }
                                              } catch (e) {
                                                Get.log(
                                                    'AssetsContractController actionHandler error: $e');
                                              }
                                            },
                                            child: MyImage(
                                                    'assets/images/contract/coin_switch.svg',
                                                    width: 12.w)
                                                .marginOnly(left: 4.w),
                                          ),
                                        ],
                                      )
                                    : const SizedBox())
                      ],
                    ),
                    controller.model.paymentList == null
                        ? const SizedBox()
                        : controller.model.paymentList!.isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  controller.addpayment();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 16.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 20.h),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1,
                                          color: AppColor.colorEEEEEE),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(LocaleKeys.c2c37.tr,
                                          style: AppTextStyle
                                              .f_16_500.color111111),
                                      MyImage(
                                        'otc/c2c/c2c_deal_add'.svgAssets(),
                                        width: 16.w,
                                        height: 16.w,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Obx(() => Column(
                                  children: <Widget>[
                                    ...controller.model.paymentList!.map((e) =>
                                        GestureDetector(
                                          onTap: () {
                                            var index = controller
                                                .model.paymentList!
                                                .indexOf(e);
                                            controller.selectIndex.value =
                                                index;
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 16.h),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 20.h),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: controller
                                                                .selectIndex
                                                                .value ==
                                                            controller.model
                                                                .paymentList!
                                                                .indexOf(e)
                                                        ? AppColor.color111111
                                                        : AppColor.colorEEEEEE),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    CustomerPayview(
                                                      name: e.usernameStr,
                                                      width: 3,
                                                      height: 9,
                                                      style: AppTextStyle
                                                          .f_15_400.color0C0D0F,
                                                    ),
                                                    SizedBox(
                                                      height: 6.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          e.accountStr,
                                                          style: AppTextStyle
                                                              .f_12_500
                                                              .color4D4D4D,
                                                        ),
                                                        SizedBox(width: 4.w),
                                                        MyImage(
                                                          'otc/c2c/c2c_auth'
                                                              .svgAssets(),
                                                          width: 12.w,
                                                          height: 12.w,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                MyImage(
                                                  controller.selectIndex
                                                              .value ==
                                                          controller.model
                                                              .paymentList!
                                                              .indexOf(e)
                                                      ? 'otc/c2c/c2c_select'
                                                          .svgAssets()
                                                      : 'otc/c2c/c2c_unSelect'
                                                          .svgAssets(),
                                                  width: 16.w,
                                                  height: 16.w,
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      LocaleKeys.c2c206.tr,
                      style: AppTextStyle.f_16_500.color0C0D0F,
                    ).paddingOnly(top: 20.h, bottom: 9.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: AppColor.colorEEEEEE),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.PERSONAL_PROFILE,
                                      arguments: {
                                        'uid': controller.model.userId
                                      });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(LocaleKeys.c2c207.tr,
                                        style:
                                            AppTextStyle.f_12_400.color999999),
                                    Row(
                                      children: <Widget>[
                                        Text(controller.model.usernameStr,
                                                style: AppTextStyle
                                                    .f_14_500.color0C0D0F)
                                            .marginOnly(right: 2.w),
                                        controller.model.username == null
                                            ? const SizedBox()
                                            : MyImage(
                                                'otc/c2c/c2c_arrow'.svgAssets(),
                                                width: 10.w,
                                                height: 10.w,
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(LocaleKeys.c2c208.tr,
                                      style: AppTextStyle.f_12_400.color999999),
                                  Text(controller.model.limitTimeStr,
                                      style: AppTextStyle.f_14_500.color0C0D0F)
                                ],
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16.h),
                            height: 1,
                            color: AppColor.colorEEEEEE,
                          ),
                          Text(LocaleKeys.c2c210.tr,
                                  style: AppTextStyle.f_12_500.color333333)
                              .marginOnly(bottom: 10.h),
                          Text(LocaleKeys.c2c211.tr,
                              style: AppTextStyle.f_12_400_15.color666666)
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  getStyle({required Color color}) {
    return TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        height: 4,
        color: color,
        fontFamily: 'Ark Sans SC');
  }

  getTextFiledStyle({required Color color}) {
    return TextStyle(
        fontSize: 52.sp,
        fontWeight: FontWeight.w600,
        height: 1,
        color: color,
        fontFamily: 'Ark Sans SC',
        overflow: TextOverflow.ellipsis);
  }
}
