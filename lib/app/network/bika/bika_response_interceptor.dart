import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'bika_app_dio.dart';

class BikaResponseInterceptor extends Interceptor {
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
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    bool? loading = response.requestOptions.extra[showLoading];
    if (loading != null && loading != false && EasyLoading.isShow) {
      EasyLoading.dismiss();
    }

    try {
      if (response.data is String) {
        response.data = json.decode(response.data);
      }

      bool succ = response.data['succ'] ?? true;
      String msg = response.data['msg'];
      String code = '${response.data['code']}';
      bool? isLogOutBool = response.requestOptions.extra[isLogOut];
      if (succ) {
        response.data = response.data['data'];
        handler.next(response);
      } else if (["10002"].contains(code)) {
        if (isLogOutBool == true) {
          return;
        }
        Get.log("登录过期，拦截");
        //登录过期，拦截
        Get.find<UserGetx>().signOut();
        throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: msg);
      } else if (["100501"].contains(code)) {
        Get.log("用户未开通合约交易");
        throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: msg);
      } else {
        throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: msg);
      }
    } catch (e) {
      Get.log("请求失败 ${e.toString()}");
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: response.data['msg'],
      );
    }
  }
}
