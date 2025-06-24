import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_tabbar.dart';
import 'package:nt_app_flutter/app/modules/otc/b2c/widget/otc_jump_mercury_bottom_dialog.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_sheet.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/b2c_controller.dart';
import '../widgets/b2c_input_field.dart';

class B2cView extends GetView<B2cController> {
  const B2cView({super.key, this.currency = ''});
  final String currency;
  @override
  Widget build(BuildContext context) {
    controller.currency = currency;
    final saftBottomHeight = MediaQuery.of(context).padding.bottom;
    return  Scaffold(
          floatingActionButton: _bottomBtn(),
          floatingActionButtonLocation: CustomFloatingActionButtonLocation(saftBottomHeight + 16),
          body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: FollowOrdersTabbar(
                        marginTop: 0,
                        marginBottom: 26,
                        labelStyle: AppTextStyle.f_18_600,
                        unselectedLabelStyle: AppTextStyle.f_18_600,
                        height: 35,
                        radius: 32,
                        labelPadding: 14,
                        rightWidget: Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: MyImage(
                            width: 14.w,
                            height: 14.h,
                            'assets/images/otc/b2c_history_order.svg',
                            onTap: () {
                              if (UserGetx.to.goIsLogin()) {
                                Get.toNamed(Routes.B2C_ORDER_HISTORY);
                              }
                            },
                          ),
                        ),
                        controller: controller.tabController,
                        dataArray: controller.navTabs.map((e) => e.value).toList()),
                  ),
                ];
              },
              body: TabBarView(controller: controller.tabController, children: [_buyFieldForm(), _sellFieldForm()]))
    );
  }
}

