import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_draw.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class BuySellProcessWidget extends StatelessWidget {
  const BuySellProcessWidget(
      {super.key, required this.buyPre, required this.askPre});
  final double buyPre;
  final double askPre;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 24.h,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LocaleKeys.trade47.tr,
                  style: AppTextStyle.f_10_500.colorTextTips,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${LocaleKeys.trade34.tr}（USDT）',
                  style: AppTextStyle.f_10_500.colorTextTips,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  LocaleKeys.trade48.tr,
                  style: AppTextStyle.f_10_500.colorTextTips,
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 16.w),
        ),
        Container(
          height: 30.h,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${(buyPre * 100).toPrecision(2)}%',
                  style: AppTextStyle.f_12_500.upColor),
              10.horizontalSpace,
              Expanded(
                child: FollowTakerDrawProgress(
                  left: max((buyPre * 100).toInt(), 5),
                  right: max((askPre * 100).toInt(), 5),
                  leftColor: AppColor.colorFunctionBuy,
                  rightColor: AppColor.colorFunctionSell,
                  height: 5,
                  marginTop: 0,
                ),
              ),
              10.horizontalSpace,
              Text(
                '${(askPre * 100).toPrecision(2)}%',
                textAlign: TextAlign.right,
                style: AppTextStyle.f_12_500.downColor,
              )
            ],
          ).marginSymmetric(horizontal: 16.w),
        ),
      ],
    );
  }
}
