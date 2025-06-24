import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/widgets/close_market_button.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CommodityStopTradeButton extends StatelessWidget {
  const CommodityStopTradeButton(
      {super.key,
      required this.open,
      required this.margin,
      required this.endTime,
      required this.stopCallback});

  final String open;
  final String margin;
  final int endTime;
  final VoidCallback stopCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitleDes(LocaleKeys.trade20.tr, open),
        2.verticalSpace,
        _buildTitleDes(LocaleKeys.trade21.tr, margin),
        6.verticalSpace,
        CloseMarketButton(endTime: endTime, stopCallback: stopCallback),
      ],
    );
  }

  Widget _buildTitleDes(String title, String desc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.f_11_400.copyWith(color: AppColor.color999999),
        ),
        Text(
          desc,
          textAlign: TextAlign.right,
          style: AppTextStyle.f_11_500.copyWith(color: AppColor.color333333),
        )
      ],
    );
  }
}
