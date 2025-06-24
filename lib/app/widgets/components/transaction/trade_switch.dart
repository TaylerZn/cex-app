import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/transaction_switch_button.dart';

class TradeSwitch extends StatelessWidget {
  const TradeSwitch(
      {super.key,
      required this.height,
      required this.width,
      required this.leftText,
      required this.rightText,
      required this.state,
      required this.onValueChanged});
  final double height;
  final double width;
  final String leftText;
  final String rightText;
  final TransactionSwitchButtonValue state;
  final ValueChanged<TransactionSwitchButtonValue> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31.h,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: AppColor.colorBackgroundInput,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                onValueChanged(TransactionSwitchButtonValue.left);
              },
              child: Container(
                decoration: state == TransactionSwitchButtonValue.left
                    ? BoxDecoration(
                        color: AppColor.colorFunctionBuy,
                        borderRadius: BorderRadius.circular(16.r),
                      )
                    : null,
                child: Center(
                  child: Text(
                    leftText,
                    style: AppTextStyle.f_12_600.copyWith(
                        color: state == TransactionSwitchButtonValue.left
                            ? AppColor.colorWhite
                            : AppColor.colorTextTips),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                onValueChanged(TransactionSwitchButtonValue.right);
              },
              child: Container(
                decoration: state == TransactionSwitchButtonValue.right
                    ? BoxDecoration(
                        color: AppColor.colorFunctionSell,
                        borderRadius: BorderRadius.circular(16.r),
                      )
                    : null,
                child: Center(
                  child: Text(
                    rightText,
                    style: AppTextStyle.f_12_600.copyWith(
                        color: state == TransactionSwitchButtonValue.right
                            ? AppColor.colorWhite
                            : AppColor.colorTextTips),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
