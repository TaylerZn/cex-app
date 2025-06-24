import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../widgets/components/transaction/transaction_input_widget.dart';

class MarketPriceStopWinLoseForm extends StatelessWidget {
  const MarketPriceStopWinLoseForm(
      {super.key,
      required this.triggerPriceTextController,
      required this.triggerPriceFocusNode,
      required this.precision});
  final TextEditingController triggerPriceTextController;
  final FocusNode triggerPriceFocusNode;
  final int precision;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 触发价格
        TransactionInputWidget(
          hintText: '${LocaleKeys.trade80.tr} (USDT)',
          precision: precision,
          controller: triggerPriceTextController,
          keyboardType: TextInputType.number,
          focusNode: triggerPriceFocusNode,
        ),
        6.verticalSpace,

        /// 价格
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColor.colorD9D9D9,
            borderRadius: BorderRadius.circular(6.r),
          ),
          alignment: Alignment.center,
          child: Text(
            LocaleKeys.trade74.tr,
            style: TextStyle(
              color: AppColor.color999999,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
