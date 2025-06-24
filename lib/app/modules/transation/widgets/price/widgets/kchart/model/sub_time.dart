import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class SubTime {
  final String title;
  final int id;
  final String subTime;

  const SubTime(this.title, this.id, this.subTime);

  /// 分时、1分钟、5分钟、15分钟、1小时、4小时、日；默认日
  static List<SubTime> commodity() {
    return [
      SubTime(LocaleKeys.trade180.tr, 1, '1min'),
      SubTime(LocaleKeys.trade181.tr, 2, '1min'),
      SubTime(LocaleKeys.trade182.tr, 3, '5min'),
      SubTime(LocaleKeys.trade183.tr, 4, '15min'),
      SubTime(LocaleKeys.trade184.tr, 5, '60min'),
      SubTime(LocaleKeys.trade185.tr, 6, '4h'),
      SubTime(LocaleKeys.trade186.tr, 7, '1day'),
    ];
  }

  /// 1分钟、5分钟、15分钟、1小时、4小时、日、周、月；默认日
  static List<SubTime> contractTrade() {
    return [
      SubTime(LocaleKeys.trade181.tr, 1, '1min'),
      SubTime(LocaleKeys.trade182.tr, 2, '5min'),
      SubTime(LocaleKeys.trade183.tr, 3, '15min'),
      SubTime(LocaleKeys.trade184.tr, 4, '60min'),
      SubTime(LocaleKeys.trade185.tr, 5, '4h'),
      SubTime(LocaleKeys.trade186.tr, 6, '1day'),
      SubTime(LocaleKeys.trade190.tr, 7, '1week'),
      SubTime(LocaleKeys.trade191.tr, 8, '1month'),
    ];
  }

  static List<SubTime> tools() {
    return [
      SubTime(LocaleKeys.trade180.tr, 8, '1min'),
      SubTime(LocaleKeys.trade183.tr, 1, '15min'),
      SubTime(LocaleKeys.trade184.tr, 2, '60min'),
      SubTime(LocaleKeys.trade185.tr, 3, '4h'),
      SubTime(LocaleKeys.trade186.tr, 4, '1day'),
      SubTime(LocaleKeys.trade190.tr, 12, '1week'),
      SubTime(LocaleKeys.trade187.tr, 5, ''),
    ];
  }

  static List<SubTime> mores() {
    return [
      // SubTime(LocaleKeys.trade180.tr, 8, '1min'),
      SubTime(LocaleKeys.trade181.tr, 9, '1min'),
      SubTime(LocaleKeys.trade182.tr, 10, '5min'),
      SubTime(LocaleKeys.trade189.tr, 11, '30min'),
      SubTime(LocaleKeys.trade191.tr, 13, '1month'),
    ];
  }
}
