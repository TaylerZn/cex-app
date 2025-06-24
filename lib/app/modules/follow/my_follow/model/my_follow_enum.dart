import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///筛选项 枚举
// enum MyFollowType {
//   contract,
//   spots;

//   String get value => ['合约', '现货'][index];
// }

///筛选项 枚举
enum MyFollowFilterType {
  myTrader,
  currentDocumentary,
  historyDocumentary;

  String get value => [LocaleKeys.follow170.tr, LocaleKeys.follow171.tr, LocaleKeys.follow172.tr][index];
}

///筛选项 枚举
enum MyFowllowFilterType {
  currentFollow,
  historyFollow;

  String get value => [LocaleKeys.follow253.tr, LocaleKeys.follow254.tr][index];
}

///筛选项 枚举
enum MyTakeFilterType {
  currentTake,
  historyTake;

  String get value => [LocaleKeys.follow122.tr, LocaleKeys.follow123.tr][index];
}
