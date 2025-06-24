import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///筛选项 枚举
enum MyPartingType {
  expectedSorted,
  historicalSorted;

  String get value => [LocaleKeys.follow39.tr, LocaleKeys.follow211.tr][index];
}
