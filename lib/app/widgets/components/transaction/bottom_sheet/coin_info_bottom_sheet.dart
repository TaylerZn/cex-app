import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/coin_24h_info_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../models/trade/trade_detail_info.dart';
import '../../../../modules/follow/follow_taker_info/widgets/follow_taker_draw.dart';
import '../../../../ws/contract_socket_manager.dart';
import '../../../../ws/core/model/ws_receive_data.dart';
import '../../../../ws/standard_socket_manager.dart';

class CoinInfoBottomSheet extends StatefulWidget {
  const CoinInfoBottomSheet(
      {super.key, required this.contractInfo, this.marketInfo, this.map});
  final ContractInfo? contractInfo;
  final MarketInfoModel? marketInfo;
  final Map<String, TradeDetailInfo>? map;

  static show(
      {ContractInfo? contractInfo,
      MarketInfoModel? marketInfo,
      Map<String, TradeDetailInfo>? map}) {
    showBSheet(
      CoinInfoBottomSheet(
        contractInfo: contractInfo,
        marketInfo: marketInfo,
        map: map,
      ),
    );
  }

  @override
  State<CoinInfoBottomSheet> createState() => _CoinInfoBottomSheetState();
}

class _CoinInfoBottomSheetState extends State<CoinInfoBottomSheet> {
  Map<String, TradeDetailInfo> map = {};

  @override
  void initState() {
    map = widget.map ?? {};
    super.initState();
    if (widget.contractInfo?.subSymbol == null) return;
    if (widget.contractInfo?.contractType == 'E') {
      ContractSocketManager.instance
          .subTradeDetail(widget.contractInfo!.subSymbol, (symbol, data) {
        _handleData(data);
      });
    } else {
      StandardSocketManager.instance.reqTradeDetail(widget.contractInfo!.subSymbol, (symbol, data) {
        _handleData(data);
      });
      StandardSocketManager.instance
          .subTradeDetail(widget.contractInfo!.subSymbol, (symbol, data) {
        _handleData(data);
      });
    }
  }

  _handleData(WSReceiveData receiveData) {
    try {
      Map<String, dynamic> targetData = receiveData.data;
      targetData.forEach((key, value) {
        map[key] = TradeDetailInfo.fromJson(value);
      });
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      Get.log('data ${e.toString()}');
    }
  }

  @override
  void dispose() {
    if (widget.contractInfo?.contractType == 'E') {
      ContractSocketManager.instance
          .unSubDepthTrade(widget.contractInfo!.subSymbol);
    } else {
      StandardSocketManager.instance
          .unSubDepthTrade(widget.contractInfo!.subSymbol);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50.w,
                height: 4.h,
                margin: EdgeInsets.only(top: 8.h, bottom: 12.h),
                decoration: BoxDecoration(
                  color: AppColor.colorBackgroundDisabled,
                  borderRadius: BorderRadius.circular(2.h),
                ),
              ),
            ),
            Text(
              '${widget.contractInfo?.symbol}${LocaleKeys.trade374.tr}',
              style: AppTextStyle.f_18_600.colorBlack,
            ),
          ],
        ).marginSymmetric(horizontal: 16.w),
        16.verticalSpace,
        Divider(
          height: 1 / Get.pixelRatio,
          color: AppColor.colorBorderGutter,
        ),
        16.verticalSpace,
        Column(
          children: [
            Coin24HInfoWidget(contractInfo: widget.contractInfo),
            16.verticalSpace,
            DayInfoContainWidget(
              map: map,
            ),
            LowHighWidget(
              map: map,
              precision: widget.contractInfo?.coinResultVo?.symbolPricePrecision
                      .toInt() ??
                  2,
            ),
          ],
        ).marginSymmetric(horizontal: 16.w),
      ],
    );
  }
}

