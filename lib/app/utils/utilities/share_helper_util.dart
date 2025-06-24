// Function to check if an app is installed
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/community/community.dart';

Future<bool> isAppInstalled(String packageName, {String? urlScheme}) async {
  if (Platform.isAndroid) {
    return await DeviceApps.isAppInstalled(packageName);
  } else if (Platform.isIOS && urlScheme != null) {
    return await canLaunch(urlScheme);
  }
  return false;
}

// 是否有三方的安装
Future<bool> isAnyAppInstalled() async {
  bool isTelegramInstalled =
      await isAppInstalled('org.telegram.messenger', urlScheme: 'tg://');
  bool isWhatsappInstalled =
      await isAppInstalled('com.whatsapp', urlScheme: 'whatsapp://');
  bool isXInstalled =
      await isAppInstalled('com.twitter.android', urlScheme: 'twitter://');

  return isTelegramInstalled || isWhatsappInstalled || isXInstalled;
}

// 分享数据记录接口调用方法
Future<void> recordShareData(String topicNo) async {
  try {
    var res = await CommunityApi.instance().addForwardNum(topicNo);
    debugPrint('recordShareData');
  } catch (e) {
    // 处理错误
    debugPrint('Error recording share data: $e');
  }
}
