import 'package:common_utils/common_utils.dart';

bool containsIgnoreCase(String? mainString, String substring) {
  if (TextUtil.isEmpty(mainString)) {
    return false;
  }
  return mainString!.toLowerCase().contains(substring.toLowerCase());
}
