import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:get/utils.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';

//正则匹配
class UtilRegExp {
  /// 密码正则
  /// 6-16位字符（必须包含字母+数字组合）
  static const String passwordRegExp = r'^(?=.*[a-zA-Z])(?=.*\d).{6,16}$';

  /// 手机号正则，限制为 6 到 16 个数字字符
  static const String phoneRegExp = r'^[0-9]{6,16}$';

  /// 数字正则
  static const String numRegExp = r'^\d*\.?\d*$';

  /// 邮箱正则
  static const String emailRegExp = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
  //  6-16位字符（必须包含字母+数字组合）
  static password(String value, {isToast = true}) {
    if (value.isEmpty && isToast) {
      UIUtil.showToast(LocaleKeys.user8.tr);
      return false;
    }
    if (RegExp(passwordRegExp).hasMatch(value)) {
      return true;
    } else {
      if (isToast) {
        UIUtil.showToast(LocaleKeys.user1.tr);
      }
      return false;
    }
  }

  // 手机号
  static phone(String value, {isToast = true}) {
    if (value.isEmpty && isToast) {
      UIUtil.showToast(LocaleKeys.user169.tr);
      return false;
    }
    if (RegExp(phoneRegExp).hasMatch(value)) {
      return true;
    } else {
      if (isToast) {
        UIUtil.showToast(LocaleKeys.user2.tr);
      }
      return false;
    }
  }

  // // 邮箱
  static email(String value, {isToast = true}) {
    if (value.isEmpty && isToast) {
      UIUtil.showToast(LocaleKeys.user216.tr);
      return false;
    }
    if (RegExp(emailRegExp).hasMatch(value)) {
      return true;
    } else {
      if (isToast) {
        UIUtil.showToast(LocaleKeys.user3.tr);
      }

      return false;
    }
  }

  //判定是否为数字
  static isNumeric(s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  //判定是否为纯数字
  static isInt(s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  // 6到20位数字和字母组合 《密码》
  static aiteFriends(value) {
    final reg = RegExp(r'(?<=\[).+?(?=\])');
    final str = reg.allMatches(value).map((e) => {print(e.group(0))});
    // print(str);
    return str;
  }
}
