import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

enum TransactionSwitchButtonValue { left, right }

class TransactionSwitchButton extends StatelessWidget {
  const TransactionSwitchButton(
      {super.key,
      required this.leftText,
      required this.rightText,
      required this.onValueChanged,
      required this.state,
      this.isBig = false});

  final String leftText;
  final String rightText;
  final bool isBig;
  final TransactionSwitchButtonValue state;
  final ValueChanged<TransactionSwitchButtonValue> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isBig ? 351.w : 195.w,
      height: isBig ? 32.h : 26.h,
      decoration: BoxDecoration(
        color: AppColor.colorF4F4F4,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                onValueChanged(TransactionSwitchButtonValue.left);
              },
              child: Container(
                width: isBig ? 182.w : 102.w,
                height: isBig ? 32.h : 26.h,
                padding: EdgeInsets.only(right: isBig ? 15.w : 8.w),
                alignment: Alignment.center,
                decoration: state == TransactionSwitchButtonValue.left
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            isBig
                                ? 'assets/images/contract/trade_left.png'
                                : 'assets/images/contract/contract_trade_left.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                      )
                    : null,
                child: Center(
                  child: Text(leftText,
                      style: TextStyle(
                        color: state == TransactionSwitchButtonValue.left
                            ? AppColor.colorWhite
                            : AppColor.color666666,
                        fontSize: isBig ? 13.sp : 12.sp,
                        fontFamily: 'Ark Sans SC',
                        fontWeight: FontWeight.w600,
                      ),
                      strutStyle: StrutStyle(
                        fontSize: isBig ? 13.sp : 12.sp,
                        forceStrutHeight: true,
                        height: 1.1,
                      )),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                onValueChanged(TransactionSwitchButtonValue.right);
              },
              child: Container(
                width: isBig ? 182.w : 102.w,
                height: isBig ? 32.h : 26.h,
                padding: EdgeInsets.only(left: isBig ? 15.w : 8.w),
                alignment: Alignment.center,
                decoration: state == TransactionSwitchButtonValue.right
                    ? BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            isBig
                                ? 'assets/images/contract/trade_right.png'
                                : 'assets/images/contract/contract_trade_right.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                      )
                    : null,
                child: Center(
                  child: Text(
                    rightText,
                    style: TextStyle(
                      color: state == TransactionSwitchButtonValue.right
                          ? AppColor.colorWhite
                          : AppColor.color666666,
                      fontWeight: FontWeight.w600,
                      fontSize: isBig ? 13.sp : 12.sp,
                      fontFamily: 'Ark Sans SC',
                      height: 1.1,
                    ),
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
