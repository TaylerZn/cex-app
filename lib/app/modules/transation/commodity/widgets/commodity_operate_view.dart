import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_create_order_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/widgets/commodity_k_chart_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/widgets/commodity_stop_trade_button.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/widgets/commondity_stop_trade_tip.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/coin_24h_info_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_slider_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/trade_switch.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../getX/user_Getx.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/basic/my_dotted_text.dart';
import '../../../../widgets/components/guide/guide_index_view.dart';
import '../../../../widgets/components/transaction/bottom_sheet/common_bottom_sheet.dart';
import '../../../../widgets/components/transaction/selection_button.dart';
import '../../../../widgets/components/transaction/title_amount_widget.dart';
import '../../../../widgets/components/transaction/title_detail_button.dart';
import '../../../../widgets/components/transaction/transaction_input_widget.dart';
import '../../../../widgets/components/transaction/transaction_switch_button.dart';
import '../../../../widgets/dialog/tip_dialog.dart';
import '../../contract/widgets/stop_win_lose_widget.dart';
import '../../contract/widgets/suffix_button.dart';
import '../../widgets/margin_lever_rate.dart';
import '../controllers/commodity_controller.dart';

class CommodityOperateView extends GetView<CommodityController> {
  const CommodityOperateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                6.verticalSpace,
                Obx(() {
                  return GetBuilder<CommodityDataStoreController>(
                    id: controller.state.contractInfo.value?.subSymbol ?? '',
                    builder: (logic) {
                      ContractInfo? contractInfo =
                          logic.getContractInfoByContractId(controller.state.contractInfo.value?.id ?? 0) ??
                              controller.state.contractInfo.value;
                      return Coin24HInfoWidget(
                        contractInfo: contractInfo,
                      );
                    },
                  );
                }),
                Obx(() {
                  if (!controller.isGuiding.value) {
                    return const CommodityKChartWidget(false).marginOnly(top: 12.h);
                  } else {
                    return 0.verticalSpace;
                  }
                }),
                12.verticalSpace,
                Obx(() {
                  if ((controller.state.openStatus.value?.tradeOpen ?? true) &&
                      !(controller.state.openStatus.value?.isStop ?? false)) {
                    return const SizedBox.shrink();
                  } else {
                    return const CommodityStopTradeTip().marginOnly(bottom: 11.h);
                  }
                }),

                /// 保证金杠杆
                MarginLeverRate(
                  guideType: AppGuideType.standardContract,
                  onMarginModelChanged: (position) {
                    controller.editMarginModel(position);
                  },
                  margin: controller.holdAmount,
                  userConfig: controller.state.userConfig,
                  onLeverChanged: (lever) {
                    controller.editLever(lever);
                  },
                  fundingRate: controller.state.fundingRate,
                  contractInfo: controller.state.contractInfo,
                  onCountDownEnd: () {
                    controller.fetchCurrentContractUserConfig();
                  },
                ),
                11.verticalSpace,
                Obx(() {
                  /// 开仓 和  平仓
                  return TradeSwitch(
                    height: 31.h,
                    width: 343.w,
                    leftText: LocaleKeys.trade18.tr,
                    rightText: LocaleKeys.trade19.tr,
                    onValueChanged: (state) {
                      if (UserGetx.to.goIsLogin()) {
                        controller.state.switchState.value = state;
                        controller.clear();
                      }
                    },
                    state: controller.state.switchState.value,
                  );
                }),
                8.verticalSpace,
                _buildOrderType(),
                8.verticalSpace,

