import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_depth_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/controller_operate_controller_create_order.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/models/order_type.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/action/close_position_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/contract_dept_map_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/form/limit_price_form.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/stop_win_lose_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/suffix_button.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/margin_lever_rate.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';
import 'package:nt_app_flutter/app/widgets/components/after_layout.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/common_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_slider_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/selection_button.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/trade_switch.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/transaction_switch_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../config/theme/app_text_style.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/basic/my_image.dart';
import '../../../../widgets/components/transaction/transaction_input_widget.dart';
import '../../../../widgets/dialog/tip_dialog.dart';
import '../controllers/contract_operate_controller.dart';
import 'action/open_position_widget.dart';
import 'form/limit_price_stop_win_lose_form.dart';
import 'form/market_price_form.dart';
import 'form/market_price_stop_win_lose_form.dart';

class ContractOperateView extends GetView<ContractOperateController> {
  const ContractOperateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        bottom: 16.h,
      ),
      child: Column(
        children: [
          MarginLeverRate(
            guideType: AppGuideType.perpetualContract,
            onMarginModelChanged: (marginModel) {
              controller.editMarginModel(marginModel);
            },
            margin: controller.holdAmount,
            userConfig: controller.userConfig,
            onLeverChanged: (lever) {
              controller.editLever(lever);
            },
            fundingRate: ContractDepthController.to.fundingRate,
            contractInfo: controller.contractInfo,
            onCountDownEnd: () {
              controller.fetchCurrentContractUserConfig();
            },
          ),
          13.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 195.w,
                child: AfterLayout(
                  callback: (RenderAfterLayout ral) {
                    controller.rightHeight.value = ral.size.height;
                  },
                  child: _leftView(controller),
                ),
              ),
              Obx(() {
                return ContractDeptMapWidget(
                  height: controller.rightHeight.value,
                  onValueChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    controller.depthChangePrice(value.price
                        .toString()
                        .toPrecision(controller.contractInfo.value?.coinResultVo
                                ?.symbolPricePrecision
                                .toInt() ??
                            2));
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  /// 左侧视图
  Widget _leftView(ContractOperateController controller) {
    return AppGuideView(
      order: 4,
      guideType: AppGuideType.perpetualContract,
      arrowPosition: AppGuideArrowPosition.bottom,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() {
            return TradeSwitch(
              height: 31.h,
              width: 195.w,
              leftText: LocaleKeys.trade18.tr,
              rightText: LocaleKeys.trade19.tr,
              onValueChanged: (state) {
                if (UserGetx.to.goIsLogin()) {
                  controller.setSwitchState(state);
                }
              },
              state: controller.switchState.value,
            );
          }),
          8.verticalSpace,

          /// 限价单
          Obx(() {
            return SelectionButton.tips(
              height: 30.h,
              width: 195.w,
              text: controller.orderType.value.title.tr,
              onTap: () async {
                try {
                  int? res = await CommonBottomSheet.show(
                    titles: OrderType.values.map((e) => e.title.tr).toList(),
                    selectedIndex: controller.orderType.value.index,
                  );
                  if (res != null) {
                    controller.setOrderType(OrderType.values[res]);
                  }
                } catch (e) {
                  Get.log('error: $e');
                }
              },
              onTipsTap: () {},
            );
          }),
          8.verticalSpace,
          Obx(() {
            switch (controller.orderType.value) {
              case OrderType.limit:
                return LimitPriceForm(
                  precision: controller.contractInfo.value?.coinResultVo
                          ?.symbolPricePrecision
                          .toInt() ??
                      4,
                  controller: controller.limitPriceTextController,
                  focusNode: controller.limitPriceFocusNode,
                );
              case OrderType.market:
                return const MarketPriceForm();
              case OrderType.limitStop:
                return LimitPriceStopWinLoseForm(
                  precision: controller.contractInfo.value?.coinResultVo
                          ?.symbolPricePrecision
                          .toInt() ??
                      4,
                  triggerPriceTextController:
                      controller.limitTriggerPriceTextController,
                  entrustPriceTextController:
                      controller.limitEntrustPriceTextController,
                  triggerPriceFocusNode: controller.limitTriggerPriceFocusNode,
                  entrustPriceFocusNode: controller.limitEntrustPriceFocusNode,
                );
              case OrderType.marketStop:
                return MarketPriceStopWinLoseForm(
                  triggerPriceTextController:
                      controller.marketTriggerPriceTextController,
                  triggerPriceFocusNode: controller.marketTriggerPriceFocusNode,
                  precision: controller.contractInfo.value?.coinResultVo
                          ?.symbolPricePrecision
                          .toInt() ??
                      4,
                );
            }
          }),
          8.verticalSpace,

          /// 数量
          Obx(() {
            int precision = controller.contractInfo.value?.multiplier
                    .numDecimalPlaces()
                    .toInt() ??
                2;
            if (controller.amountUnitIndex.value == 1) {
              precision = 0;
            }
            return TransactionInputWidget(
              hintText: LocaleKeys.trade27.tr,
              controller: controller.amountTextController,
              focusNode: controller.amountFocusNode,
              precision: precision,
              keyboardType: TextInputType.number,
              suffixWidget: SuffixDownButton(
                  title:
                      controller.amountUnits[controller.amountUnitIndex.value],
                  onTap: () async {
                    try {
                      /// 市价单 不能切换
                      int? res = await CommonBottomSheet.show(
                          titles: controller.getAmountUnitList(),
                          selectedIndex:
                              controller.getAmountUnitList().length > 1
                                  ? controller.amountUnitIndex.value
                                  : 0);
                      if (res != null &&
                          controller.getAmountUnitList().length > 1) {
                        controller.setAmountUnitIndex(res);
                      }
                    } catch (e) {
                      Get.log('error: $e');
                    }
                  }),
            );
          }),
          11.verticalSpace,
          Obx(() {
            return MyPercentSliderWidget(
              value: controller.amountPercent,
              onChanged: (value) {
                if (UserGetx.to.goIsLogin()) {
                  controller.changeAmountPercent(value);
                }
              },
            );
          }),
          _buildAvailableBalance(),
          Obx(() {
            if (controller.switchState.value ==
                TransactionSwitchButtonValue.left) {
              return _buildProfitLoss(controller);
            } else {
              return const SizedBox();
            }
          }),
          Obx(() {
            if (controller.switchState.value ==
                TransactionSwitchButtonValue.left) {
              return OpenPositionWidget(
                onBuyMoreTap: () {
                  controller.createOrder('BUY');
                },
                onBuyLessTap: () {
                  controller.createOrder('SELL');
                },
                openAmount:
                    '${controller.canOpenAmount.value?.toPrecision(controller.contractInfo.value?.multiplier.numDecimalPlaces() ?? 2) ?? '--'} ${controller.amountUnits.safeFirst ?? ''}',
                margin:
                    '${controller.margin.value?.toPrecision(2) ?? '--'} ${controller.amountUnits.safeLast ?? ''}',
              );
            } else {
              return ClosePositionWidget(
                onSellMoreTap: () {
                  controller.createOrder('SELL');
                },
                onSellLessTap: () {
                  controller.createOrder('BUY');
                },
                closeMoreAmount:
                    '${controller.canCloseMoreAmount.value ?? '--'} ${controller.amountUnits.safeFirst ?? ''}',
                closeEmptyAmount:
                    '${controller.canCloseEmptyAmount.value ?? '--'} ${controller.amountUnits.safeFirst ?? ''}',
              );
            }
          })
        ],
      ),
    );
  }

  Widget _buildAvailableBalance() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.trade32.tr,
          style: AppTextStyle.f_11_400.colorTextTips,
        ),
        const Spacer(),
        AppGuideView(
          order: 3,
          guideType: AppGuideType.perpetualContract,
          arrowPosition: AppGuideArrowPosition.bottom,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: () {
              if (UserGetx.to.goIsLogin()) {
                Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {
                  'from': 3,
                  'to': 2,
                });
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 可用余额
                GetBuilder<ContractDepthController>(builder: (depthController) {
                  return Obx(() {
                    var balance =
                        '${controller.availableBalance.value.toPrecision(2)} ${controller.amountUnits.last}';
                    if (!UserGetx.to.isLogin) {
                      balance = '-- USDT';
                    }
                    return Text(
                      balance,
                      textAlign: TextAlign.right,
                      style: AppTextStyle.f_11_400.colorTextPrimary,
                    );
                  });
                }),
                4.horizontalSpace,
                Container(
                  width: 12.w,
                  height: 32.h,
                  alignment: Alignment.center,
                  child: MyImage(
                    'assets/images/contract/coin_switch.svg',
                    width: 12.w,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  /// 止赢止损
  Widget _buildProfitLoss(ContractOperateController controller) {
    return Obx(() {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    controller.isStopLoss.value = !controller.isStopLoss.value;
                  },
                  child: controller.isStopLoss.value
                      ? MyImage(
                          'assets/images/contract/check_box_rounded.svg',
                          width: 12.w,
                        ).paddingOnly(right: 4.w)
                      : MyImage(
                          'assets/images/contract/check_box.svg',
                          width: 12.w,
                        ).paddingOnly(right: 4.w)),
              MyDottedText(
                LocaleKeys.trade30.tr,
                style: AppTextStyle.f_11_400.colorTextDescription,
                isCenter: false,
                onTap: () {
                  TipsDialog.show(
                    title: LocaleKeys.trade30.tr,
                    content: LocaleKeys.trade367.tr,
                    okTitle: LocaleKeys.c2c260.tr,
                  );
                },
              ),
            ],
          ),
          8.verticalSpace,
          Offstage(
            offstage: !controller.isStopLoss.value,
            child: StopWinLoseWidget(
              stopWinTextController: controller.stopWinTextController,
              stopLossTextController: controller.stopLossTextController,
              stopWinPriceType: controller.state.stopWinPriceType,
              stopLossPriceType: controller.state.stopLossPriceType,
            ).marginOnly(bottom: 8.h),
          )
        ],
      );
    });
  }
}
