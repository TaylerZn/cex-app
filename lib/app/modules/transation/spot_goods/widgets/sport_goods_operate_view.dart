import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_depth_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_goods_operate_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/models/price_type.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/widgets/form/spot_goods_market_price_form.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/widgets/spot_dept_map_widget.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/after_layout.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../getX/user_Getx.dart';
import '../../../../widgets/components/transaction/bottom_sheet/common_bottom_sheet.dart';
import '../../../../widgets/components/transaction/bottom_sheet/more_option_bottom_sheet.dart';
import '../../../../widgets/components/transaction/selection_button.dart';
import '../../../../widgets/components/transaction/title_amount_widget.dart';
import '../../../../widgets/components/transaction/title_detail_button.dart';
import '../../../../widgets/components/transaction/transaction_switch_button.dart';
import '../controllers/spot_goods_controller.dart';
import 'form/spot_goods_limit_price_form.dart';

class SpotGoodsOperateView extends GetView<SpotGoodsOperateController> {
  const SpotGoodsOperateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 18.h, top: 4.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 5.h,
            color: AppColor.colorF5F5F5,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 195.w,
                child: AfterLayout(
                  callback: (RenderAfterLayout ral) {
                    controller.rightViewHeight.value = ral.size.height;
                  },
                  child: _leftView(controller),
                ),
              ),
              Obx(() {
                return SpotDeptMapWidget(
                  height: controller.rightViewHeight.value,
                  onValueChanged: (value) {
                    if (value != null) {
                      int precision = SpotDepthController.to.firstPrecision
                          .numDecimalPlaces();
                      controller.limitPriceTextController.text =
                          value.price.toString().toPrecision(precision);
                    }
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
  Widget _leftView(SpotGoodsOperateController controller) {
    return AppGuideView(
      order: 3,
      guideType: AppGuideType.spot,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() {
            return TransactionSwitchButton(
              leftText: LocaleKeys.trade47.tr,
              rightText: LocaleKeys.trade48.tr,
              onValueChanged: (state) {
                if (UserGetx.to.goIsLogin()) {
                  controller.setSwitchState(state);
                }
              },
              state: controller.switchState.value,
            );
          }),
          Container(
            height: 36.h,
            alignment: Alignment.centerRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.trade32.tr,
                  style: TextStyle(
                    color: AppColor.color999999,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                AppGuideView(
                  order: 4,
                  guideType: AppGuideType.spot,
                  child: InkWell(
                    onTap: () {
                      MoreOptionBottomSheet.show(
                        onTransfer: () {
                          Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {
                            'from': 0,
                            'to': 3,
                          });
                        },
                        marketInfoModel: controller.marketInfoModel,
                        onTradeRule: () {
                          // TDOO::
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Obx(() {
                          var balance = '-- USDT';
                          if (controller.switchState.value ==
                              TransactionSwitchButtonValue.left) {
                            if (controller.canBuyBalance.value != '--') {
                              balance =
                                  '${controller.canBuyBalance.value.toDecimal().toPrecision(SpotDepthController.to.firstPrecision.numDecimalPlaces())} USDT';
                            }
                          } else {
                            if (controller.canSellBalance.value != '--') {
                              balance =
                                  '${controller.canSellBalance.value.toPrecision(SpotDepthController.to.firstPrecision.numDecimalPlaces())} ${controller.marketInfoModel?.firstName ?? ''}';
                            }
                          }
                          if (!UserGetx.to.isLogin) {
                            balance = '-- USDT';
                          }
                          return Text(
                            balance,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppColor.color111111,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                        4.horizontalSpace,
                        Container(
                          width: 12.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '+',
                            style: TextStyle(
                              color: AppColor.color111111,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 限价单
          Obx(() {
            return SelectionButton.tips(
              height: 26.h,
              width: 195.w,
              text: controller.priceType.value.title.tr,
              onTap: () async {
                try {
                  int? res = await CommonBottomSheet.show(
                    titles:
                        StandPriceType.values.map((e) => e.title.tr).toList(),
                    selectedIndex: controller.priceType.value.index,
                  );
                  if (res != null) {
                    controller.setPriceType(StandPriceType.fromIndex(res));
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
            if (controller.priceType.value == StandPriceType.limit) {
              return SpotGoodsLimitPriceForm(
                priceTextController: controller.limitPriceTextController,
                amountTextController: controller.amountTextController,
                turnoverTextController: controller.limitTurnoverTextController,
                amountUnits: controller.coUnit.value,
                amountPercent: controller.amountPercent.value,
                priceFocusNode: controller.limitPriceFocusNode,
                amountFocusNode: controller.amountFocusNode,
                turnoverFocusNode: controller.limitTurnoverFocusNode,
                pricePrecision:
                    controller.marketInfoModel?.spotOrderRes?.pricePrecision ??
                        2,
                amountPrecision:
                    controller.marketInfoModel?.spotOrderRes?.volumePrecision ??
                        2,
                onValueChanged: (double value) {
                  controller.setAmountPercent(value);
                },
              );
            }
            String hint =
                '${LocaleKeys.trade174.tr}（${controller.marketInfoModel?.secondName.replaceAll('/', '') ?? ''}）';
            if (controller.switchState.value ==
                TransactionSwitchButtonValue.left) {
              hint =
                  '${LocaleKeys.trade174.tr}（${controller.marketInfoModel?.secondName.replaceAll('/', '') ?? ''}）';
            } else {
              hint =
                  '${LocaleKeys.trade27.tr}（${controller.marketInfoModel?.firstName}）';
            }
            return SpotGoodsMarketPriceForm(
              amountTextController: controller.amountTextController,
              amountUnits:
                  controller.marketInfoModel?.secondName.replaceAll('/', '') ??
                      '',
              focusNode: controller.amountFocusNode,
              amountPercent: controller.amountPercent.value,
              amountPrecision:
                  controller.marketInfoModel?.spotOrderRes?.pricePrecision ?? 2,
              hint: hint,
              onValueChanged: (double value) {
                controller.setAmountPercent(value);
              },
            );
          }),

          16.verticalSpace,
          Obx(() {
            var amount = '';
            var fee = '';
            if (controller.switchState.value ==
                TransactionSwitchButtonValue.left) {
              amount =
                  "${controller.canBuyAmount.value} ${controller.marketInfoModel?.firstName ?? ''}";
              fee =
                  '${controller.buyFee.value} ${controller.marketInfoModel?.firstName ?? ''}';
            } else {
              amount =
                  "${controller.canSellAmount.value} ${controller.marketInfoModel?.secondName.replaceAll('/', '') ?? ''}";
              fee =
                  '${controller.sellFee.value} ${controller.marketInfoModel?.secondName.replaceAll('/', '') ?? ''}';
            }
            return Column(
              children: [
                TitleAmountWidget(
                  title: controller.switchState.value ==
                          TransactionSwitchButtonValue.left
                      ? LocaleKeys.trade175.tr
                      : LocaleKeys.trade176.tr,
                  amount: amount,
                ),
                2.verticalSpace,
                TitleAmountWidget(
                  title: LocaleKeys.trade177.tr,
                  amount: fee,
                ),
                6.verticalSpace,
                TitleDetailButton(
                  title: controller.switchState.value ==
                          TransactionSwitchButtonValue.left
                      ? '${LocaleKeys.trade47.tr} ${SpotGoodsController.to.marketInfo.value?.firstName ?? 'BTC'}'
                      : '${LocaleKeys.trade48.tr} ${SpotGoodsController.to.marketInfo.value?.firstName ?? 'BTC'}',
                  bgColor: controller.switchState.value ==
                          TransactionSwitchButtonValue.left
                      ? AppColor.colorSuccess
                      : AppColor.colorDanger,
                  onTap: () {
                    controller.createOrder();
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
