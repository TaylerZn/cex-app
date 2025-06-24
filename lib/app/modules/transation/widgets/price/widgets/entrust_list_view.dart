import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/buy_sell_process_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';

import 'list_item/trade_list_item.dart';


class TradeListView extends StatelessWidget {
  const TradeListView({super.key, required this.asks, required this.buys, required this.amountPrecision, required this.pricePrecision});

  final List<DepthEntity> asks;
  final List<DepthEntity> buys;
  final int amountPrecision;
  final int pricePrecision;

  @override
  Widget build(BuildContext context) {
    double width = (context.width - 32.w - 7.w) * 0.5;
    /// asks 排序
    /// buys 排序
    num asksMax = asks.isNotEmpty ? asks.first.vol : 0;
    num buysMax = buys.isNotEmpty ? buys.first.vol : 0;
    num askTotal = 0;
    for (var element in asks) {
      askTotal += element.vol;
    }
    num buyTotal = 0;
    for(var element in buys) {
      buyTotal += element.vol;
    }

    num total = buyTotal + askTotal;

    double buyPre = total == 0 ? 0.5 : buyTotal / total;
    double askPre = total == 0 ? 0.5 : askTotal / total;

    return Column(
      children: <Widget>[
         BuySellProcessWidget(
          buyPre: buyPre,
          askPre: askPre,
        ),
        Row(
          children: [
            16.horizontalSpace,
            SizedBox(
              width: width,
              child: ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  DepthEntity? depthInfo = buys.safe(index);
                  return TradeBuyItem(depthInfo: depthInfo, maxVol: buysMax,amountPrecision: amountPrecision,pricePrecision: pricePrecision,);
                },
              ),
            ),
            4.horizontalSpace,
            SizedBox(
              width: width,
              child: ListView.builder(
                itemCount: 20,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DepthEntity? depthInfo = asks.safe(index);
                  return TradeSellItem(depthInfo: depthInfo, maxVol: asksMax,amountPrecision: amountPrecision,pricePrecision: pricePrecision,);
                },
              ),
            ),
            16.horizontalSpace,
          ],
        ),
      ],
    );
  }
}
