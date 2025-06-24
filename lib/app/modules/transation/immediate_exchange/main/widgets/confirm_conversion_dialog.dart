import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../api/assets/assets_api.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../models/trade/convert_currencies_model.dart';
import '../../../../../models/trade/convert_quick_quote_rate.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/utilities/number_util.dart';
import '../../../../../utils/utilities/ui_util.dart';
import '../../../../../widgets/basic/my_image.dart';
import '../controllers/immediate_exchange_controller.dart';

class ConfirmConversionDialog extends StatefulWidget {
  final CoinModel fromCoinModel;
  final CoinModel toCoinModel;

  /// 数量
  final num from;
  final num to;

  /// 数量
  final ConvertQuickQuoteRate convertQuickQuoteRate;

  final bool isChange;

  const ConfirmConversionDialog(
      {super.key,
      required this.fromCoinModel,
      required this.toCoinModel,
      required this.from,
      required this.to,
      required this.convertQuickQuoteRate,
      required this.isChange});

  @override
  State<ConfirmConversionDialog> createState() =>
      _ConfirmConversionDialogState();
}

class _ConfirmConversionDialogState extends State<ConfirmConversionDialog> {
  Rxn<ConvertQuickQuoteRate> convertQuickQuoteRate = Rxn();
  final controller = Get.find<ImmediateExchangeController>();
  Rxn<num> to = Rxn();

  Timer? timer;

