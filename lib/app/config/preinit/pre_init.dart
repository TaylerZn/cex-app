import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:k_chart/chart_style.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/utils/lang_cache/lang_cache_manager.dart';
import 'package:nt_app_flutter/app/utils/utilities/package_util.dart';

import '../../../firebase_options.dart';
import '../../cache/app_cache.dart';
import '../../network/my_http_overides.dart';
import '../../utils/fcm/fcm_utils.dart';

class PreInit {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// 状态栏透明
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    /// 禁用手机横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Future.wait([
      loadEnvInit(),
      dbPreInit(),
    ]);
    await LangCacheManager.instance().preInit();

    /// 开发模式下
    try {
      if(kDebugMode) {
        String? localhost = StringKV.httpLocalhost.get();
        final jsonString = await rootBundle.loadString('developer.json');
        var data = jsonDecode(jsonString);
        localhost ??= data['localhost'];
        HttpOverrides.global = MyHttpOverrides(localhost: localhost);
      }
    } on Exception catch (e) {
    }

    fireBaseInit();
    rootBundle
        .load('assets/images/contract/kchart-logo.png')
        .then((value) async {
      final bytes = value.buffer.asUint8List();
      final image = await decodeImageFromList(bytes);
      ChartStyle.logo = image;
    });
  }

  static Future<void> fireBaseInit() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FcmUtils().initNotifications();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  static Future<void> loadEnvInit() async {
    await dotenv.load(fileName: ".env");
    PackageUtil.init();
    String envApiTpye = dotenv.env['APITYPE'] ?? 'dev';
    switch (envApiTpye) {
      case 'dev':
        apiType = ApiType.dev;
        break;
      case 'test':
        apiType = ApiType.test;
        break;
      case 'pre':
        apiType = ApiType.pre;
        break;
      case 'prod':
        apiType = ApiType.prod;
        break;
    }
  }
}
