import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/models/contract_type.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/close_position_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/cancel_config_bottom_button.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_slider_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/title_input_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/title_selected_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../api/contract/contract_api.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../models/contract/req/create_order_req.dart';
import '../../../../models/contract/res/position_res.dart';
import '../../../../modules/transation/contract_entrust/controllers/contract_entrust_controller.dart';
import 'bottom_sheet_util.dart';

class ProfitLoseBottomSheet extends StatefulWidget {
  const ProfitLoseBottomSheet(
      {super.key, required this.positionInfo, required this.contractInfo});

  final PositionInfo positionInfo;
  final ContractInfo contractInfo;

  static show(
      {required PositionInfo positionInfo,
      required ContractInfo contractInfo,
      required ContractType contractType}) {
    showBSheet(ProfitLoseBottomSheet(
      positionInfo: positionInfo,
      contractInfo: contractInfo,
    ));
  }

  @override
  State<ProfitLoseBottomSheet> createState() => _ProfitLoseBottomSheetState();
}

class _ProfitLoseBottomSheetState extends State<ProfitLoseBottomSheet> {
  // 价格
  final TextEditingController _priceController = TextEditingController();
  final FocusNode _priceFocusNode = FocusNode();

  // 数量
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();

  // 触发价格
  final TextEditingController _tigerPriceController = TextEditingController();
  final FocusNode _tigerPriceFocusNode = FocusNode();
  double count = 0;
  ClosePositionType positionType = ClosePositionType.MARKET; //
  // 未实现盈亏
  String profit = '0.00';

  // 回报率
  String rate = '0.00%';

  @override
  void initState() {
    super.initState();
    _amountFocusNode.addListener(() {
      if (_amountFocusNode.hasFocus) {
        setState(() {
          count = 0;
        });
      }
    });

    _priceController.addListener(() {
      if (_priceController.text.isEmpty) {
        profit = '--';
      } else {
        _calculateProfit();
      }
    });

    _tigerPriceController.addListener(() {
      if (_tigerPriceController.text.isEmpty) {
        profit = '--';
      } else {
        _calculateProfit();
      }
    });

    _amountController.addListener(() {
      if (_amountController.text.isEmpty) {
        profit = '--';
      } else {
        _calculateProfit();
      }
    });
    count = 1;
    _amountController.text =
    '100% ≈ ${(widget.positionInfo.canCloseVolume.toDecimal() * widget.contractInfo.multiplier.toDecimal() * (count).toDecimal()).toString()}';
  }

  //
  _calculateProfit() {
    String reducePrice = '';
    // 限价止盈止损，平仓价格 = 委托价格
    // 市价止盈止损，平仓价格 = 触发价格
    // 市价
    if (positionType == ClosePositionType.MARKET) {
      reducePrice = _tigerPriceController.text.trim();
    } else {
      reducePrice = _priceController.text.trim();
      if (reducePrice.isEmpty) {
        return;
      }
    }

    if (reducePrice.isEmpty) {
      return;
    }

    String amount = _amountController.text.trim();
    if (count != 0) {
      amount = (widget.positionInfo.canCloseVolume.toDecimal() *
              widget.contractInfo.multiplier.toDecimal() *
              count.toDecimal())
          .toString();
    }
    // 未实现现盈亏
    // 多仓（BUY）： 未实现盈亏 = （平仓价格 - 开仓均价） * 数量 / 保证金汇率
    // 空仓（SELL）： 未实现盈亏 = （开仓均价 - 平仓价格） * 数量 / 保证金汇率
    if (widget.positionInfo.orderSide == 'BUY') {
      profit = ((reducePrice.toDecimal() -
                  widget.positionInfo.openAvgPrice.toDecimal()) *
              amount.toDecimal() /
              widget.contractInfo.marginRate.toDecimal())
          .toDecimal(scaleOnInfinitePrecision: 8)
          .toStringAsFixed(2);
    } else {
      profit = ((widget.positionInfo.openAvgPrice.toDecimal() -
                  reducePrice.toDecimal()) *
              amount.toDecimal() /
              widget.contractInfo.marginRate.toDecimal())
          .toDecimal(scaleOnInfinitePrecision: 8)
          .toStringAsFixed(2);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _priceController.dispose();
    _priceFocusNode.dispose();
    _amountController.dispose();
    _amountFocusNode.dispose();
    _tigerPriceController.dispose();
    _tigerPriceFocusNode.dispose();
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
                LocaleKeys.trade211.tr,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TitleInputWidget(
                      textEditingController: _tigerPriceController,
                      title: LocaleKeys.trade100.tr,
                      hintText: LocaleKeys.trade34.tr,
                      precision: widget
                              .contractInfo.coinResultVo?.symbolPricePrecision
                              .toInt() ??
                          4,
                      focusNode: _tigerPriceFocusNode,
                      width: 186.w),
                  10.horizontalSpace,
                  TitleSelectedWidget(
                    title: LocaleKeys.trade160.tr,
                    width: 147.w,
                    value: LocaleKeys.trade110.tr,
                    canPop: false,
                  ),
                ],
              ),
              16.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TitleInputWidget(
                    textEditingController: _priceController,
                    title: LocaleKeys.trade34.tr,
                    precision: widget
                            .contractInfo.coinResultVo?.symbolPricePrecision
                            .toInt() ??
                        4,
                    focusNode: _priceFocusNode,
                    hintText: positionType == ClosePositionType.MARKET
                        ? LocaleKeys.trade74.tr
                        : LocaleKeys.trade73.tr,
                    enable: positionType == ClosePositionType.LIMIT,
                    width: 186.w,
                    suffixWidget: Text(
                      'USDT',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColor.color666666,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ).marginOnly(right: 12.w),
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
                        children: [LocaleKeys.trade74.tr, LocaleKeys.trade73.tr]
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
                textEditingController: _amountController,
                title: LocaleKeys.trade27.tr,
                precision: widget.contractInfo.multiplier.numDecimalPlaces(),
                focusNode: _amountFocusNode,
                hintText: LocaleKeys.trade65.tr,
                suffixWidget: Text(
                  widget.positionInfo.symbol.symbolFirst(),
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
                  LocaleKeys.trade213.tr,
                  '$profit USDT',
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
    // 触发价
    String triggerPrice = _tigerPriceController.text.trim();
    if (triggerPrice.isEmpty) {
      _tigerPriceFocusNode.requestFocus();
      return;
    }
    // 委托价
    var price = '0';
    if (positionType == ClosePositionType.LIMIT) {
      price = _priceController.text.trim();
      if (price.isEmpty) {
        _priceFocusNode.requestFocus();
        return;
      }
    }
    String amount = _amountController.text.trim();
    if (amount.isEmpty) {
      _amountFocusNode.requestFocus();
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
        isConditionOrder: true,
        expireTime: null,
        triggerPrice: triggerPrice,
      );
      final res = await ContractApi.instance().createOrder(req);
      ContractEntrustController.to.fetchData();
      UIUtil.showSuccess(LocaleKeys.trade214.tr);
      Get.back();
    } catch (e) {
      UIUtil.showError(LocaleKeys.trade215.tr);
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