  Rx<num> isRefresh = 5.obs;
  RxInt tic = 8.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convertQuickQuoteRate.value = widget.convertQuickQuoteRate;
    to.value = widget.isChange ? widget.from : widget.to;
    autoRefresh();
  }

  void autoRefresh({int isRefreshT = 5}) {
    tic.value = 8;
    isRefresh.value = isRefreshT;
    quickQuote();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    quickQuote();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      tic--;
      if (tic.value <= 0) {
        isRefresh.value--;
        quickQuote();
        if (isRefresh.value == -1) {
          timer.cancel();
        } else {
          tic.value = 8;
        }
      }
    });
  }

  void quickQuote() async {
    var res;
    try {
      res = await AssetsApi.instance().getQuickQuote(
          '${widget.toCoinModel.symbol}', '${widget.fromCoinModel.symbol}');
    } catch (e) {
      return;
    }
    convertQuickQuoteRate.value = res;
    if (widget.isChange) {
      try {
        var text = NumberUtil.mConvert(
            num.parse(convertQuickQuoteRate.value!.buyPrice!) * widget.to,
            count: widget.fromCoinModel.precision,
            isTruncate: true);
        to.value = num.parse(text.replaceAll(RegExp('[^0-9.]'), ''));
      } catch (e) {}
    } else {
      try {
        var text = NumberUtil.mConvert(
            '${widget.from / num.parse(convertQuickQuoteRate.value!.sellPrice!)}',
            count: widget.toCoinModel.precision,
            isTruncate: true);
        to.value = num.parse(text.replaceAll(RegExp('[^0-9.]'), ''));
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
      decoration: BoxDecoration(
          color: AppColor.bgColorLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w),
            topRight: Radius.circular(20.w),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                LocaleKeys.trade302.tr, //确认兑换
                style: AppTextStyle.f_20_600.color111111,
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(20.0), // Adjust the padding as needed
                  child: MyImage(
                    'assets/images/default/close.svg',
                    width: 23.w,
                    height: 15.h,
                  ),
                ),
              )
            ],
          ),
          20.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    MyImage(
                      '${widget.isChange ? widget.toCoinModel.icon : widget.fromCoinModel.icon}',
                      width: 32.w,
                      height: 32.w,
                    ),
                    4.verticalSpace,
                    Text(
                      LocaleKeys.trade291.tr, // '消耗',
                      style: AppTextStyle.f_12_400.color999999,
                    ),
                    4.verticalSpace,
                    Text(
                      '${widget.isChange ? Decimal.parse('${widget.to}') : Decimal.parse('${widget.from}')} ${widget.isChange ? widget.toCoinModel.symbol : widget.fromCoinModel.symbol}',
                      style: AppTextStyle.f_14_500.color111111,
                    ),
                  ],
                ),
              ),
              MyImage(
                'assets/images/default/icon_to.svg',
                width: 18.w,
                height: 18.w,
              ),
              Expanded(
                child: Column(
                  children: [
                    MyImage(
                      '${widget.isChange ? widget.fromCoinModel.icon : widget.toCoinModel.icon}',
                      width: 32.w,
                      height: 32.w,
                    ),
                    4.verticalSpace,
                    Text(
                      LocaleKeys.trade292.tr, //'获得',
                      style: AppTextStyle.f_12_400.color999999,
                    ),
                    4.verticalSpace,
                    Obx(() {
                      return Text(
                        '${Decimal.parse('${to.value}')} ${widget.isChange ? widget.fromCoinModel.symbol : widget.toCoinModel.symbol}',
                        style: AppTextStyle.f_14_500.color111111,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          buildRow(
              title: LocaleKeys.trade303.tr, //'类型',
              value: LocaleKeys.trade304.tr // 市价
              ),
          12.verticalSpace,
          buildRow(
              title: LocaleKeys.trade305.tr, //支付渠道
              value: LocaleKeys.trade306.tr // 现货账户
              ),
          12.verticalSpace,
          buildRow(
              title: LocaleKeys.trade307.tr, //交易手续费
              value: LocaleKeys.trade293.tr // 0手续费
              ),
          12.verticalSpace,
          if (widget.isChange == false)
            buildRow(
                title: LocaleKeys.trade308.tr, //兑换率
                value:
                    '1 ${widget.fromCoinModel.symbol} ≈ ${NumberUtil.mConvert('${1 / num.parse(convertQuickQuoteRate.value!.sellPrice!)}', count: widget.toCoinModel!.precision, isTruncate: true)} ${widget.toCoinModel.symbol}'),
          if (widget.isChange)
            buildRow(
                title: LocaleKeys.trade308.tr, //兑换率
                value:
                    '1 ${widget.toCoinModel.symbol} ≈ ${convertQuickQuoteRate.value!.buyPrice} ${widget.fromCoinModel.symbol}'),
          Obx(() {
            if (isRefresh.value > -1) {
              return Container();
            }
            return Container(
              height: 44.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.w),
                  color: AppColor.colorF5F5F5),
              child: Row(
                children: [
                  10.horizontalSpace,
                  MyImage(
                    'assets/images/default/icon_warm_toast.svg',
                    width: 16.w,
                    height: 16.w,
                  ),
                  8.horizontalSpace,
                  Text(
                    LocaleKeys.trade310.tr, //'该报价已过期，请重新获取报价',
                    style: AppTextStyle.f_12_500.color666666,
                  )
                ],
              ),
            );
          }).marginOnly(top: 24.w),
          35.verticalSpace,
          GestureDetector(
            onTap: () async {
              if (isRefresh.value > -1) {
                createOrder();
              } else {
                autoRefresh(isRefreshT: 0);
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 48.w,
              decoration: BoxDecoration(
                  color: AppColor.bgColorDark,
                  borderRadius: BorderRadius.circular(48.w)),
              alignment: Alignment.center,
              child: Obx(() {
                return Text(
                  isRefresh.value < 0
                      ? LocaleKeys.trade326.tr //'刷新'
                      : tic.value == 0
                          ? LocaleKeys.trade311.tr // 兑换
                          : '${LocaleKeys.trade309.trArgs([
                                  '${tic.value}s'
                                ])}', //'兑换(${tic.value}s)',
                  style: AppTextStyle.f_16_600.colorFFFFFF,
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Row buildRow({String? title, String? value}) {
    return Row(
      children: [
        Text(
          '$title',
          style: AppTextStyle.f_13_400.color666666,
        ),
        Spacer(),
        Text(
          '$value',
          style: AppTextStyle.f_13_500.color111111,
        ),
      ],
    );
  }

  void createOrder() async {
    try {
      var res = await AssetsApi.instance().quickCreateOrder(
        '${widget.toCoinModel.symbol}',
        '${widget.fromCoinModel.symbol}',
        baseAmount: widget.isChange ? '${widget.to}' : null,
        quoteAmount: widget.isChange ? null : '${widget.from}',
      );
      if (res != null) {
        Get.back();
        await Get.toNamed(
          Routes.IMMEDIATE_EXCHANGE_DETAIL,
          arguments: res,
        );
        controller.fromEditingController.clear();
        controller.toEditingController.clear();
        controller.fromError.value = false;
        controller.toError.value = false;
        controller.balanceError.value = false;
      } else {
        UIUtil.showToast('Conversion failure');
      }
    } on DioException catch (e) {
      UIUtil.showToast(e.error.toString());
    }
  }
}
