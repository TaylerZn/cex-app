import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../models/contract/res/history_trade_info.dart';
import 'list_item/trade_history_item.dart';

class TradeHistoryListView extends StatelessWidget {
  const TradeHistoryListView(
      {super.key,
      required this.historyTradeInfo,
      required this.amountPrecision,
      required this.pricePrecision,
      required this.baseSymbol,
      required this.quoteSymbol});

  final List<HistoryTradeInfo> historyTradeInfo;
  final int amountPrecision;
  final int pricePrecision;
  final String baseSymbol;
  final String quoteSymbol;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 24.h,
          alignment: Alignment.center,
          child: Stack(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.trade89.tr,
                style: AppTextStyle.f_10_500.colorTips,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "${LocaleKeys.trade34.tr}（$quoteSymbol）",
                style: AppTextStyle.f_10_500.colorTips,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${LocaleKeys.trade27.tr}（$baseSymbol）',
                textAlign: TextAlign.right,
                style: AppTextStyle.f_10_500.colorTips,
              ),
            )
          ]),
        ),
        ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            HistoryTradeInfo? historyTradeInfo =
                this.historyTradeInfo.safe(index);
            return TradeHistoryItem(
              historyTradeInfo: historyTradeInfo,
              amountPrecision: amountPrecision,
              pricePrecision: pricePrecision,
            );
          },
        )
      ],
    ).paddingSymmetric(
      horizontal: 16.w,
    );
  }
}
