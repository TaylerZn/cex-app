import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nt_app_flutter/app/api/third_login/third_login.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/safe/safe.dart';
import 'package:nt_app_flutter/app/models/third_login/third_login_is_auth_model.dart';
import 'package:nt_app_flutter/app/utils/utilities/flutter_telegram_login.dart';
import 'package:nt_app_flutter/app/getX/captcha_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ThirdLoginUtils {
  static TelegramLogin telegramLogin =
      TelegramLogin("8154641513", "https://www-pre.tradevert.co");

  static List<String> googleScopes = <String>[
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ];

  static List<AppleIDAuthorizationScopes> appleScopes =
      <AppleIDAuthorizationScopes>[
    AppleIDAuthorizationScopes.email,
  ];

  static Future<String> loginWithApple() async {
    try {
      AuthorizationCredentialAppleID account =
          await SignInWithApple.getAppleIDCredential(
        scopes: appleScopes,
        // Optional webAuthenticationOptions
        // webAuthenticationOptions:
        //     WebAuthenticationOptions(clientId: "clientId", redirectUri: Uri.parse("uri")),
      );
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(account.identityToken!);
      return decodedToken['email'] ?? "";
    } catch (e) {
      AppLogUtil.e("$e");
      return "";
    }
  }

  static Future<String> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        // Optional clientId
        // clientId: 'your-client_id.apps.googleusercontent.com',
        scopes: googleScopes,
        forceCodeForRefreshToken: Platform.isAndroid,
      );
      GoogleSignInAccount? account = await googleSignIn.signIn();
      return account?.email ?? "";
    } catch (e) {
      AppLogUtil.e("$e");
      return "";
    }
  }

  static Future<String> loginWithTelegram() async {
    try {
      var data = await telegramLogin.loginTelegram();
      if (data != "") {
        // var data = await telegramLogin.getData();s
        // if (data) {
        //   return telegramLogin.userData.toString();
        // } else {
        //   return "";
        // }
        return data;
      } else {
        return "";
      }
    } catch (e) {
      AppLogUtil.e("$e");
      return "";
    }
  }

  static Future thirdLogin(int index, {bool? isBind}) async {
    EasyLoading.show();
    String currentEmail = "";
    String type = "";
    switch (index) {
      case 1:
        currentEmail = await loginWithApple();
        type = "Apple";
        break;
      case 2:
        currentEmail = await loginWithGoogle();
        type = "Google";
        break;
      case 3:
        EasyLoading.dismiss();
        currentEmail = await loginWithTelegram();
        type = "Telegram";
        break;
    }
    if (currentEmail != "") {
      EasyLoading.dismiss();
      if (isBind == true) {
        return currentEmail;
      } else {
        // 判断是否已绑定过
        getAuth(type, currentEmail).then((value) {
          if (value.isAuth == "true") {
            thirdWithLogin(type, currentEmail);
          } else {
            Get.toNamed(Routes.ASSOCIATED_ACCOUNT,
                arguments: {"type": type, "data": currentEmail});
          }
        });
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  static Future<ThirdLoginIsAuth> getAuth(String type, String account) async {
    var res = ThirdLoginApi.instance().thirdIsAuth(type, account);
    return res;
  }

  static Future thirdWithLogin(String type, String account) async {
    CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
      // 2 手机验证码 3 邮箱验证码
      var data = {...result, "auth_type": type, "email_auth": account};
      try {
        VerificationDataModel? res = await UserApi.instance().userloginin(data);
        if (res != null) {
          // res.account = data['email_auth'];
          Get.toNamed(Routes.LOGIN_VERIFICATION,
              arguments: {'verificatioData': res});
        }
        return res;
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
        return null;
      }
    });
  }

  static Future bind(
      String type, String account, VoidCallback? callBack) async {
    print("This funciton is executing here");
    CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
      // 'Apple', 'Google', 'Telegram
      try {
        // await ThirdLoginApi.instance().bind(type, account);
        // callBack?.call();
        verify(isBind: true, type: type, account: account, callBack: callBack);
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
      } catch (e) {
        AppLogUtil.e(e);
      }
    });
  }

  static Future unbind(
      String type, String account, VoidCallback? callBack) async {
    CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
      // 'Apple', 'Google', 'Telegram
      try {
        // Get.toNamed(Routes.BINDING_VERIFICATION, arguments: {
        //   'type': "unbind",
        //   'account_type': type,
        //   'verificatioData': VerificationDataModel(
        //     // type: "${Ver2FAEnum.google}",
        //     account: account,
        //     showAccount: account,
        //     typeList: '{"1":1,"2":2,"3":3}',
        //     isMask: false,
        //   ),
        // });
        verify(isBind: false, type: type, account: account, callBack: callBack);
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
      } catch (e) {
        AppLogUtil.e(e);
      }
    });
  }

  static Future verify(
      {bool? isBind = false,
      String? type,
      String? account,
      VoidCallback? callBack}) async {
    if (isBind == true) {
      try {
        if (type! == "Telegram") {
          await ThirdLoginApi.instance().bind(
            type,
            account: account!,
          );
          callBack?.call();
        } else {
          await ThirdLoginApi.instance().bind(
            type,
            emailauth: account!,
          );
          callBack?.call();
        }
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
      } catch (e) {
        AppLogUtil.e(e);
      }
    } else {
      var data = {};
      if (UserGetx.to.isGoogleVerify) {
        data["1"] = "google";
      }
      if (UserGetx.to.isSetMobile) {
        data["2"] = "mobile";
      }
      if (UserGetx.to.isSetEmail) {
        data["3"] = "email";
      }
      Get.toNamed(Routes.BINDING_VERIFICATION, arguments: {
        "type": type,
        "verificatioData": VerificationDataModel(
          typeList: json.encode(data),
          type: UserGetx.to.isGoogleVerify
              ? "1"
              : UserGetx.to.isSetMobile
                  ? "2"
                  : "3",
          account: UserGetx.to.isSetMobile
              ? UserGetx.to.mobile
              : UserGetx.to.user?.info?.email,
          showAccount: UserGetx.to.isSetMobile
              ? UserGetx.to.mobile
              : UserGetx.to.user?.info?.email,
        ),
      })?.then((value) {
        if (value == true) {
          callBack?.call();
        }
      });
      // SafeGetx.to.goIsSafe(
      //     emailVerific: UserGetx.to.isSetEmail
      //         ? SafeGoModel(
      //             type: UserSafeVerificationEnum.AUTH_UNBIND,
      //             verificatioData: VerificationDataModel()
      //               ..showAccount = UserGetx.to.user?.info?.email ?? '')
      //         : null,
      //     mobileVerific: UserGetx.to.isMobileVerify
      //         ? SafeGoModel(
      //             type: UserSafeVerificationEnum.AUTH_UNBIND,
      //             verificatioData: VerificationDataModel()
      //               ..showAccount = UserGetx.to.mobile)
      //         : null,
      //     onTap: (vData) async {
      //       String? emailAuthCode = vData['emailCode'];
      //       String? googleCode = vData['googleCode'];
      //       String? smsAuthCode = vData['smsCode'];
      //       try {
      //         await ThirdLoginApi.instance().unbind(
      //           type!,
      //           emailAuthCode: emailAuthCode,
      //           googleCode: googleCode,
      //           smsAuthCode: smsAuthCode,
      //         );
      //         callBack?.call();
      //       } on DioException catch (e) {
      //         UIUtil.showError('${e.error}');
      //       } catch (e) {
      //         AppLogUtil.e(e);
      //       }
      //     });
    }
  }
}
