import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  final int min;
  final int max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return int.parse(newValue.text) < min ? oldValue : newValue;
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}