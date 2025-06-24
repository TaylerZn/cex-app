import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/history_trade_info.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class TradeHistoryItem extends StatelessWidget {
  const TradeHistoryItem(
      {super.key,
      required this.historyTradeInfo,
      required this.amountPrecision,
      required this.pricePrecision});

  final HistoryTradeInfo? historyTradeInfo;
  final int amountPrecision;
  final int pricePrecision;

  @override
  Widget build(BuildContext context) {
    String time = historyTradeInfo?.ts != null
        ? DateUtil.formatDateMs(historyTradeInfo!.ts, format: 'HH:mm:ss')
        : '--';
    String vol = historyTradeInfo?.vol != null
        ? historyTradeInfo!.vol.toNum().formatOrderQuantity(amountPrecision)
        : '--';
    String price = historyTradeInfo?.price != null
        ? historyTradeInfo!.price.toFixed(pricePrecision)
        : '--';

    return Container(
      height: 18.h,
      alignment: Alignment.center,
      child: Stack(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            time,
            style: AppTextStyle.f_12_400.colorTextSecondary,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            price,
            style: AppTextStyle.f_12_400.copyWith(
              color: historyTradeInfo?.priceColor ?? AppColor.color333333,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            vol,
            textAlign: TextAlign.right,
            style: AppTextStyle.f_12_400.colorTextSecondary,
          ),
        )
      ]),
    ).marginSymmetric(vertical: 4.h);
  }
}
