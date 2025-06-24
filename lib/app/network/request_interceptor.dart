import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/network/app_dio.dart';
import 'package:nt_app_flutter/app/utils/utilities/crypto_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/sm4_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/system_util.dart';

import '../cache/app_cache.dart';

class RequestInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    bool? loading = options.extra[showLoading];
    if (loading != false && !EasyLoading.isShow) EasyLoading.show();
    var userGetx = Get.find<UserGetx>();
    //请求头
    if (userGetx.isLogin) {
      var token = userGetx.user?.token;
      options.headers["X-TOKEN"] = "$token";
      options.data ??= <String, dynamic>{};
      var sm4Data = sm4NetworkSign("$token", options.data);
      options.data['sign'] = sm4Data;
    }
    options.headers['PLATFORM-CODE'] = 'ADMIN';

    options.data ??= <String, dynamic>{};
    options.data['time'] = DateTime.now().millisecondsSinceEpoch.toString();
    options.data['sign'] = CryptoUtil.bikaSign(options.data);
    options.data['uaTime'] = MyTimeUtil.uaTime(); //兼容web

    Map<String, String> headerParams = await SystemUtil.commonHeaderParams();
    if (UserGetx.to.isLogin) {
      var token = UserGetx.to.user?.token;
      headerParams["exchange-token"] = "$token";
    }
    options.headers.addAll(headerParams);
    handler.next(options);
  }
}
