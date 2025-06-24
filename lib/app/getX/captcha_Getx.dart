import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/models/public/g_captcha.dart';
import 'package:nt_app_flutter/app/widgets/components/recaptcha/google_reCAPTCHA_v2.dart';
import 'package:nt_app_flutter/app/widgets/components/recaptcha/google_reCAPTCHA_v3.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

typedef EventHandler = Function(Map<String, dynamic> event);

// -- 哪些地方可能用到验证 --
// 登录验证：在用户登录表单中增加极验验证，以防止自动化工具或脚本进行恶意登录尝试。
// 注册验证：在用户注册过程中使用，以防止自动化的批量账户创建。
// 表单提交：在各种在线表单，如意见反馈、联系我们等，添加验证，以避免自动化垃圾信息的提交。
// 敏感操作验证：在用户进行敏感操作时，如修改密码、设置支付信息、高价值交易等，增加一层验证。

class CaptchaService extends GetxService {
  static CaptchaService logic() {
    return Get.find<CaptchaService>();
  }

  void init({String? language = 'en'}) {}

  void showVerify({
    required EventHandler onVerifySuccess,
    EventHandler? onError,
    EventHandler? onShow,
    BuildContext? context,
  }) {
    googleCaptchaV3(
        onVerifySuccess: onVerifySuccess, onShow: onShow, onError: onError);
  }

  //Google人机验证-V3
  void googleCaptchaV3({
    required EventHandler onVerifySuccess,
    EventHandler? onError,
    EventHandler? onShow,
  }) async {
    EasyLoading.show();
    try {
      GetReCaptchaIdModel? res = await PublicApi.instance().getReCaptchaId();
      if (res != null) {
        Get.dialog(GoogleReCAPTCHAv3View(
          siteKey: res.reCaptchaId,
        )).then((value) {
          EasyLoading.dismiss();
          if (value != null) {
            onVerifySuccess(
                {'g_recaptcha_response': value, 'verificationType': '3'});
          } else {
            UIUtil.showError(LocaleKeys.public51.tr);
            onError?.call({"error": LocaleKeys.public51.tr});
          }
        });
      } else {
        UIUtil.showError(LocaleKeys.public55.tr);
      }
    } on DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
  }

  //Google人机验证-V2
  void googleCaptchaV2({
    required EventHandler onVerifySuccess,
    EventHandler? onError,
    EventHandler? onShow,
  }) async {
    EasyLoading.show();
    try {
      GetReCaptchaIdModel? res = await PublicApi.instance().getReCaptchaId();
      if (res != null) {
        Get.dialog(GoogleReCAPTCHAv2View(
          siteKey: res.reCaptchaIdV2,
        )).then((value) {
          if (value != null) {
            onVerifySuccess(
                {'g_recaptcha_response': value, 'verificationType': '4'});
          } else {
            UIUtil.showError(LocaleKeys.public51.tr);
            onError?.call({"error": LocaleKeys.public51.tr});
          }
        });
      } else {
        UIUtil.showError(LocaleKeys.public55.tr);
      }
    } on DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
  }
}
