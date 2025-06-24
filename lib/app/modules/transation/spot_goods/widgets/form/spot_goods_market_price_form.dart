import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../widgets/components/transaction/my_slider_widget.dart';
import '../../../../../widgets/components/transaction/transaction_input_widget.dart';

class SpotGoodsMarketPriceForm extends StatelessWidget {
  const SpotGoodsMarketPriceForm(
      {super.key,
      required this.amountTextController,
      required this.amountUnits,
      required this.focusNode,
      required this.amountPercent,
      required this.onValueChanged,
      required this.amountPrecision,
        required this.hint});

  final TextEditingController amountTextController;
  final String amountUnits;
  final FocusNode focusNode;
  final int amountPrecision;
  final double amountPercent;
  final ValueChanged<double> onValueChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColor.colorD9D9D9,
            borderRadius: BorderRadius.circular(6.r),
          ),
          alignment: Alignment.center,
          child: Text(
            LocaleKeys.trade28.tr,
            style: TextStyle(
              color: AppColor.color999999,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        8.verticalSpace,

        /// 数量
        TransactionInputWidget(
          hintText:  hint,
          controller: amountTextController,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          precision: amountPrecision,
        ),
        10.verticalSpace,
        MyPercentSliderWidget(
          value: amountPercent,
          onChanged: onValueChanged,
        ),
      ],
    );
  }
}
