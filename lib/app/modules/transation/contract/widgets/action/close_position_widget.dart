
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../widgets/components/transaction/title_amount_widget.dart';
import '../../../../../widgets/components/transaction/title_detail_button.dart';

class ClosePositionWidget extends StatelessWidget {
  const ClosePositionWidget({
    super.key,
    required this.onSellMoreTap,
    required this.onSellLessTap,
    required this.closeMoreAmount,
    required this.closeEmptyAmount,
  });

  final VoidCallback onSellMoreTap;
  final VoidCallback onSellLessTap;
  final String closeMoreAmount;
  final String closeEmptyAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAmountWidget(title: LocaleKeys.trade24.tr, amount: closeMoreAmount),
        6.verticalSpace,
        TitleDetailButton(
            title: LocaleKeys.trade25.tr, bgColor: AppColor.colorDanger, onTap: onSellMoreTap),
        9.verticalSpace,
        TitleAmountWidget(title: LocaleKeys.trade24.tr, amount: closeEmptyAmount),
        6.verticalSpace,
        TitleDetailButton(
            title: LocaleKeys.trade26.tr, bgColor: AppColor.colorSuccess, onTap: onSellLessTap),
      ],
    );
  }
}
