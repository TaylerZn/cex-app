import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/network/retry_interceptor.dart';

import 'logger/src/channels/dio.dart';
import 'request_interceptor.dart';
import 'response_interceptor.dart';

/// 网络请求默认或者设置为true会有loading 不需要请设置为false
const String showLoading = 'showLoading';

class AppDio {
  static AppDio? _instance;

  late final Dio _dio;

  Dio get dio => _dio;

  static AppDio getInstance() {
    _instance ??= AppDio._internal();
    //允许自签名证书
    (_instance!.dio.httpClientAdapter as IOHttpClientAdapter)
        .createHttpClient = () => HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
    return _instance!;
  }

  AppDio._internal() {
    _dio = Dio();

    /// 配置dio实例
    BaseOptions options = BaseOptions(
        baseUrl: BestApi.getApi().baseUrl,
        contentType: "application/json",
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000));
    _dio.options = options;

    /// 添加拦截器
    _dio.interceptors.add(RequestInterceptor());
    _dio.interceptors.add(RetryInterceptor(dio));
    _dio.interceptors.add(ResponseInterceptor());
    if(apiType != ApiType.prod){
      _dio.interceptors.add(DioNetworkLogger());
    }
  }
}
