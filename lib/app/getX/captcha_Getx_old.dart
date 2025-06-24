import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gt3_flutter_plugin/gt3_flutter_plugin.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

typedef EventHandler = Function(Map event);

// -- 哪些地方可能用到验证 --
// 登录验证：在用户登录表单中增加极验验证，以防止自动化工具或脚本进行恶意登录尝试。
// 注册验证：在用户注册过程中使用，以防止自动化的批量账户创建。
// 表单提交：在各种在线表单，如意见反馈、联系我们等，添加验证，以避免自动化垃圾信息的提交。
// 敏感操作验证：在用户进行敏感操作时，如修改密码、设置支付信息、高价值交易等，增加一层验证。

class CaptchaService extends GetxService {
  static CaptchaService logic() {
    return Get.find<CaptchaService>();
  }

  Gt3FlutterPlugin? captcha;

  void init({String? language = 'en'}) {
    Gt3CaptchaConfig config = Gt3CaptchaConfig();
    config.language = 'en'; // 设置语言为英文 Set English as the CAPTCHA language
    config.cornerRadius = 5.0; // 设置圆角大小为 5.0 Set the corner radius to 5.0
    config.timeout =
        5.0; // 设置每个请求的超时时间为 5.0 Set the timeout for each request to 5.0 seconds
    captcha = Gt3FlutterPlugin(config);
  }
  // challenge: 89a46c7cfc1bee0eecfb2682da348c25, gt: d797c29ebf96c3c8264aadafbfcd0cda

  void showVerify({
    required EventHandler onVerifySuccess,
    EventHandler? onError,
    EventHandler? onShow,
    BuildContext? context,
  }) {
    // var captchaType = ApiGetx.logic.captchaType;

    geetCaptcha(
        onVerifySuccess: onVerifySuccess, onShow: onShow, onError: onError);
  }

  void geetCaptcha({
    required EventHandler onVerifySuccess,
    EventHandler? onError,
    EventHandler? onShow,
  }) async {
    EasyLoading.show();
    final captcha = this.captcha;
    if (captcha != null) {
      captcha.addEventHandler(onShow: (Map<String, dynamic> message) async {
        // 验证视图已展示 the captcha view is displayed
        debugPrint("Captcha did show");
      }, onClose: (Map<String, dynamic> message) async {
        // 验证视图已关闭 the captcha view is closed
        debugPrint("Captcha did close");
      }, onResult: (Map<String, dynamic> message) async {
        debugPrint("Captcha result: $message");
        String code = message["code"];
        if (code == "1") {
          // 发送 message["result"] 中的数据向 B 端的业务服务接口进行查询
          // 对结果进行二次校验 validate the result
          onVerifySuccess(message['result']);
        } else {
          UIUtil.showError(LocaleKeys.public51.tr);
          // 终端用户完成验证失败，自动重试 If the verification fails, it will be automatically retried.
        }
      }, onError: (Map<String, dynamic> message) async {
        UIUtil.showError("Captcha error: $message");
        String code = message["code"];
        return;
        // 处理验证中返回的错误 Handling errors returned in verification
        if (Platform.isAndroid) {
          // Android 平台
          if (code == "-2") {
            UIUtil.showError('Dart 调用异常 Call exception');
          } else if (code == "-1") {
            UIUtil.showError('Gt3RegisterData 参数不合法 Parameter is invalid');
          } else if (code == "201") {
            UIUtil.showError('网络无法访问 Network inaccessible');
          } else if (code == "202") {
            UIUtil.showError('Json 解析错误 Analysis error');
          } else if (code == "204") {
            UIUtil.showError('WebView 加载超时，请检查是否混淆极验 SDK   Load timed out');
          } else if (code == "204_1") {
            UIUtil.showError(
                'WebView 加载前端页面错误，请查看日志 Error loading front-end page, please check the log');
          } else if (code == "204_2") {
            UIUtil.showError('WebView 加载 SSLError');
          } else if (code == "206") {
            UIUtil.showError(
                'gettype 接口错误或返回为 null   API error or return null');
          } else if (code == "207") {
            UIUtil.showError(
                'getphp 接口错误或返回为 null    API error or return null');
          } else if (code == "208") {
            UIUtil.showError(
                'ajax 接口错误或返回为 null      API error or return null');
          } else {
            UIUtil.showError('发生错误，错误编码为 "$code"');
            // 更多错误码参考开发文档  More error codes refer to the development document
            // https://docs.geetest.com/sensebot/apirefer/errorcode/android
          }
        }

        if (GetPlatform.isIOS) {
          // iOS 平台
          if (code == "-1009") {
            UIUtil.showError('网络无法访问 Network inaccessible');
          } else if (code == "-1004") {
            UIUtil.showError('无法查找到 HOST  Unable to find HOST');
          } else if (code == "-1002") {
            UIUtil.showError('非法的 URL  Illegal URL');
          } else if (code == "-1001") {
            UIUtil.showError('网络超时 Network timeout');
          } else if (code == "-999") {
            UIUtil.showError(
                '请求被意外中断, 一般由用户进行取消操作导致 The interrupted request was usually caused by the user cancelling the operation');
          } else if (code == "-21") {
            UIUtil.showError(
                '使用了重复的 challenge   Duplicate challenges are used');
            UIUtil.showError(
                '检查获取 challenge 是否进行了缓存  Check if the fetch challenge is cached');
          } else if (code == "-20") {
            UIUtil.showError(
                '尝试过多, 重新引导用户触发验证即可 Try too many times, lead the user to request verification again');
          } else if (code == "-10") {
            UIUtil.showError(
                '预判断时被封禁, 不会再进行图形验证 Banned during pre-judgment, and no more image captcha verification');
          } else if (code == "-2") {
            UIUtil.showError('Dart 调用异常 Call exception');
          } else if (code == "-1") {
            UIUtil.showError('Gt3RegisterData 参数不合法  Parameter is invalid');
          } else {
            UIUtil.showError('发生错误，错误编码为 "$code"');
            // 更多错误码参考开发文档 More error codes refer to the development document
            // https://docs.geetest.com/sensebot/apirefer/errorcode/ios
          }
        }
      });
      // // var res = await commontartCaptcha();
      //  try {
      //   var res = await PublicApi.instance().commontartCaptcha();
      //   return res;
      // } on dio.DioException catch (e) {
      //   UIUtil.showError('${e.error}');
      // }

      try {
        var res = await PublicApi.instance().commontartCaptcha();
        var data = res['captcha'];
        Gt3RegisterData registerData = Gt3RegisterData(
            gt: data["gt"],
            challenge: data["challenge"],
            success: data["success"] == 1);
        captcha.startCaptcha(registerData);
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
      }
      EasyLoading.dismiss();
    } else {
      UIUtil.showError(LocaleKeys.public13.tr);
      EasyLoading.dismiss();
    }
  }
}
