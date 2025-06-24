import 'package:flutter/services.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';

class MyInputFormatter extends TextInputFormatter {
  final Function()? onFilterError;
  final Function()? onFilterSuccess;
  final String? regExp;
  MyInputFormatter({
    this.regExp,
    this.onFilterError,
    this.onFilterSuccess,
  });
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (RegExp(regExp ?? UtilRegExp.passwordRegExp).hasMatch(newValue.text)) {
        if (onFilterSuccess != null) {
          onFilterSuccess!();
        }
        return newValue;
      }
      if (onFilterError != null) {
        onFilterError!();
      }
      return oldValue;
    }
    if (onFilterSuccess != null) {
      onFilterSuccess!();
    }
    return newValue;
  }
}

//限制输入数字和小数
class MyNumberInputFormatter extends TextInputFormatter {
  int? decimalPlaces;
  MyNumberInputFormatter({this.decimalPlaces});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (newText.startsWith('.')) {
      return oldValue;
    }
    if (newText.contains('.') &&
        newText.substring(newText.indexOf('.') + 1).contains('.')) {
      return oldValue;
    }

    int index =   newValue.text.indexOf(".");


    if(index !=-1 && decimalPlaces!= null ){
      int remain  = newValue.text.substring(index+1).length;
      if(remain  > decimalPlaces!){
        int diff =  remain - index; //index+ ( );

        newText = newText.toPrecision(decimalPlaces!);
        return newValue.copyWith(text: newText);
      }

    }
    return newValue;
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {

  DecimalTextInputFormatter({required int decimalRange, required bool activatedNegativeValues})
      : assert(decimalRange == null || decimalRange >= 0,
  'DecimalTextInputFormatter declaretion error') {
    String dp = (decimalRange != null && decimalRange > 0) ? "([.][0-9]{0,$decimalRange}){0,1}" : "";
    String num = "[0-9]*$dp";

    if(activatedNegativeValues) {
      _exp = new RegExp("^((((-){0,1})|((-){0,1}[0-9]$num))){0,1}\$");
    }
    else {
      _exp = new RegExp("^($num){0,1}\$");
    }
  }

  late RegExp _exp;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if(_exp.hasMatch(newValue.text)){
      return newValue;
    }
    return oldValue;
  }
}
// //限制输入数字
// class MyNumberInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     String newText = newValue.text;
//     if (newText.startsWith('.')) {
//       return oldValue;
//     }
//     if (newText.contains('.') &&
//         newText.substring(newText.indexOf('.') + 1).contains('.')) {
//       return oldValue;
//     }
//     return newValue;
//   }
// }