                /// 开单 类型
                AppGuideView(
                  order: 4,
                  arrowPosition: AppGuideArrowPosition.top,
                  guideType: AppGuideType.standardContract,
                  padding: EdgeInsets.zero,
                  finishCallback: () {
                    controller.isGuiding.value = false;
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildPriceInput(),
                      8.verticalSpace,
                      _buildAmountInput(),
                      8.verticalSpace,
                      _buildCommondityBalance(),
                      Obx(() {
                        if (controller.state.switchState.value == TransactionSwitchButtonValue.left) {
                          return _buildProfitLoss();
                        } else {
                          return const SizedBox();
                        }
                      }),
                      _buildCreateOrder(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildCreateOrder() {
    return Obx(() {
      String open =
          '${controller.state.canOpenAmount.value} ${controller.state.amountUnits.value[controller.state.amountUnitIndex.value]}';
      String closeMore =
          '${controller.state.canCloseMoreAmount.value} ${controller.state.amountUnits.value[controller.state.amountUnitIndex.value]}';
      String closeEmpty =
          '${controller.state.canCloseEmptyAmount.value} ${controller.state.amountUnits.value[controller.state.amountUnitIndex.value]}';
      String margin = '${controller.state.margin.value?.toPrecision(2) ?? '--'} USDT';

      /// 开市状态
      if (!(controller.state.openStatus.value?.tradeOpen ?? true)) {
        return CommodityStopTradeButton(
            open: open,
            margin: margin,
            endTime: controller.state.openStatus.value?.nextOpenTimeIntervalMills ?? 0,
            stopCallback: () {
              controller.fetchOpenStatus();
            });
      }

      /// 切换开仓平仓
      if (controller.state.switchState.value == TransactionSwitchButtonValue.left) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  TitleAmountWidget(title: LocaleKeys.trade20.tr, amount: open),
                  7.verticalSpace,
                  TitleAmountWidget(title: LocaleKeys.trade21.tr, amount: margin),
                  10.verticalSpace,
                  GetBuilder<UserGetx>(
                    id: 'open_contract',
                    builder: (logic) {
                      return TitleDetailButton(
                        height: 34.h,
                        title: logic.isOpenContract ? LocaleKeys.trade22.tr : LocaleKeys.trade228.tr,
                        bgColor: AppColor.upColor,
                        onTap: () {
                          if (logic.goIsOpenContract()) {
                            controller.createOrder('BUY');
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Column(
                children: [
                  TitleAmountWidget(title: LocaleKeys.trade20.tr, amount: open),
                  7.verticalSpace,
                  TitleAmountWidget(title: LocaleKeys.trade21.tr, amount: margin),
                  10.verticalSpace,
                  GetBuilder<UserGetx>(
                      id: 'open_contract',
                      builder: (logic) {
                        return TitleDetailButton(
                            height: 34.h,
                            title: logic.isOpenContract ? LocaleKeys.trade23.tr : LocaleKeys.trade228.tr,
                            bgColor: AppColor.downColor,
                            onTap: () {
                              if (logic.goIsOpenContract()) {
                                controller.createOrder('SELL');
                              }
                            });
                      }),
                ],
              ),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  TitleAmountWidget(title: LocaleKeys.trade24.tr, amount: closeMore),
                  10.verticalSpace,
                  GetBuilder<UserGetx>(
                      id: 'open_contract',
                      builder: (logic) {
                        return TitleDetailButton(
                            height: 34.h,
                            title: logic.isOpenContract ? LocaleKeys.trade25.tr : LocaleKeys.trade228.tr,
                            bgColor: AppColor.downColor,
                            onTap: () {
                              if (logic.goIsOpenContract()) {
                                controller.createOrder('SELL');
                              }
                            });
                      }),
                ],
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Column(
                children: [
                  TitleAmountWidget(title: LocaleKeys.trade24.tr, amount: closeEmpty),
                  10.verticalSpace,
                  GetBuilder<UserGetx>(
                      id: 'open_contract',
                      builder: (logic) {
                        return TitleDetailButton(
                            height: 34.h,
                            title: logic.isOpenContract ? LocaleKeys.trade26.tr : LocaleKeys.trade228.tr,
                            bgColor: AppColor.upColor,
                            onTap: () {
                              if (logic.goIsOpenContract()) {
                                controller.createOrder('BUY');
                              }
                            });
                      }),
                ],
              ),
            ),
          ],
        ).marginOnly(top: 8.h);
      }
    });
  }

  Widget _buildAmountInput() {
    return Column(
      children: [
        Obx(() {
          int precision = controller.state.contractInfo.value?.multiplier.numDecimalPlaces() ?? 2;
          if (controller.state.amountUnitIndex.value == 1) {
            precision = 0;
          }
          return TransactionInputWidget(
            width: double.infinity,
            hintText: LocaleKeys.trade27.tr,
            maxLength: 15,
            focusNode: controller.amountFocusNode,
            precision: precision,
            controller: controller.amountTextController,
            suffixWidget: SuffixDownButton(
                title: controller.state.amountUnits.value[controller.state.amountUnitIndex.value],
                onTap: () async {
                  try {
                    int? res = await CommonBottomSheet.show(
                        titles: controller.state.amountUnits.value, selectedIndex: controller.state.amountUnitIndex.value);
                    if (res != null) {
                      controller.changeAmountUnitIndex(res);
                    }
                  } catch (e) {
                    Get.log('error: $e');
                  }
                }),
            keyboardType: TextInputType.number,
          );
        }),
        8.verticalSpace,
        Obx(() {
          return MyPercentSliderWidget(
              value: controller.state.percent.value,
              onChanged: (value) {
                if (UserGetx.to.goIsLogin()) {
                  controller.changePrecent(value);
                }
              });
        }),
      ],
    );
  }

  Widget _buildPriceInput() {
    return Obx(() {
      if (controller.state.isMarketOrder.value) {
        return Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColor.colorDADADA,
            borderRadius: BorderRadius.circular(6.r),
          ),
          alignment: Alignment.center,
          child: Text(
            LocaleKeys.trade28.tr,
            style: AppTextStyle.f_14_500.copyWith(
              color: AppColor.colorABABAB,
            ),
          ),
        );
      } else {
        return TransactionInputWidget(
          controller: controller.priceTextController,
          focusNode: controller.priceFocusNode,
          hintText: LocaleKeys.trade29.tr,
          maxLength: 15,
          precision: controller.state.contractInfo.value?.coinResultVo?.symbolPricePrecision.toInt() ?? 0,
          keyboardType: TextInputType.number,
          width: 351.w,
          height: 40.h,
          suffixWidget: Text(
            'USDT',
            style: AppTextStyle.f_16_500.copyWith(
              color: AppColor.colorABABAB,
            ),
          ).marginOnly(right: 12.w),
        );
      }
    });
  }

  Widget _buildOrderType() {
    return Obx(() {
      return SelectionButton.tips(
        height: 30.h,
        width: double.infinity,
        text: controller.state.isMarketOrder.value ? LocaleKeys.trade28.tr : LocaleKeys.trade30.tr,
        onTap: () async {
          int? res = await CommonBottomSheet.show(
            titles: [LocaleKeys.trade28.tr, LocaleKeys.trade30.tr],
            selectedIndex: controller.state.isMarketOrder.value ? 0 : 1,
          );
          if (res != null) {
            controller.state.isMarketOrder.value = res == 0;
          }
        },
        onTipsTap: () {},
      );
    });
    // return SelectionButton.tips(height: 30.h, width: 343.w, text: '', onTap: onTap, onTipsTap: onTipsTap)
    return Row(
      children: [
        Obx(() {
          return _buildBtn(LocaleKeys.trade28.tr, controller.state.isMarketOrder.value, () {
            controller.changeOrderType(true);
          });
        }),
        8.horizontalSpace,
        Obx(() {
          return _buildBtn(LocaleKeys.trade30.tr, !controller.state.isMarketOrder.value, () {
            controller.changeOrderType(false);
          });
        }),
        const Spacer(),
        Obx(() {
          return GetBuilder<CommodityDataStoreController>(
              id: controller.state.contractInfo.value?.subSymbol ?? '',
              builder: (logic) {
                ContractInfo? contractInfo =
                    logic.getContractInfoBySubSymbol(controller.state.contractInfo.value?.subSymbol ?? '');
                return _buildPrice('${LocaleKeys.trade31.tr}:',
                    contractInfo?.esPrice.toPrecision(contractInfo.coinResultVo?.symbolPricePrecision.toInt() ?? 2) ?? '--');
              });
        })
      ],
    );
  }

  /// 止赢止损
  Widget _buildProfitLoss() {
    return Obx(() {
      return Column(
        children: [
          8.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    controller.state.isStopLoss.value = !controller.state.isStopLoss.value;
                  },
                  child: controller.state.isStopLoss.value
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
            offstage: !controller.state.isStopLoss.value,
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

  Widget _buildCommondityBalance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          LocaleKeys.assets81.tr,
          style: AppTextStyle.f_11_400.colorTextTips,
        ),
        AppGuideView(
          order: 3,
          arrowPosition: AppGuideArrowPosition.top,
          guideType: AppGuideType.standardContract,
          finishCallback: () {
            controller.isGuiding.value = false;
          },
          child: InkWell(
            onTap: () {
              if (UserGetx.to.goIsLogin()) {
                Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {
                  'from': 3,
                  'to': 1,
                });
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () {
                    var balance = '${controller.state.availableBalance.value.toPrecision(2)} USDT';
                    if (!UserGetx.to.isLogin) {
                      balance = '-- USDT';
                    }
                    return Text(
                      balance,
                      textAlign: TextAlign.right,
                      style: AppTextStyle.f_11_400.colorTextPrimary,
                    );
                  },
                ),
                4.horizontalSpace,
                MyImage(
                  'assets/images/contract/coin_switch.svg',
                  width: 12.w,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBtn(String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        height: 30.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColor.color111111 : AppColor.colorEEEEEE,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(6.w),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.f_12_600.copyWith(color: isSelected ? AppColor.color111111 : AppColor.colorABABAB),
        ),
      ),
    );
  }

  Widget _buildPrice(String title, String price) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyle.f_11_400.copyWith(
            color: AppColor.color4D4D4D,
          ),
        ),
        4.horizontalSpace,
        Text(
          price,
          style: AppTextStyle.f_11_400.copyWith(
            color: AppColor.color111111,
          ),
        ),
      ],
    );
  }
}
