// ignore_for_file: constant_identifier_names

import 'package:get/get_utils/get_utils.dart';
import 'package:nt_app_flutter/app/enums/send_code.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

// -- 前端自定义Enum --
// --  《安全验证》 --

// 1：手机号登录
// 2：邮箱登录
// 3：手机号注册
// 4：邮箱注册
// 5：手机忘记密码
// 6：邮箱忘记密码
// 7：绑定手机号
// 8：换绑新手机-原手机验证
// 9：打开手机验证
// 10：修改登录密码
// 11：关闭Google认证
// 12：绑定邮箱号
// 13：更新邮箱号
// 14：绑定邮箱号-手机验证
// 15：更新邮箱号-手机验证
// 16：注销账号-手机验证
// 17：注销账号-邮箱验证
// 20： 解绑三方账号
enum UserSafeVerificationEnum {
  MOBILE_LOGIN,
  MOBILE_REGISTERED,
  EMAIL_LOGIN,
  EMAIL_REGISTERED,
  MOBILE_FORGOT,
  EMAIL_FORGOT,
  MOBILE_BIND,
  CHANGE_MOBILE_BIND,
  CLOSE_MOBILE_VERIFY,
  CHANGE_PWD,
  CLOSE_GOOGLE_VALID,
  EMAIL_BIND,
  CHANGE_EMAIL_BIND,
  EMAIL_BIND_MOBILE_VER,
  CHANGE_EMAIL_BIND_MOBILE_VER,
  MOBILE_CRYTO_WITHDRAW,
  EMAIL_CRYTO_WITHDRAW,
  MOBILE_DELETE_ACCOUNT,
  EMAIL_DELETE_ACCOUNT,
  AUTH_UNBIND;

  int get value => [
        SendSmsEnum.PhoneLogin,
        SendSmsEnum.RegistByMobile,
        SendEmailEnum.EmailLogin,
        SendEmailEnum.RegistByEmail,
        SendSmsEnum.FindPassword,
        SendEmailEnum.FindPassword,
        SendSmsEnum.BindMobileNum,
        SendSmsEnum.ChangeMobileNum,
        SendSmsEnum.CloseMobileValid,
        SendSmsEnum.ModifyPwd,
        SendSmsEnum.CloseGoogleValid,
        SendEmailEnum.BindEmail,
        SendEmailEnum.ModifyEmail,
        SendSmsEnum.BindEmail,
        SendSmsEnum.ModifyEmail,
        SendSmsEnum.CryptoWithdraw,
        SendEmailEnum.CryptoWithdraw,
        SendSmsEnum.DeleteAccountByMobile,
        SendEmailEnum.DeleteAccountByEmail,
        SendEmailEnum.authUnBind,
      ][index];
}

class Ver2FAEnum {
  static const int mobile = 1;
  static const int email = 2;
  static const int google = 3;

  static String getTypeName(code) {
    switch (code) {
      case mobile:
        return LocaleKeys.user246.tr;
      case email:
        return LocaleKeys.user244.tr;
      case google:
        return LocaleKeys.user187.tr;
      default:
        return '';
    }
  }
}