class DayInfoContainWidget extends StatelessWidget {
  const DayInfoContainWidget({super.key, required this.map});
  final Map<String, TradeDetailInfo> map;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.w,
        crossAxisSpacing: 8.w,
        childAspectRatio: 108 / 40,
      ),
      shrinkWrap: true,
      children: [
        _item(
          LocaleKeys.trade368.tr,
          map['1d']?.rose?.toDecimal(),
        ),
        _item(
          LocaleKeys.trade369.tr,
          map['7d']?.rose?.toDecimal(),
        ),
        _item(
          LocaleKeys.trade370.tr,
          map['30d']?.rose?.toDecimal(),
        ),
        _item(
          LocaleKeys.trade371.tr,
          map['90d']?.rose?.toDecimal(),
        ),
        _item(
          LocaleKeys.trade372.tr,
          map['180d']?.rose?.toDecimal(),
        ),
        _item(
          LocaleKeys.trade373.tr,
          map['1y']?.rose?.toDecimal(),
        ),
      ],
    );
  }

  Widget _item(String title, Decimal? rate) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.colorBackgroundSecondary,
        borderRadius: BorderRadius.circular(6.r),
      ),
      alignment: Alignment.center,
      width: 180.w,
      height: 40.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyle.f_11_400.colorTips,
          ),
          1.verticalSpace,
          Text(
            rate != null
                ? '${(rate * 100.toDecimal()).toString().toPrecision(2)}%'
                : '--',
            style: AppTextStyle.f_12_500.copyWith(
              color: (rate ?? Decimal.zero) > Decimal.zero
                  ? AppColor.colorFunctionBuy
                  : AppColor.colorFunctionSell,
            ),
          ),
        ],
      ),
    );
  }
}

class LowHighWidget extends StatelessWidget {
  const LowHighWidget({super.key, required this.map, required this.precision});
  final Map<String, TradeDetailInfo> map;
  final int precision;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.trade375.tr,
              style: AppTextStyle.f_12_400.colorTextDescription,
            ),
            Text(
              LocaleKeys.trade376.tr,
              style: AppTextStyle.f_12_400.colorTextDescription,
            ),
          ],
        ),
        20.verticalSpace,
        ListView(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            _item(
              LocaleKeys.trade377.tr,
              map['1h']?.low.toString().toPrecision(precision) ?? '--',
              map['1h']?.high.toString().toPrecision(precision) ?? '--',
              map['1h']?.scale?.toDouble() ?? 0,
            ),
            _item(
              LocaleKeys.trade378.tr,
              map['1d']?.low.toString().toPrecision(precision) ?? '--',
              map['1d']?.high.toString().toPrecision(precision) ?? '--',
              map['1d']?.scale?.toDouble() ?? 0,
            ),
            _item(
              LocaleKeys.trade379.tr,
              map['30d']?.low.toString().toPrecision(precision) ?? '--',
              map['30d']?.high.toString().toPrecision(precision) ?? '--',
              map['30d']?.scale?.toDouble() ?? 0,
            ),
            _item(
              LocaleKeys.trade380.tr,
              map['1y']?.low.toString().toPrecision(precision) ?? '--',
              map['1y']?.high.toString().toPrecision(precision) ?? '--',
              map['1y']?.scale?.toDouble() ?? 0,
            ),
            _item(
              LocaleKeys.trade381.tr,
              map['all']?.low.toString().toPrecision(precision) ?? '--',
              map['all']?.high.toString().toPrecision(precision) ?? '--',
              map['all']?.scale?.toDouble() ?? 0,
            ),
          ],
        ),
      ],
    );
  }

  Widget _item(String title, String lowPrice, String hightPrice, num rate) {
    int left = max((rate * 100).toInt(), 5);
    int right = 100 - left;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FollowTakerDrawProgress(
          left: left,
          right: right,
          leftColor: AppColor.colorTextBrand,
          rightColor: AppColor.colorBackgroundTertiary,
        ),
        4.verticalSpace,
        Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                lowPrice,
                style: AppTextStyle.f_11_400.colorTextPrimary,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: AppTextStyle.f_11_400.colorTextDescription,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                hightPrice,
                style: AppTextStyle.f_11_400.colorTextPrimary,
              ),
            ),
          ],
        ),
        20.verticalSpace,
      ],
    );
  }
}
