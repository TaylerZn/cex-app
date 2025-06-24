import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

class TitleAmountWidget extends StatelessWidget {
  const TitleAmountWidget(
      {super.key, required this.title, required this.amount});

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.f_11_400.colorTextTips,
        ),
        Text(
          amount,
          textAlign: TextAlign.right,
          style: AppTextStyle.f_11_400.colorTextPrimary,
        ),
      ],
    );
  }
}
