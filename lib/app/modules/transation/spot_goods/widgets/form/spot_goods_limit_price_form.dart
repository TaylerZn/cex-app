import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_slider_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../widgets/components/transaction/transaction_input_widget.dart';
import '../../../contract/widgets/suffix_button.dart';

class SpotGoodsLimitPriceForm extends StatelessWidget {
  const SpotGoodsLimitPriceForm(
      {super.key,
      required this.priceTextController,
      required this.amountTextController,
      required this.turnoverTextController,
      required this.amountUnits,
      required this.amountPercent,
      required this.priceFocusNode,
      required this.amountFocusNode,
      required this.turnoverFocusNode,
      required this.onValueChanged,
      required this.pricePrecision,
      required this.amountPrecision});

  final TextEditingController priceTextController;
  final FocusNode priceFocusNode;
  final TextEditingController amountTextController;
  final FocusNode amountFocusNode;
  final TextEditingController turnoverTextController;
  final FocusNode turnoverFocusNode;
  final String amountUnits;
  final double amountPercent;
  final ValueChanged<double> onValueChanged;
  final int pricePrecision;
  final int amountPrecision;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionInputWidget(
          hintText: 'USDT',
          precision: pricePrecision,
          controller: priceTextController,
          focusNode: priceFocusNode,
          suffixWidget: SuffixAddSubButton(
            onAddTap: () {
              priceTextController.text = (priceTextController.text.toDecimal() +
                      pricePrecision.toPrecision().toDecimal())
                  .toPrecision(pricePrecision);
            },
            onSubTap: () {
              Decimal precisionDecimal = (priceTextController.text.toDecimal() -
                  pricePrecision.toPrecision().toDecimal());
              if (precisionDecimal < Decimal.zero) {
                precisionDecimal = Decimal.zero;
              }
              if (precisionDecimal == Decimal.zero) {
                priceTextController.text = '';
                return;
              }
              priceTextController.text =
                  precisionDecimal.toPrecision(pricePrecision);
            },
          ),
          keyboardType: TextInputType.number,
        ),
        8.verticalSpace,

        /// 数量
        TransactionInputWidget(
          precision: amountPrecision,
          hintText: '${LocaleKeys.trade27.tr}($amountUnits)',
          focusNode: amountFocusNode,
          controller: amountTextController,
          keyboardType: TextInputType.number,
        ),
        10.verticalSpace,
        MyPercentSliderWidget(
          value: amountPercent,
          onChanged: onValueChanged,
        ),
        10.verticalSpace,
        TransactionInputWidget(
          precision: pricePrecision,
          controller: turnoverTextController,
          focusNode: turnoverFocusNode,
          hintText: '${LocaleKeys.trade174.tr} USDT',
          keyboardType: TextInputType.number,
        )
      ],
    );
  }
}
