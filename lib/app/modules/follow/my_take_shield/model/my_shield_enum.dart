import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///筛选项 枚举
enum MyTakeShieldType {
  copycatUser,
  applicationUser;

  String get value => [LocaleKeys.follow219.tr, LocaleKeys.follow220.tr][index];
}

enum MyTakeShieldActionType {
  blacklist,
  prohibit,
  applyFor;

  String get value => [LocaleKeys.follow221.tr, LocaleKeys.follow222.tr, LocaleKeys.follow223.tr][index];
}
