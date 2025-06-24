import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/modules/my/language_set/controllers/language_set_controller.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';

import '../../../../getX/area_Getx.dart';
import '../../../../getX/captcha_Getx.dart';
import '../../../../models/user/res/user.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/utilities/ui_util.dart';

class LoginIndexController extends GetxController {
  //TODO: Implement LoginIndexController

  TextEditingController accountControll = TextEditingController();
  TextEditingController passwordControll = TextEditingController();
  TextEditingController yzmControll = TextEditingController();
  final passwordBool = false.obs;
  final isMobile = false.obs;
  final isLoading = false.obs;

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  void setIsLoading() {
    isLoading.toggle();
  }

  @override
  void onInit() {
    accountControll.addListener(() {
      var text = accountControll.text;
      if (text != '' && UtilRegExp.isNumeric(text)) {
        if (text.length >= 3) {
          isMobile.value = true;
        } else {
          isMobile.value = false;
        }
      } else {
        isMobile.value = false;
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    LanguageSetController.to.getLangList();
  }

  @override
  void onClose() {
    super.onClose();
    MyCommunityUtil.socialMenu = null; //社区详情特殊处理
  }

  void setLanguage() {
    LanguageSetController.to.getLangList();
    Get.toNamed(Routes.LANGUAGE_SET);
  }

  Future<void> onLogin() async {
    // Get.to(testGoogleV2(
    //   title: 'test',
    // ));
    // return;
    if (isMobile.value && !UtilRegExp.phone(accountControll.text)) {
      return;
    }
    if (!isMobile.value && !UtilRegExp.email(accountControll.text)) {
      return;
    }
    if (!UtilRegExp.password(passwordControll.text)) {
      return;
    }

    if (kDebugMode) {
      mockLogin();
      return;
    }

    CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
      // 2 手机验证码 3 邮箱验证码
      var data = {
        ...result,
        'mobileNumber': accountControll.text,
        'loginPword': passwordControll.text,
      };
      if (isMobile.value) {
        data['countryCode'] = AreaGetx.to.areaCode;
        AreaGetx.to.setSP(AreaGetx.to.areaCode, isSave: true);
      }

      try {
        VerificationDataModel? res = await UserApi.instance().userloginin(data);
        if (res != null) {
          res.account = data['mobileNumber'];
          if (isMobile.value) {
            res.country = data['countryCode'];
          }
          Get.toNamed(Routes.LOGIN_VERIFICATION,
              arguments: {'verificatioData': res});
        }
        return res;
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
        update();
        return null;
      } catch (e) {
        AppLogUtil.e(e);
        update();
        return null;
      }
    });
  }

  Future<void> mockLogin() async {
    var data = {
      'verificationType': 0,
      'mobileNumber': accountControll.text,
      'loginPword': passwordControll.text,
    };
    if (isMobile.value) {
      data['countryCode'] = AreaGetx.to.areaCode;
    }

    try {
      VerificationDataModel? res = await UserApi.instance().userloginin(data);
      if (res != null) {
        res.account = accountControll.text;
        if (isMobile.value) {
          res.country = 'HK';
        }
        Get.toNamed(Routes.LOGIN_VERIFICATION,
            arguments: {'verificatioData': res});
      }
    } on DioException catch (e) {
      UIUtil.showError('${e.error}');
      update();
    }
    return;
  }
}
