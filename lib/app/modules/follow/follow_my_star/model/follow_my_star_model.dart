import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///筛选项 枚举
enum FollowMyStarType {
  trader,
  card;

  String get value => [LocaleKeys.follow2.tr, LocaleKeys.follow3.tr][index];
}
