import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';

class AssetsProfit extends StatelessWidget {
  final String title;
  final String value;
  final String percent;
  final bool isTitleDotted;
  final bool hasPercent;
  final GestureTapCallback? onTap;
  final String valueNum;
  final TextStyle? titleStyle;

  const AssetsProfit(
      {super.key,
      this.title = '',
      this.value = '0.00',
      this.percent = '0.00',
      this.isTitleDotted = false,
      this.onTap,
      this.hasPercent = true,
      this.valueNum = '0.00',
      this.titleStyle});

  @override
  Widget build(BuildContext context) {
    Color color = AppColor.color111111;
    if (valueNum.toNum() == 0) {
      color = AppColor.color111111;
    } else {
      color = valueNum.toNum() > 0
          ? AppColor.colorFunctionBuy
          : AppColor.colorFunctionSell;
    }

    return Row(
      children: [
        MyDottedText(
          title,
          lineWidthRatio: isTitleDotted ? 1 : 0,
          style: titleStyle ?? AppTextStyle.f_11_400.colorTextTips,
          colorLineColor: AppColor.colorTextDisabled,
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
        ),
        4.horizontalSpace,
        Text(
            hasPercent
                ? '$value(${AssetsGetx.to.isEyesOpen ? percent : '****'})'
                : value,
            style: AppTextStyle.f_11_400.copyWith(
              color: color,
            ))
      ],
    );
  }
}
