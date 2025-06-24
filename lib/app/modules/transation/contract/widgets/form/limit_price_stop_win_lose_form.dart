
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_depth_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../widgets/components/transaction/transaction_input_widget.dart';
import '../suffix_button.dart';

class LimitPriceStopWinLoseForm extends StatelessWidget {
  const LimitPriceStopWinLoseForm(
      {super.key,
      required this.triggerPriceTextController,
      required this.entrustPriceTextController,
      required this.triggerPriceFocusNode,
      required this.entrustPriceFocusNode,
        required this.precision});

  final TextEditingController triggerPriceTextController;
  final FocusNode triggerPriceFocusNode;
  final TextEditingController entrustPriceTextController;
  final FocusNode entrustPriceFocusNode;
  final int precision;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 触发价格
        TransactionInputWidget(
          precision: precision,
          maxLength: 15,
          hintText: '${LocaleKeys.trade79.tr}（USDT）',
          controller: triggerPriceTextController,
          keyboardType: TextInputType.number,
          focusNode: triggerPriceFocusNode,
        ),
        6.verticalSpace,

        /// 委托价格
        TransactionInputWidget(
          hintText: '${LocaleKeys.trade80.tr} USDT',
          maxLength: 15,
          precision: precision,
          controller: entrustPriceTextController,
          focusNode: entrustPriceFocusNode,
          suffixWidget: SuffixAddSubButton(
            onAddTap: () {
              num precision = ContractDepthController.to.precisionList.first;
              entrustPriceTextController.text = (entrustPriceTextController.text.toDecimal() + precision.toDecimal()).toPrecision(precision.numDecimalPlaces());
            },
            onSubTap: () {
              num precision = ContractDepthController.to.precisionList.first;
              Decimal precisionDecimal = (entrustPriceTextController.text.toDecimal() - precision.toDecimal());
              if(precisionDecimal < Decimal.zero) {
                precisionDecimal = Decimal.zero;
              }
              if(precisionDecimal == Decimal.zero) {
                entrustPriceTextController.text = '';
                return;
              }
              entrustPriceTextController.text = precisionDecimal.toPrecision(precision.numDecimalPlaces());
            },
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
