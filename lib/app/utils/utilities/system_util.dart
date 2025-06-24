import 'dart:collection';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/utilities/device_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/package_util.dart';
import 'package:uuid/uuid.dart';

class SystemUtil {
  static Map<String, String> headerParams = HashMap();

  static Future<Map<String, String>> commonHeaderParams() async {
    LangInfo langInfo = ObjectKV.localLang.get((v) => LangInfo.fromJson(v as Map<String, dynamic>)) ??
        LangInfo.defaultLangInfo;
    if (headerParams.isEmpty) {
      String uuid = const Uuid().v1();
      String netType = await getNetType();
      var timezone = await getUtf8Time();

      headerParams = {
        "Content-Type": "application/json;charset=utf-8",
        "Build-CU": PackageUtil.buildNumber,
        "exChainupBundleVersion": '4550',
        "SysVersion-CU": DeviceUtil.systemVersion,
        "SysSDK-CU": DeviceUtil.sdkVersion,
        "Channel-CU": GetPlatform.isIOS ? 'AppStore' : "google play",
        "Mobile-Model-CU": DeviceUtil.systemModel,
        "UUID-CU": uuid,
        "Platform-CU": GetPlatform.isIOS ? 'ios' : 'android',
        "Network-CU": netType,
        "Platform-CU-Num": PackageUtil.getPlatformCuNum().toString(),
        //安装包类型(0 IOS-APP Store 1 IOS-TestFlight 2 Android-Google Play 3 安卓-apk 9其他)
        "exchange-client": "app",
        "appChannel": GetPlatform.isIOS ? 'AppStore' : "google play",
        "appNetwork": netType,
        "timezone": timezone,
        "osName": GetPlatform.isIOS ? 'ios' : 'android',
        "os": GetPlatform.isIOS ? 'ios' : 'android',
        "osVersion": DeviceUtil.systemVersion,
        "platform": GetPlatform.isIOS ? 'ios' : 'android',
        "device": uuid,
        "clientType": GetPlatform.isIOS ? 'ios' : 'android',
        "language": langInfo.langKey_,
        'appAcceptLanguage': langInfo.langKey_,
        'exchange-language': langInfo.langKey_,
      };
    }
    headerParams['language'] = langInfo.langKey_;
    headerParams['appAcceptLanguage'] = langInfo.langKey_;
    headerParams['exchange-language'] = langInfo.langKey_;

    return headerParams;
  }

  static void clearHeaderParams() {
    headerParams.clear();
  }

  static Future<String> getNetType() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return 'Mobile';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 'WiFi';
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      return 'Ethernet';
    } else if (connectivityResult == ConnectivityResult.vpn) {
      return 'VPN';
    } else {
      return 'None';
    }
  }

  static Future<String> getUtf8Time() async {
    DateTime now = DateTime.now();
    Duration offset = now.timeZoneOffset;

    int hours = offset.inHours;

    String timeZoneString = 'UTC${hours >= 0 ? '+' : ''}$hours';
    print(timeZoneString); // 输出例如: UTC+8
    return timeZoneString;
  }
}
