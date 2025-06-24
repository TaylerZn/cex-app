import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';
import 'package:nt_app_flutter/app/utils/utilities/crypto_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/system_util.dart';

class BikaRequestInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    bool? loading = options.extra[showLoading];
    if (loading != null && loading != false && !EasyLoading.isShow) {
      EasyLoading.show();
    }

    bool? signBool = options.extra[isSign];
    int? sendTimeoutInt = options.extra[sendTimeout];
    if (sendTimeoutInt != null) {
      options.sendTimeout = Duration(milliseconds: sendTimeoutInt);
    }

    String? contentType = options.extra[changeContentType];
    if (signBool == null) {
      options.data ??= <String, dynamic>{};
      options.data = Map<String, dynamic>.from(options.data);

      options.data['time'] = DateTime.now().millisecondsSinceEpoch.toString();
      options.data['sign'] = CryptoUtil.bikaSign(options.data);
    }

    Map<String, String> headerParams = await SystemUtil.commonHeaderParams();
    try {
      if(Get.isRegistered<UserGetx>()) {
        if (UserGetx.to.isLogin) {
          var token = UserGetx.to.user?.token;
          headerParams["exchange-token"] = "$token";
        }
      }
    } catch (e) {
    }
    if (contentType != null && contentType.isNotEmpty) {
      headerParams["Content-Type"] = contentType;
    }
    options.headers.addAll(headerParams);
    handler.next(options);
  }
}
