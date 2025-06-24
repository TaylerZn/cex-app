import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../widgets/components/transaction/transaction_input_widget.dart';
import '../../controllers/contract_depth_controller.dart';
import '../suffix_button.dart';

class LimitPriceForm extends StatelessWidget {
  const LimitPriceForm(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.precision});
  final TextEditingController controller;
  final FocusNode focusNode;
  final int precision;
  @override
  Widget build(BuildContext context) {
    return TransactionInputWidget(
      hintText: '${LocaleKeys.trade34.tr} (USDT)',
      controller: controller,
      maxLength: 15,
      focusNode: focusNode,
      suffixWidget: SuffixAddSubButton(
        onAddTap: () {
          num precision = ContractDepthController.to.precisionList.first;
          controller.text =
              (controller.text.toDecimal() + precision.toDecimal())
                  .toPrecision(precision.numDecimalPlaces());
        },
        onSubTap: () {
          num precision = ContractDepthController.to.precisionList.first;
          Decimal precisionDecimal =
              (controller.text.toDecimal() - precision.toDecimal());
          if (precisionDecimal < Decimal.zero) {
            precisionDecimal = Decimal.zero;
          }
          if (precisionDecimal == Decimal.zero) {
            controller.text = '';
            return;
          }
          controller.text =
              precisionDecimal.toPrecision(precision.numDecimalPlaces());
        },
      ),
      keyboardType: TextInputType.number,
    );
  }
}
