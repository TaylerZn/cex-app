import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

enum InviteTimeFilterType { all, yesterday, thisWeek, thisMonth }

extension InviteTimeFilterTypeExtension on InviteTimeFilterType {
  String get displayString {
    switch (this) {
      case InviteTimeFilterType.all:
        return LocaleKeys.user282.tr;
      case InviteTimeFilterType.yesterday:
        return LocaleKeys.user283.tr;
      case InviteTimeFilterType.thisWeek:
        return LocaleKeys.trade152.tr;
      case InviteTimeFilterType.thisMonth:
        return LocaleKeys.user285.tr;
      default:
        throw Exception('Invalid InviteTimeFilterType');
    }
  }

  int get index {
    switch (this) {
      case InviteTimeFilterType.all:
        return 0;
      case InviteTimeFilterType.yesterday:
        return 1;
      case InviteTimeFilterType.thisWeek:
        return 2;
      case InviteTimeFilterType.thisMonth:
        return 3;
      default:
        throw Exception('Invalid InviteTimeFilterType');
    }
  }

  Map<String, int?> get timeRange {
    final utcNow = DateTime.now().toUtc();
    DateTime start;
    DateTime end;

    switch (this) {
      case InviteTimeFilterType.all:
        end = utcNow;
        return {'startTime': null, 'endTime': end.millisecondsSinceEpoch};
      case InviteTimeFilterType.yesterday:
        start = DateTime.utc(utcNow.year, utcNow.month, utcNow.day - 1);
        end =
            DateTime.utc(utcNow.year, utcNow.month, utcNow.day - 1, 23, 59, 59);
        break;
      case InviteTimeFilterType.thisWeek:
        start = DateTime.utc(utcNow.year, utcNow.month, utcNow.day - 7);
        end =
            DateTime.utc(utcNow.year, utcNow.month, utcNow.day - 1, 23, 59, 59);
        break;
      case InviteTimeFilterType.thisMonth:
        start = DateTime.utc(utcNow.year, utcNow.month, utcNow.day - 30);
        end =
            DateTime.utc(utcNow.year, utcNow.month, utcNow.day - 1, 23, 59, 59);
        break;
      default:
        throw Exception('Invalid InviteTimeFilterType');
    }

    return {
      'startTime': start.millisecondsSinceEpoch,
      'endTime': end.millisecondsSinceEpoch
    };
  }

  String getStartTime() {
    return this.timeRange['startTime']?.toString() ?? '';
  }

  String getEndTime() {
    return this.timeRange['endTime']?.toString() ?? '';
  }

  String get formattedTimeRange {
    final timeRange = this.timeRange;
    if (this == InviteTimeFilterType.all) {
      final endTime =
          MyTimeUtil.timestampToDate(timeRange['endTime']!, toUtc: true);
      final formattedDate = DateFormat('yyyy/MM/dd').format(endTime);
      return '-$formattedDate (UTC+0)';
    } else {
      final startTime =
          MyTimeUtil.timestampToDate(timeRange['startTime']!, toUtc: true);
      final endTime =
          MyTimeUtil.timestampToDate(timeRange['endTime']!, toUtc: true);
      final formattedStartTime =
          DateFormat('yyyy/MM/dd HH:mm:ss').format(startTime);
      final formattedEndTime =
          DateFormat('yyyy/MM/dd HH:mm:ss').format(endTime);
      return '$formattedStartTime - $formattedEndTime (UTC+0)';
    }
  }
}
