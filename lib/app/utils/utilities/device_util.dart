import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:nt_app_flutter/app/enums/device_type.dart';

///获取设备的相关信息
class DeviceUtil {
  static Map? deviceInfo;

  static late int deviceType;

  static String deviceId = '';

  static String systemVersion = '';

  static String sdkVersion = '';

  static String systemModel = '';

  static bool get isAndroid => Platform.isAndroid;

  static bool get isIOS => GetPlatform.isIOS;

  static void init() async {
    try {
      deviceType = isIOS ? MyDeviceType.ios : MyDeviceType.android;
      final deviceInfoPlugin = DeviceInfoPlugin();
      if (isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosDeviceInfo.identifierForVendor!;
        systemVersion = iosDeviceInfo.systemVersion ?? '';
        sdkVersion = iosDeviceInfo.systemVersion ?? '';
        systemModel = iosDeviceInfo.model ?? '';
      } else {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
        systemVersion = androidInfo.version.release;
        sdkVersion = androidInfo.version.sdkInt.toString();
        systemModel = androidInfo.model;
      }
    } catch (e) {}
  }
}
