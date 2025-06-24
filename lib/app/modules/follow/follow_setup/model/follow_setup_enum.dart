import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

enum FollowSetupTimeType {
  followFuture,
  followPresent;

  String get value => [LocaleKeys.follow59.tr, LocaleKeys.follow60.tr][index];
}

///筛选项 枚举
enum FollowSetupType {
  fixedAmount,
  fixedProportion;

  String get value => [LocaleKeys.follow61.tr, LocaleKeys.follow62.tr][index];
  String get hintText => ['10-10,000', '0.01-100'][index];
}
