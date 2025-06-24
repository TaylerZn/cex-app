// class LoginVerificationEnum {
//   static const google = "1";
//   static const mobile = "2";
//   static const email = "3";

//   static String getName(code) {
//     switch (code) {
//       case google:
//         return '按天策略';
//       case phone:
//         return '按月策略';
//       case email:
//         return 'VIP策略';
//       default:
//         return '';
//     }
//   }
// }

// 资产-tab类型
import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

enum LoginVerificationEnum {
  google,
  mobile,
  email;

  String get value => [
        '1',
        '2',
        '3',
      ][index];

  String get name => [
        LocaleKeys.user153.tr,
        LocaleKeys.user246.tr,
        LocaleKeys.user244.tr
      ][index];

  String get verficName => [
        LocaleKeys.user154.tr,
        LocaleKeys.user185.tr,
        LocaleKeys.user186.tr
      ][index];
}
