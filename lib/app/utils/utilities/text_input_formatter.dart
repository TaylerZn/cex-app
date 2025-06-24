
import 'package:flutter/services.dart';

FilteringTextInputFormatter allow(int precision) {
  switch (precision) {
    case 1:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}'));
    case 2:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'));
    case 3:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}'));
    case 4:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}'));
    case 5:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,5}'));
    case 6:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,6}'));
    case 7:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,7}'));
    case 8:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,8}'));
    case 9:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,9}'));
    case 10:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,10}'));
    case 11:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,11}'));
    case 12:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,12}'));
    case 13:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,13}'));
    default:
      return FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'));
  }
}