//

import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///TabBar类型 枚举
enum BehaviorType {
  currentEntrust,
  historyEntrust,
  locationHistory,
  historicalTrans,
  flowFunds,
  capitalCost;

  String get value => [
        LocaleKeys.trade36.tr,
        LocaleKeys.trade37.tr,
        LocaleKeys.trade113.tr,
        LocaleKeys.trade38.tr,
        LocaleKeys.trade39.tr,
        LocaleKeys.trade114.tr
      ][index];
}

///筛选项 枚举
enum FilterType {
  contract,
  orderType,
  direction,
  status,
  positionPattern,
  assets,
  fundType,
  rightType;

  String get value => [
        LocaleKeys.trade115.tr,
        LocaleKeys.trade116.tr,
        LocaleKeys.trade117.tr,
        LocaleKeys.trade118.tr,
        LocaleKeys.trade119.tr,
        LocaleKeys.trade120.tr,
        LocaleKeys.trade115.tr,
        ''
      ][index];
}

///弹窗类型 枚举
enum BottomViewType {
  defaultView,
  multipleChoice,
  dateView,
  exportView;
}
