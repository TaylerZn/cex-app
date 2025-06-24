import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/network/bika/bika_request_interceptor.dart';
import 'package:nt_app_flutter/app/network/bika/bika_response_interceptor.dart';
import 'package:nt_app_flutter/app/utils/utilities/package_util.dart';

import '../logger/src/channels/dio.dart';
import '../retry_interceptor.dart';

/// 网络请求默认或者设置为true会有loading 不需要请设置为false
const String showLoading = 'showLoading';

/// 是否为退出登录
const String isLogOut = 'isLogOut';

/// 是否签名
const String isSign = 'isSign';

/// 是否更换Content-Type
const String changeContentType = 'changeContentType';

/// 是否单独设置超时时间
const String sendTimeout = 'sendTimeout';

class BikaAppDio {
  static BikaAppDio? _instance;

  late final Dio _dio;

  Dio get dio => _dio;

  static BikaAppDio getInstance() {
    _instance ??= BikaAppDio._internal();
    //允许自签名证书
    (_instance!.dio.httpClientAdapter as IOHttpClientAdapter)
        .createHttpClient = () => HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
    return _instance!;
  }

  BikaAppDio._internal() {
    _dio = Dio();

    /// 配置dio实例
    BaseOptions options = BaseOptions(
      baseUrl: BestApi.getApi().baseUrl,
      contentType: "application/json",
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      sendTimeout: const Duration(milliseconds: 300000),
    );
    _dio.options = options;

    /// 添加拦截器
    _dio.interceptors.add(BikaRequestInterceptor());
    _dio.interceptors.add(RetryInterceptor(dio));
    _dio.interceptors.add(BikaResponseInterceptor());
    if(apiType != ApiType.prod){
      _dio.interceptors.add(DioNetworkLogger());
    }
  }
}
