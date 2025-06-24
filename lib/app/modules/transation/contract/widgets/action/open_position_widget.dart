import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../widgets/components/transaction/title_amount_widget.dart';
import '../../../../../widgets/components/transaction/title_detail_button.dart';

class OpenPositionWidget extends StatelessWidget {
  const OpenPositionWidget({
    super.key,
    required this.onBuyMoreTap,
    required this.onBuyLessTap,
    required this.openAmount,
    required this.margin,
  });

  final VoidCallback onBuyMoreTap;
  final VoidCallback onBuyLessTap;
  final String openAmount;
  final String margin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 开开算法：可开 = 保证金 * 杠杆倍数
        TitleAmountWidget(title: LocaleKeys.trade20.tr, amount: openAmount),
        7.verticalSpace,
        // 保证金 = 可用余额 * 保证金率
        TitleAmountWidget(title: LocaleKeys.trade21.tr, amount: margin),
        10.verticalSpace,
        GetBuilder<UserGetx>(
            id: 'open_contract',
            builder: (logic) {
              return TitleDetailButton(
                  title: logic.isOpenContract
                      ? LocaleKeys.trade22.tr
                      : LocaleKeys.trade228.tr,
                  bgColor: AppColor.colorSuccess,
                  onTap: () {
                    if (logic.goIsOpenContract()) {
                      onBuyMoreTap();
                    }
                  });
            }),
        8.verticalSpace,
        TitleAmountWidget(title: LocaleKeys.trade20.tr, amount: openAmount),
        7.verticalSpace,
        TitleAmountWidget(title: LocaleKeys.trade21.tr, amount: margin),
        10.verticalSpace,
        GetBuilder<UserGetx>(
            id: 'open_contract',
            builder: (logic) {
              return TitleDetailButton(
                  title: logic.isOpenContract
                      ? LocaleKeys.trade23.tr
                      : LocaleKeys.trade228.tr,
                  bgColor: AppColor.colorDanger,
                  onTap: () {
                    if (logic.goIsOpenContract()) {
                      onBuyLessTap();
                    }
                  });
            }),
      ],
    );
  }
}
