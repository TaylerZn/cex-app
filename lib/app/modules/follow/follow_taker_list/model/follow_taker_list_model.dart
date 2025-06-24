import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///筛选项 枚举
enum TakerListType {
  allTraders,
  hotTraders,
  steadyTrader,
  foldTraders;

  String get value =>
      [LocaleKeys.follow164.tr, LocaleKeys.follow165.tr, LocaleKeys.follow166.tr, LocaleKeys.follow167.tr][index];
}
