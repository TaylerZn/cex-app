import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/third_login/third_login_info_model.dart';
import 'package:nt_app_flutter/app/models/third_login/third_login_is_auth_model.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';

import 'package:retrofit/retrofit.dart';

part 'third_login.g.dart';

@RestApi()
abstract class ThirdLoginApi {
  factory ThirdLoginApi(Dio dio, {String baseUrl}) = _ThirdLoginApi;

  factory ThirdLoginApi.instance() =>
      ThirdLoginApi(BikaAppDio.getInstance().dio);

  /// @description: 用户是否绑定 参数：第三方类型，邮箱
  @POST('/user_auth/isAuth')
  Future<ThirdLoginIsAuth> thirdIsAuth(@Field('auth_type') String authType,
      @Field('email_auth') String emailauth);

  /// @description: 绑定第三方账号 参数：第三方类型，邮箱
  @POST('/user_auth/bind')
  Future bind(
    @Field('auth_type') String authType, {
    @Field('email_auth') String? emailauth,
    @Field('mobile_auth') String? account,
    @Field('emailAuthCode') String? emailAuthCode,
    @Field('googleCode') String? googleCode,
    @Field('smsAuthCode') String? smsAuthCode,
  });

  /// @description: 解绑第三方账号 参数：第三方类型，邮箱
  @POST('/user_auth/unbind')
  Future unbind(
    @Field('auth_type') String authType, {
    @Field('emailAuthCode') String? emailAuthCode,
    @Field('googleCode') String? googleCode,
    @Field('smsAuthCode') String? smsAuthCode,
  });

  /// @description: 查询第三方绑定信息
  @POST('/user_auth/bindInfo')
  Future<ThirdLoginInfoModel> bindInfo();
}
