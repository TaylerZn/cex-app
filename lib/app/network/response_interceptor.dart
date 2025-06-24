import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/network/app_dio.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    EasyLoading.dismiss();
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      throw DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: DioExceptionType.connectionTimeout,
          error: LocaleKeys.public63.tr);
    }
    Get.log('请求失败 ${err.message} ${err.type.toString()}');
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    bool? loading = response.requestOptions.extra[showLoading];
    if (loading != false && EasyLoading.isShow) EasyLoading.dismiss();
    try {
      if (response.data is String) {
        response.data = json.decode(response.data);
      }
      String code = response.data['code'];
      // 请求成功
      if (code == "10000") {
        if (response.data['body'] != null) {
          response.data = response.data['body'];
        }
        handler.next(response);
        // token 过期
      } else if (code == "20000") {
        //登录过期，拦截
        Get.find<UserGetx>().signOut();
      } else if (code == "0") {
        //兼容跟单web
        if (response.data['data'] != null) {
          response.data = response.data['data'];
        }
        handler.next(response);
      } else if (code == "100501") {
        //合约交易未开通
        handler.next(response);
      } else {
        throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: response.data['message']);
      }
    } catch (e) {
      Get.log("请求失败 ${e.toString()}");

      throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: response.data['message'] ?? response.data['msg']); //兼容web
    }
  }
}
