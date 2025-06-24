import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';

class TradeBuyItem extends StatelessWidget {
  const TradeBuyItem(
      {super.key,
      required this.depthInfo,
      required this.maxVol,
      required this.amountPrecision,
      required this.pricePrecision});
  final DepthEntity? depthInfo;
  final num maxVol;
  final int amountPrecision;
  final int pricePrecision;

  @override
  Widget build(BuildContext context) {
    String price = maxVol == 0
        ? '--'
        : depthInfo?.price.toStringAsFixed(pricePrecision) ?? '--';
    String amount = depthInfo?.vol.toPrecision(amountPrecision) ?? '--';
    double percent = maxVol == 0 ? 0 : (depthInfo?.vol ?? 0) / (maxVol);
    double targetPercent = percent != 0 ? max(0.05, percent) : 0;

    return Stack(
      children: [
        Row(
          children: [
            Expanded(
                flex: ((1 - targetPercent) * 100).toInt(), child: Container()),
            Expanded(
              flex: (targetPercent * 100).toInt(),
              child: Container(
                color: AppColor.upColor.withOpacity(0.05),
                height: 30.h,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount,
                style: AppTextStyle.f_12_400_15.color333333,
              ),
              Text(
                price,
                style: AppTextStyle.f_12_400_15.upColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TradeSellItem extends StatelessWidget {
  const TradeSellItem(
      {super.key,
      this.depthInfo,
      required this.maxVol,
      required this.amountPrecision,
      required this.pricePrecision});
  final DepthEntity? depthInfo;
  final num maxVol;
  final int amountPrecision;
  final int pricePrecision;

  @override
  Widget build(BuildContext context) {
    String price = maxVol == 0
        ? '--'
        : depthInfo?.price.toStringAsFixed(pricePrecision) ?? '--';
    String amount = depthInfo?.vol.toPrecision(amountPrecision) ?? '--';
    double percent = maxVol == 0 ? 0 : (depthInfo?.vol ?? 0) / (maxVol);
    double targetPercent = percent != 0 ? max(0.05, percent) : 0;
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: (targetPercent * 100).toInt(),
              child: Container(
                color: AppColor.downColor.withOpacity(0.05),
                height: 30.h,
              ),
            ),
            Expanded(
                flex: ((1 - targetPercent) * 100).toInt(), child: Container()),
          ],
        ),
        SizedBox(
          height: 30.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: AppTextStyle.f_12_400_15.downColor,
              ),
              Text(
                amount,
                style: AppTextStyle.f_12_400_15.color333333,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
