import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/cancel_config_bottom_button.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_slider_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/title_input_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../api/commodity/commodity_api.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../models/contract/req/create_order_req.dart';
import '../../../../models/contract/res/position_res.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../modules/transation/commodiy_entrust/controllers/commondiy_entrust_controller.dart';
import '../../../../utils/utilities/ui_util.dart';
import 'bottom_sheet_util.dart';
import 'close_position_bottom_sheet.dart';

class CommodityClosePositionBottomSheet extends StatefulWidget {
  const CommodityClosePositionBottomSheet({
    super.key,
    required this.positionInfo,
    required this.contractInfo,
  });

  final PositionInfo positionInfo;
  final ContractInfo contractInfo;

  static show(
      {required PositionInfo positionInfo,
      required ContractInfo contractInfo}) {
    showBSheet(
      CommodityClosePositionBottomSheet(
        positionInfo: positionInfo,
        contractInfo: contractInfo,
      ),
    );
  }

  @override
  State<CommodityClosePositionBottomSheet> createState() =>
      _CommodityClosePositionBottomSheetState();
}

class _CommodityClosePositionBottomSheetState
    extends State<CommodityClosePositionBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();
  double count = 0;
  // 未实现盈亏
  String profit = '0.00';

  // 回报率
  String rate = '0.00%';

  @override
  void initState() {
    super.initState();
    amountFocusNode.addListener(() {
      if (amountFocusNode.hasFocus) {
        setState(() {
          count = 0;
        });
      }
    });

    // 未实现盈亏
    // 多仓（BUY）：未实现盈亏 = 持仓数量*面值*汇率 * （当前标记价格-开仓均价）
    // 空仓（SELL）：未实现盈亏 = 持仓数量*面值*汇率 *（开仓均价-当前标记价格）
    // 回报率 = 未实现盈亏 / 保证金 * 100 (*100 是因为有%)
    int precision = 2;
    if (widget.positionInfo.orderSide == "BUY") {
      profit = (widget.positionInfo.canCloseVolume.toDecimal() *
              (widget.contractInfo.multiplier).toDecimal() *
              (widget.positionInfo.indexPrice.toDecimal() -
                  widget.positionInfo.openAvgPrice.toDecimal()))
          .toStringAsFixed(2);
    } else {
      profit = (widget.positionInfo.canCloseVolume.toDecimal() *
              (widget.contractInfo.multiplier).toDecimal() *
              (widget.positionInfo.openAvgPrice.toDecimal() -
                  widget.positionInfo.indexPrice.toDecimal()))
          .toStringAsFixed(2);
    }

    try {
      rate =
          ((profit.toNum() / widget.positionInfo.holdAmount.toDouble()) * 100)
              .toString()
              .toPrecision(4);
    } catch (e) {}
    count = 1;
    _amountController.text =
    '100% ≈ ${(widget.positionInfo.canCloseVolume.toDecimal() * widget.contractInfo.multiplier.toDecimal() * (count).toDecimal()).toString()}';
  }

  @override
  void dispose() {
    _amountController.dispose();
    amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.only(
          bottom: max(
              MediaQuery.of(context).viewInsets.bottom -
                  80.h -
                  Get.mediaQuery.padding.bottom -
                  120.h,
              0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.verticalSpace,
                Text(
                  LocaleKeys.trade19.tr,
                  style: TextStyle(
                    color: AppColor.color111111,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.verticalSpace,
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: ShapeDecoration(
                    color: AppColor.colorF4F4F4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildTitleDesc(
                        LocaleKeys.trade2.tr,
                        '${widget.contractInfo.firstName} ${widget.contractInfo.getContractType} / ${widget.positionInfo.orderSide == 'SELL' ? LocaleKeys.trade48.tr : LocaleKeys.trade47.tr}${widget.positionInfo.leverageLevel}x',
                        widget.positionInfo.orderSide == 'SELL'
                            ? AppColor.colorDanger
                            : AppColor.upColor,
                      ),
                      10.verticalSpace,
                      _buildTitleDesc(
                        "${LocaleKeys.trade166.tr}（USDT）",
                        widget.positionInfo.openAvgPrice.toPrecision(widget
                                .contractInfo.coinResultVo?.symbolPricePrecision
                                .toInt() ??
                            2),
                      ),
                      10.verticalSpace,
                      _buildTitleDesc(
                        "${LocaleKeys.trade110.tr}（USDT）",
                        widget.positionInfo.indexPrice.toPrecision(widget
                                .contractInfo.coinResultVo?.symbolPricePrecision
                                .toInt() ??
                            2),
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                Text(
                  LocaleKeys.trade34.tr,
                  style: AppTextStyle.f_12_400.color4D4D4D,
                ),
                8.verticalSpace,
                Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: AppColor.colorD9D9D9,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.trade28.tr,
                    style: AppTextStyle.f_16_500.copyWith(
                      color: AppColor.colorABABAB,
                    ),
                  ),
                ),
                8.verticalSpace,
                TitleInputWidget(
                  focusNode: amountFocusNode,
                  textEditingController: _amountController,
                  title: LocaleKeys.trade27.tr,
                  hintText: LocaleKeys.trade65.tr,
                  precision: widget.contractInfo.multiplier.numDecimalPlaces(),
                  enable: true,
                  suffixWidget: Text(
                    widget.contractInfo.firstName,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColor.color666666,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ).marginOnly(right: 12.w),
                ),
                16.verticalSpace,
                MyPercentSliderWidget(
                  value: count,
                  onChanged: (value) {
                    setState(() {
                      int precent = (value * 100).toInt();
                      count = precent / 100;
                      Get.log('count: $count');
                      if (count == 0) {
                        _amountController.clear();
                      } else {
                        _amountController.text =
                            '$precent% ≈ ${(widget.positionInfo.canCloseVolume.toDecimal() * widget.contractInfo.multiplier.toDecimal() * (count).toDecimal()).toString()}';
                      }
                    });
                  },
                ),
                30.verticalSpace,
                _buildTitleDesc1(LocaleKeys.trade212.tr,
                    '${(widget.positionInfo.canCloseVolume.toDecimal() * widget.contractInfo.multiplier.toDecimal()).toPrecision(widget.contractInfo.multiplier.numDecimalPlaces())} ${widget.contractInfo.firstName}'),
                15.verticalSpace,
                _buildTitleDesc1(
                    '${LocaleKeys.trade105.tr} (${LocaleKeys.trade106.tr})',
                    '$profit ($rate%)',
                    profit.toDecimal() > Decimal.zero
                        ? AppColor.upColor
                        : AppColor.downColor),
                23.verticalSpace,
              ],
            ).marginSymmetric(horizontal: 16.w),
            Divider(
              height: 1.h,
              color: AppColor.colorF5F5F5,
            ),
            16.verticalSpace,
            CancelConfirmBottomButton(onCancel: () {
              Get.back();
            }, onConfirm: () {
              _createOrder();
            }).marginSymmetric(horizontal: 16.w),
            16.verticalSpace,
          ],
        ),
    );
  }

  _createOrder() async {
    // 委托价
    var price = '';
    String amount = _amountController.text.trim();
    if (amount.isEmpty) {
      amount = widget.positionInfo.canCloseVolume.toInt().toString();
    } else {
      if (amount.contains('%')) {
        amount =
            (widget.positionInfo.canCloseVolume * count).toInt().toString();
      } else {
        amount = (amount.toNum() / widget.contractInfo.multiplier).toString();
      }
    }

    try {
      CreateOrderReq req = CreateOrderReq(
        contractId: widget.positionInfo.contractId,
        positionType: widget.positionInfo.positionType.toInt(),
        side: widget.positionInfo.orderSide == 'SELL' ? 'BUY' : 'SELL',
        leverageLevel: widget.positionInfo.leverageLevel.toInt(),
        price: price,
        volume: amount.toInt(),
        open: 'CLOSE',
        type: ClosePositionType.MARKET.type,
        isConditionOrder: false,
      );
      await CommodityApi.instance().createOrder(req);
      CommodityEntrustController.to.fetchData();
      UIUtil.showSuccess('${LocaleKeys.trade19.tr}${LocaleKeys.public12.tr}');
      Get.back();
    } on DioException catch (e) {
      UIUtil.showError(e.error);
    } catch (e) {
      UIUtil.showError('${LocaleKeys.trade19.tr}${LocaleKeys.public13.tr}');
    }
  }

  _buildTitleDesc1(String title, String desc, [Color? color]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.color666666,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          desc,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: color ?? AppColor.color111111,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  _buildTitleDesc(String title, String desc, [Color? color]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.color999999,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          desc,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: color ?? AppColor.color111111,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget _buildItem(String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 40.h,
        child: Text(
          title,
          style: isSelected
              ? AppTextStyle.f_13_500.color111111
              : AppTextStyle.f_13_500.color999999,
        ),
      ),
    );
  }
}