extension B2CViewX on B2cView {
  Widget _buyFieldForm() {
    return Obx(() {
      return Column(
        children: [
          B2CInputField(
            title: LocaleKeys.b2c2.tr,
            hintText: '0.00',
            precision: controller.fiat.value.precisionInt,
            textEditingController: controller.buyPayTextController,
            errorText: controller.buyLimitError.value,
            subWidget: fabi(),
            focusNode: controller.buyPayFocusNode,
          ),
          10.verticalSpace,
          B2CInputField(
            title: LocaleKeys.b2c3.tr,
            hintText: '0.00',
            precision: controller.crypto.value.precisionInt,
            textEditingController: controller.buyReceiveTextController,
            subWidget: usdt(),
            focusNode: controller.buyReceiveFocusNode,
            haveErrorStr: false,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(LocaleKeys.b2c17.tr, style: AppTextStyle.f_12_600.color666666).paddingOnly(top: 20.w, bottom: 10.w),
              Container(
                height: 74.w,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFECECEC)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: GestureDetector(
                    onTap: () {
                      showB2CSheetView(
                          controller.channelModel,
                          controller.buyPayTextController.text.isEmpty ? 1 : controller.buyPayTextController.text.toNum(),
                          controller.fiat.value.symbol, (i) {
                        controller.channelIndex.value = i;
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Obx(() => controller.channelIndex.value == -1
                            ? Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: Text(
                                  LocaleKeys.c2c50.tr,
                                  style: AppTextStyle.f_15_600.color111111,
                                ),
                              )
                            : Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.w, right: 8.w),
                                    child: MyImage(
                                      controller.channelModel.payTypeList![controller.channelIndex.value].iconUrl,
                                      width: 44.w,
                                      height: 24.w,
                                    ),
                                  ),
                                  Text(
                                    controller.channelModel.payTypeList![controller.channelIndex.value].payWayName ?? '',
                                    style: AppTextStyle.f_15_600.color111111,
                                  )
                                ],
                              )),
                        Padding(
                          padding: EdgeInsets.only(right: 24.w),
                          child: MyImage(
                            'assets/images/otc/b2c_more.svg',
                            width: 16,
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ).marginSymmetric(horizontal: 16.w),
          _myRate()
        ],
      );
    });
  }

  Widget _sellFieldForm() {
    return Obx(() {
      return Column(
        children: [
          B2CInputField(
              title: LocaleKeys.b2c4.tr,
              precision: controller.crypto.value.precisionInt,
              hintText: '0.00',
              // errorText: controller.sellCryptoError.value,
              errorText: controller.sellLimitError.value,
              textEditingController: controller.sellPayTextController,
              subWidget: usdt(),
              focusNode: controller.sellPayFocusNode,
              topRightView: _myBalance()),
          10.verticalSpace,
          B2CInputField(
            title: LocaleKeys.b2c3.tr,
            // errorText: controller.sellLimitError.value,
            precision: controller.fiatSell.value.precisionInt,
            hintText: '0.00',
            textEditingController: controller.sellReceiveTextController,
            subWidget: fabi(isBuy: false),
            focusNode: controller.sellReceiveFocusNode,
          ),
          _myRate()
        ],
      );
    });
  }

  Widget _myRate() {
    return Column(
      children: <Widget>[
        // const Divider(
        //   height: 1,
        //   color: AppColor.colorF5F5F5,
        // ),
        20.verticalSpace,
        Row(
          children: [
            24.horizontalSpace,
            Text(
              LocaleKeys.b2c7.tr,
              style: AppTextStyle.f_12_500.color666666,
            ),
            10.horizontalSpace,
            Obx(
              () => Text(
                controller.index.value == 0
                    ? '${controller.crypto.value.crypto ?? ''}/${controller.fiat.value.currency ?? ''} 1:${controller.cryptoRate.value}'
                    : '${controller.crypto.value.crypto ?? ''}/${controller.fiatSell.value.currency ?? ''} 1:${controller.cryptoSellRate.value}',
                style: AppTextStyle.f_12_500.color111111,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _myBalance() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            controller.onMax();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              LocaleKeys.b2c5.tr,
              style: AppTextStyle.f_12_400.color0075FF,
            ),
          ),
        ),
        Container(
          width: 1,
          color: AppColor.colorD9D9D9,
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: InkWell(
            onTap: () {
              controller.onRecharge();
            },
            child: Row(
              children: [
                Text(
                  LocaleKeys.b2c6.tr,
                  style: AppTextStyle.f_12_500.color999999,
                ),
                Obx(
                  () => Text(
                    '${AssetsGetx.to.c2cBalance.toNum().toPrecision(controller.crypto.value.precision?.toInt() ?? 2)} USDT',
                    style: AppTextStyle.f_11_500.color4D4D4D,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    try {
                      final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {"from": 3, "to": 4});
                      if (res) {
                        UIUtil.showSuccess(LocaleKeys.assets10.tr);
                      }
                    } catch (e) {
                      Get.log('AssetsContractController actionHandler error: $e');
                    }
                  },
                  child: MyImage('assets/images/contract/coin_switch.svg', width: 12.w).marginOnly(left: 2.w),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget fabi({bool isBuy = true}) {
    return InkWell(
      onTap: () {
        controller.selectOntap();
      },
      child: Container(
        padding: EdgeInsets.only(right: 16.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyImage(
              isBuy ? controller.fiat.value.icon ?? '' : controller.fiatSell.value.icon ?? '',
              width: 24.w,
              height: 24.w,
            ),
            4.horizontalSpace,
            Text(
              isBuy
                  ? controller.fiat.value.currency?.toUpperCase() ?? ''
                  : controller.fiatSell.value.currency?.toUpperCase() ?? '',
              style: AppTextStyle.f_16_600.color111111,
            ),
            4.horizontalSpace,
            MyImage(
              'assets/images/otc/b2c_more.svg',
              width: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget usdt() {
    return Container(
      padding: EdgeInsets.only(right: 16.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyImage(
            controller.crypto.value.icon ?? '',
            width: 24.w,
            height: 24.w,
          ),
          4.horizontalSpace,
          Text(
            controller.crypto.value.crypto?.toUpperCase() ?? '',
            style: AppTextStyle.f_16_600.color111111,
          ),
        ],
      ),
    );
  }

Widget _bottomBtn() {
  return Obx(() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 1,
          color: AppColor.colorF5F5F5,
        ),
        16.verticalSpace,
        MyButton(
          text: controller.index.value == 0
              ? '${LocaleKeys.b2c10.tr} ${controller.crypto.value.code?.toUpperCase() ?? 'USDT'}'
              : '${LocaleKeys.b2c11.tr} ${controller.crypto.value.code?.toUpperCase() ?? 'USDT'}',
          onTap: () async {
            final res = await otcJumpMercuryBottomDialog(Get.context!);
            if (res != true) return;
            if (controller.index.value == 0) {
              controller.onBuy();
            } else {
              controller.onBuy(isBuy: false);
            }
          },
          width: 343.w,
          height: 48.h,
          borderRadius: BorderRadius.circular(100.r),
          backgroundColor: (controller.index.value == 0 ? controller.canBuy.value : controller.canSell.value)
              ? AppColor.color0075FF
              : AppColor.colorCCCCCC,
          textStyle: AppTextStyle.f_18_500.colorWhite,
        ),
      ],
    );
  });
}}


class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final double offsetFromBottom;

  CustomFloatingActionButtonLocation(this.offsetFromBottom);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = (scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width) / 2;
    final double fabY = scaffoldGeometry.scaffoldSize.height - scaffoldGeometry.floatingActionButtonSize.height - offsetFromBottom;
    return Offset(fabX, fabY);
  }
}