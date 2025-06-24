//0未传 1正常 2超出限制
import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class KycImageEnum {
  static const NOT_UPLOADED = 0;
  static const UPLOADED = 1;
  static const LIMIT = 2;
}

//1身份证 2护照 3驾照 0其他有效证件
class KycIdTypeEnum {
  static const idCard = 1;
  static const passport = 2;
  static const drvingLicense = 3;
  static const other = 0;

  static String getName(code) {
    switch (code) {
      case idCard:
        return LocaleKeys.user55.tr;
      case passport:
        return LocaleKeys.user56.tr;
      case drvingLicense:
        return LocaleKeys.user57.tr;
      default:
        return LocaleKeys.user58.tr;
    }
  }
}
