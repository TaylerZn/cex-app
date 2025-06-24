import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nt_app_flutter/app/utils/utilities/device_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/package_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/platform_util.dart';

class AppsFlyerManager {
  // Singleton
  static final AppsFlyerManager _instance = AppsFlyerManager._internal();

  factory AppsFlyerManager() => _instance;

  AppsFlyerManager._internal();

  late AppsflyerSdk _appsflyerSdk;
  Map _deepLinkData = {};
  Map _gcd = {};

  Future<void> init() async {
    final AppsFlyerOptions options = AppsFlyerOptions(
      afDevKey: '7Z4QyZd2GyGxhR56wNep5b', // 7Z4QyZd2GyGxhR56wNep5b
      appId: '6503243651',
      showDebug: true,
      timeToWaitForATTUserAuthorization: 50,
      manualStart: true,
    );

    _appsflyerSdk = AppsflyerSdk(options);

    /// 初始化 AppsFlyer SDK
    await _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    _appsflyerSdk.startSDK(onSuccess: () {
      Get.log('AppsFlyer SDK init success');
    }, onError: (int errorCode,String errorMsg) {
      Get.log('AppsFlyer SDK init error: $errorMsg');
    });

    /// 注册回调
    _appsflyerSdk.onInstallConversionData((data) {
      Get.log('onInstallConversionData: $data');
      _gcd = data;
    });

    _appsflyerSdk.onAppOpenAttribution((data) {
      Get.log('onAppOpenAttribution: $data');
      _deepLinkData = data;
    });

    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          Get.log(dp.deepLink?.toString() ?? '');
          Get.log("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          Get.log("deep link not found");
          break;
        case Status.ERROR:
          Get.log("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          Get.log("deep link status parsing error");
          break;
      }
      Get.log("onDeepLinking res: $dp");
      _deepLinkData = dp.toJson();
    });

    if (Platform.isAndroid) {
      _appsflyerSdk.performOnDeepLinking();
    }
  }

  /// 埋点上报
  /// [eventName] 事件名称
  /// [eventValues] 事件参数
  Future<bool?> logEvent(
      String eventName, [Map? eventValues]) async {
    try {
      bool? logResult;
      logResult = await _appsflyerSdk.logEvent(eventName, eventValues);
      return logResult;
    } catch (e) {
      Get.log('logEvent error: $e');
      return null;
    }
  }
}
