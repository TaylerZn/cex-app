import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MyTimeUtil {
  //获取当前时间
  static DateTime now() {
    return DateTime.now();
  }

  //获取以前的时间戳 0点
  static DateTime old(int day) {
    DateTime now = DateTime.now();
    DateTime previousDay = DateTime(now.year, now.month, now.day - day);
    return DateTime(previousDay.year, previousDay.month, previousDay.day);
  }

  //根据本地时间，将时间戳转换为DataTime 增加 toUtc 是否转换为世界时间
  static DateTime timestampToDate(int timestamp, {bool toUtc = false}) {
    DateTime dateTime;

    ///如果是十三位时间戳返回这个
    if (timestamp.toString().length == 13) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else if (timestamp.toString().length == 16) {
      ///如果是十六位时间戳
      dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    } else {
      dateTime = DateTime.now();
    }

    return toUtc ? dateTime.toUtc() : dateTime.toLocal();
  }

  //根据本地时间，将时间戳转换为yyyy/MM/dd HH:mm:ss 增加 toUtc 是否转换为世界时间
  static String timestampToStr(int timestamp, {bool toUtc = false}) {
    DateTime time = MyTimeUtil.timestampToDate(timestamp, toUtc: toUtc);
    DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm:ss');
    return formatter.format(time);
  }

  //根据本地时间，将时间戳转换为yyyy/MM/dd HH:mm 增加 toUtc 是否转换为世界时间
  static String timestampToShortStr(int timestamp, {bool toUtc = false}) {
    DateTime time = MyTimeUtil.timestampToDate(timestamp, toUtc: toUtc);
    DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
    return formatter.format(time);
  }

//根据本地时间，将时间戳转换为MM/dd  增加 toUtc 是否转换为世界时间
  static String timestampToMDShortStr(int timestamp, {bool toUtc = false}) {
    DateTime time = MyTimeUtil.timestampToDate(timestamp, toUtc: toUtc);
    DateFormat formatter = DateFormat('MM/dd');
    return formatter.format(time);
  }

//时间转换 将秒转换为小时分钟
  static durationTransform(sec, {dayBool = false}) {
    var seconds = int.parse(sec);
    var d = Duration(seconds: seconds).inDays;
    var time = Duration(seconds: seconds);
    // print('dddddd${d}');
    List<String> parts = time.toString().split(':');
    if (dayBool == true) {
      return {
        'd': '$d',
        'h': '${int.parse(parts[0]) - 24 * d}',
        'm': parts[1],
        's': (parts[2].split('.'))[0],
      };
      // '${d}:${int.parse(parts[0]) - 24 * d}:${parts[1]}:${(parts[2].split('.'))[0]}';
    } else {
      return '${parts[1]}:${(parts[2].split('.'))[0]}';
    }
  }

  //时间转换 将秒转换为月 天 小时 分钟
  static durationTransformMonth(sec, {dayBool = false}) {
    var seconds = int.parse(sec);
    var d = Duration(seconds: seconds);
    List<String> parts = d.toString().split(':');
    return '${parts[1]}:${(parts[2].split('.'))[0]}';
  }

  // 获取月日
  static String getMDime(DateTime dateTime,{String? format = 'MM-dd'}) {
    return DateFormat(format).format(dateTime);
  }

  // 获取年月日
  static String getYMDime(DateTime dateTime,{String? format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(dateTime);
  }

  static String getHMSTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  static String uaTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }
}

//转换为多久之前
class RelativeDateFormat {
  static const num oneMinute = 60000;
  static const num oneHour = 3600000;
  static const num oneDay = 86400000;
  static const num oneYear = 31536000000;

//时间转换
  static String format(DateTime date,{String? shortFormat = 'MM-dd', String longFormat = 'yyyy-MM-dd'}) {
    // 获取当前时间
    DateTime now = DateTime.now().toLocal();

    // 获取上海时区的当前时间戳
    int nowTime = now.millisecondsSinceEpoch;

    int oldTime = date.millisecondsSinceEpoch;

    int delta = nowTime - oldTime;

    if (delta < 1 * oneMinute) {
      String justNow = LocaleKeys.public22.tr;

      num seconds = toSeconds(delta);
      return justNow;
      // return (seconds <= 0 ? 1 : seconds).toInt().toString() + oneSecondAgo;
    }
    if (delta < 60 * oneMinute) {
      String oneMinuteAgo = LocaleKeys.public24.tr;
      num minutes = toMinutes(delta);
      return (minutes <= 0 ? 1 : minutes).toInt().toString() + oneMinuteAgo;
    }
    if (delta < 24 * oneHour) {
      String oneHourAgo = LocaleKeys.public25.tr;
      num hours = toHours(delta);
      return (hours <= 0 ? 1 : hours).toInt().toString() + oneHourAgo;
    }
    if (delta < 3 * oneDay) {
      String oneDayAgo = LocaleKeys.public27.tr;
      num days = toDays(delta);
      return (days <= 0 ? 1 : days).toInt().toString() + oneDayAgo;
    } // 同一年内显示月日
    else if (now.year == date.year) {
      return MyTimeUtil.getMDime(date,format: shortFormat);
    } else {
      return MyTimeUtil.getYMDime(date,format: longFormat);
    }
  }

  /** 动态承接时间戳,时间转换
   *  timeData 时间戳 int? or String? 其他类型返回空字符串
   */
  static String relativeDateFormat(dynamic timeData,{String? shortFormat = 'MM-DD', String longFormat = 'yyyy-MM-dd'}) {
    if (timeData == null) return '';
    int? timestamp;
    if (timeData is int) {
      timestamp = timeData;
    } else if (timeData is String) {
      timestamp = int.tryParse(timeData);
    }
    if (timestamp == null) return '';
    final dateTime = MyTimeUtil.timestampToDate(timestamp);
    return RelativeDateFormat.format(dateTime,shortFormat: shortFormat,longFormat: longFormat);
  }

  static num toSeconds(num date) {
    return date / 1000;
  }

  static num toMinutes(num date) {
    return toSeconds(date) / 60;
  }

  static num toHours(num date) {
    return toMinutes(date) / 60;
  }

  static num toDays(num date) {
    return toHours(date) / 24;
  }

  static num toMonths(num date) {
    return toDays(date) / 30;
  }

  static num toYears(num date) {
    return toMonths(date) / 365;
  }
}
