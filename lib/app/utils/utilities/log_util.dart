import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';

bobLog(dynamic message) {
    AppLogUtil.i(message);
}

class AppLogUtil {
  static var logger = Logger(
    printer: LongPrettyPrinter(methodCount: 2, warpLen: 100000),
  );

  static void i(dynamic) {
    if (kDebugMode) {
      Get.log(dynamic);
    }
  }

  static void d(dynamic) {
    if (kDebugMode) {
      logger.d(dynamic);
    }
  }

  static void e(dynamic) {
    if (kDebugMode) {
      logger.e(dynamic);
    }
  }

  static void w(dynamic) {
    if (kDebugMode) {
      logger.w(dynamic);
    }
  }

  static void v(dynamic) {
    if (kDebugMode) {
      logger.v(dynamic);
    }
  }

  static void t(dynamic) {
    if (kDebugMode) {
      logger.t(dynamic);
    }
  }

  static void wtf(dynamic) {
    if (kDebugMode) {
      logger.wtf(dynamic);
    }
  }
}

class LongPrettyPrinter extends PrettyPrinter {
  final int warpLen; //控制换行个数

  @override
  LongPrettyPrinter({
    this.warpLen = 1000,
    stackTraceBeginIndex = 0,
    methodCount = 2,
    errorMethodCount = 8,
    lineLength = 120,
    colors = true,
    printEmojis = true,
    printTime = false,
    noBoxingByDefault = false,
  }) : super(
          stackTraceBeginIndex: stackTraceBeginIndex,
          methodCount: methodCount,
          errorMethodCount: errorMethodCount,
          lineLength: lineLength,
          colors: colors,
          printEmojis: printEmojis,
          printTime: printTime,
          noBoxingByDefault: noBoxingByDefault,
        );

  @override
  String stringifyMessage(message) {
    var msg = super.stringifyMessage(message);
    var i = 0;
    var len = warpLen;
    var newStr = "";
    while (msg.length > i + len) {
      var next = i + len;
      var last = msg.indexOf("\n", i);
      if (last < i + 1 || last > next) {
        newStr += msg.substring(i, next) + "\n";
        i = next;
      } else {
        newStr += msg.substring(i, last);
        i = last;
      }
    }
    if (i + len > msg.length) {
      newStr += msg.substring(i);
    }
    return newStr;
  }
}
