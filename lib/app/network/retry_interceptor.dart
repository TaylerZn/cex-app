
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

/// 接口失败重试拦截器
/// 重试次数默认为3次
/// 重试间隔默认为1秒
///

class RetryInterceptor extends Interceptor {
  final Dio dio;

  /// 重试次数
  final int retryCount;

  /// 重试间隔
  final int retryTimer;

  RetryInterceptor(this.dio, {this.retryCount = 3, this.retryTimer = 1000});

  /// 根据返回的错误码的重试
  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    /// 不支持重试
    if (!response.requestOptions._retry) {
      return handler.next(response);
    }

    /// 解析返回数据
    if (response.data is String) {
      response.data = json.decode(response.data);
    }
    String? code = response.data['code'];

    var attempt = response.requestOptions._attempt;
    final shouldRetry =
        attempt < retryCount && response.requestOptions._codes.contains(code);
    if (!shouldRetry) {
      return handler.next(response);
    }
    response.requestOptions._attempt = attempt + 1;

    await Future.delayed(Duration(milliseconds: retryTimer));
    try {
      final res = await dio.fetch(response.requestOptions);
      handler.resolve(res);
    } catch (e) {}
  }

  /// 网络错误的重试
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    /// 不支持重试
    if (!err.requestOptions._retry) {
      return super.onError(err, handler);
    }

    var attempt = err.requestOptions._attempt;
    final shouldRetry = attempt < retryCount;
    if (!shouldRetry) {
      return super.onError(err, handler);
    }
    err.requestOptions._attempt = attempt + 1;

    await Future.delayed(Duration(milliseconds: retryTimer));
    try {
      final res = await dio.fetch(err.requestOptions);
      handler.resolve(res);
    } on DioException catch (e) {
      super.onError(e, handler);
    } catch (e) {}
  }
}

/// 重试标记
const kRetry = 'k_Retry';
const kRetryCode = 'k_RetryCode';

extension RequestOptionX on RequestOptions {
  /// 重试次数
  static const _kAttemptKey = 'retry_attempt';

  int get _attempt => extra[_kAttemptKey] ?? 0;

  set _attempt(int value) => extra[_kAttemptKey] = value;

  /// 是否支持重试
  bool get _retry => extra[kRetry] ?? false;

  List<String> get _codes => extra[kRetryCode].toString().split(',');
}
