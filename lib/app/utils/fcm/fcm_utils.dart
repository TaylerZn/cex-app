import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';

String? sToken;

class FcmUtils {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  final _androidChannel = const AndroidNotificationChannel(
    'BITCOCO',
    'BITCOCO',
    description: "BITCOCO",
    importance: Importance.max,
  );

  // 本地消息，处理android的前台消息
  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    // @drawable/ic_launcher是应用的图标，路径是：android/app/src/main/res/drawable/ic_launcher.png
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      // android 前台消息点击
      final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
      AppLogUtil.i(response);
      // 处理收到消息
      handleMessage(message);
    });
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  // 初始化，获取设备token
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    try {
      sToken = await _firebaseMessaging.getToken();
      AppLogUtil.i('fCMToken: $sToken');
    } catch (e) {
      AppLogUtil.e('fCMToken error: $e');
    }
    updateToken(sToken);

    _firebaseMessaging.onTokenRefresh.listen((token) {
      sToken = token;
      updateToken(token);
    });
    await initPushNotifications();
    await initLocalNotifications();
  }

  // 初始化接收消息的各种回调
  Future initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    // 打开app时，会执行该回调，获取消息（通常是程序终止时，点击消息打开app的回调）
    _firebaseMessaging.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message == null) return; // 没有消息不执行后操作
        handleMessage(message);
      },
    );

    // 后台程序运行时，点击消息触发
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) => handleMessage(message));

    // 前台消息，android不会通知，所以需要自定义本地通知（iOS没有前台消息，iOS的前台消息和后台运行时一样的效果）
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      if (Platform.isIOS) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: const DarwinNotificationDetails(categoryIdentifier: 'BITCOCO'),
          ),
          payload: jsonEncode(message.toMap()));
    });

    // 后台处理，后台程序运行时收到消息，不打开app也会执行的回调
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  // 处理收到的消息，比如跳转页面之类
  void handleMessage(RemoteMessage message) {
    // TODO::
    AppLogUtil.i('message ${message.toMap().toString()}');

    String? route = message.data['route'];
    if (route != null) RouteUtil.goTo(route);
  }

  // Future<void> handleBackgroundMessage(RemoteMessage message) async {
  //   final notification = message.notification;
  //   if (notification == null) return;
  //   if (Platform.isIOS) return;
  //   _localNotifications.show(
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(
  //         _androidChannel.id,
  //         _androidChannel.name,
  //         channelDescription: _androidChannel.description,
  //         icon: '@drawable/ic_launcher',
  //       )),
  //       payload: jsonEncode(message.toMap()));
  // }

  static Future updateToken(String? token) async {
    try {
      if (UserGetx.to.isLogin && UserGetx.to.user?.info != null) {
        await UserApi.instance()
            .userDeviceTokens(UserGetx.to.user!.info!.id!, token ?? '');
      }
    } catch (e) {
      AppLogUtil.e('updateToken error: $e');
    }
  }
}
