import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/cancel_config_bottom_button.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_slider_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/title_input_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/title_selected_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../api/contract/contract_api.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../models/contract/req/create_order_req.dart';
import '../../../../models/contract/res/position_res.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../modules/transation/contract_entrust/controllers/contract_entrust_controller.dart';
import '../../../../utils/utilities/ui_util.dart';
import 'bottom_sheet_util.dart';

class ClosePositionBottomSheet extends StatefulWidget {
  const ClosePositionBottomSheet({
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
      ClosePositionBottomSheet(
        positionInfo: positionInfo,
        contractInfo: contractInfo,
      ),
    );
  }

  @override
  State<ClosePositionBottomSheet> createState() =>
      _ClosePositionBottomSheetState();
}

enum ClosePositionType {
  MARKET(2),
  LIMIT(1);

  final int type;

  const ClosePositionType(this.type);

  static ClosePositionType fromInt(int type) {
    return ClosePositionType.values
        .firstWhere((element) => element.type == type);
  }
}

class _ClosePositionBottomSheetState extends State<ClosePositionBottomSheet> {
  final TextEditingController _priceController = TextEditingController();
  final FocusNode priceFocusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();
  ClosePositionType positionType = ClosePositionType.MARKET; // 1市价 2限价
  double count = 1;

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

    _priceController.addListener(() {
      if (_priceController.text.isNotEmpty) {
        _calculateProfit(_priceController.text);
      }
    });

    _calculateProfit(widget.positionInfo.indexPrice.toString());

    rate = ((profit.toNum() / widget.positionInfo.holdAmount.toDouble()) * 100)
        .toString()
        .toPrecision(4);

    /// 默认100%
    count = 1;
    _amountController.text =
        '100% ≈ ${(widget.positionInfo.canCloseVolume.toDecimal() * widget.contractInfo.multiplier.toDecimal() * (count).toDecimal()).toString()}';
  }

  _calculateProfit(String price) {

    // 未实现盈亏
    // 多仓（BUY）：未实现盈亏 = 持仓数量*面值*汇率 * （当前标记价格-开仓均价）
    // 空仓（SELL）：未实现盈亏 = 持仓数量*面值*汇率 *（开仓均价-当前标记价格）
    // 回报率 = 未实现盈亏 / 保证金 * 100 (*100 是因为有%)
    int precision = 2;
    if (widget.positionInfo.orderSide == "BUY") {
      profit = (widget.positionInfo.canCloseVolume.toDecimal() *
          (widget.contractInfo.multiplier).toDecimal() *
          (price.toDecimal() -
              widget.positionInfo.openAvgPrice.toDecimal()))
          .toStringAsFixed(precision);
    } else {
      profit = (widget.positionInfo.canCloseVolume.toDecimal() *
          (widget.contractInfo.multiplier).toDecimal() *
          (widget.positionInfo.openAvgPrice.toDecimal() -
              price.toDecimal()))
          .toStringAsFixed(precision);
    }

    rate = ((profit.toNum() / widget.positionInfo.holdAmount.toDouble()) * 100)
        .toString()
        .toPrecision(4);
    setState(() {

    });
  }


  @override
  void dispose() {
    _priceController.dispose();
    priceFocusNode.dispose();
    _amountController.dispose();
    amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
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
                      '${widget.positionInfo.symbol.symbolFirst()} ${widget.contractInfo.getContractType} / ${widget.positionInfo.orderSide == 'SELL' ? LocaleKeys.trade48.tr : LocaleKeys.trade47.tr}${widget.positionInfo.leverageLevel}x',
                      widget.positionInfo.orderSide == 'SELL'
                          ? AppColor.colorDanger
                          : AppColor.upColor,
                    ),
                    10.verticalSpace,
                    _buildTitleDesc(
                      "${LocaleKeys.trade166.tr}（USDT）",
                      widget.positionInfo.openAvgPrice.formatComma(4),
                    ),
                    10.verticalSpace,
                    _buildTitleDesc(
                      "${LocaleKeys.trade110.tr}（USDT）",
                      widget.positionInfo.indexPrice.formatComma(4),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TitleInputWidget(
                    textEditingController: _priceController,
                    title: LocaleKeys.trade34.tr,
                    hintText: positionType == ClosePositionType.MARKET
                        ? LocaleKeys.trade28.tr
                        : LocaleKeys.trade44.tr,
                    enable: positionType == ClosePositionType.LIMIT,
                    width: 186.w,
                    precision: widget
                        .contractInfo.coinResultVo?.symbolPricePrecision
                        .toInt(),
                    suffixWidget: Text(
                      'USDT',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColor.color666666,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ).marginOnly(right: 12.w),
                    focusNode: priceFocusNode,
                  ),
                  10.horizontalSpace,
                  CustomPopup(
                    contentPadding: EdgeInsets.zero,
                    showArrow: false,
                    barrierColor: Colors.transparent,
                    content: Container(
                      width: 145.w,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [LocaleKeys.trade28.tr, LocaleKeys.trade44.tr]
                            .asMap()
                            .entries
                            .map(
                              (e) => _buildItem(
                                  e.value, 2 - e.key == positionType.type, () {
                                setState(() {
                                  positionType =
                                      ClosePositionType.fromInt(2 - e.key);
                                });
                                Get.back();
                              }),
                            )
                            .toList(),
                      ),
                    ),
                    child: TitleSelectedWidget(
                      title: LocaleKeys.trade53.tr,
                      width: 147.w,
                      value: positionType == ClosePositionType.MARKET
                          ? LocaleKeys.trade74.tr
                          : LocaleKeys.trade73.tr,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              TitleInputWidget(
                focusNode: amountFocusNode,
                textEditingController: _amountController,
                title: LocaleKeys.trade27.tr,
                hintText: LocaleKeys.trade65.tr,
                precision: widget.contractInfo.multiplier.numDecimalPlaces(),
                enable: true,
                suffixWidget: Text(
                  // widget.positionInfo.symbol.symbolFirst(),
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
                  '${widget.positionInfo.canCloseVolume.toDecimal() * widget.contractInfo.multiplier.toDecimal()} ${widget.positionInfo.symbol.symbolFirst()}'),
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
    if (positionType == ClosePositionType.LIMIT) {
      price = _priceController.text.trim();
      if (price.isEmpty) {
        priceFocusNode.requestFocus();
        return;
      }
    }
    String amount = _amountController.text.trim();
    if (amount.isEmpty) {
      amountFocusNode.requestFocus();
      return;
    }

    if (amount.contains('%')) {
      amount = (widget.positionInfo.canCloseVolume * count).toInt().toString();
    } else {
      amount = (amount.toDecimal() / widget.contractInfo.multiplier.toDecimal())
          .toBigInt()
          .toString();
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
        type: positionType.type,
        isConditionOrder: false,
      );
      await ContractApi.instance().createOrder(req);
      ContractEntrustController.to.fetchData();
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
          style: AppTextStyle.f_13_400.color666666,
        ),
        Text(
          desc,
          textAlign: TextAlign.right,
          style: color != null
              ? AppTextStyle.f_13_300.copyWith(color: color)
              : AppTextStyle.f_13_500.color111111,
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
