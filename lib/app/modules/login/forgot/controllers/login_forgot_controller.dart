import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/getX/captcha_Getx.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/models/safe/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

class LoginForgotController extends GetxController {
  //TODO: Implement LoginForgotController

  TextEditingController accountControll = TextEditingController();
  bool isMobile = false;

  VerificationDataModel verificatioData = VerificationDataModel();

  @override
  void onInit() {
    accountControll.addListener(() {
      update();
    });
    accountControll.addListener(() {
      var text = accountControll.text;
      if (text != '' && UtilRegExp.isNumeric(text)) {
        isMobile = true;
      } else {
        isMobile = false;
      }
      update();
    });
    super.onInit();
  }

  bool canNextPage() {
    if (accountControll.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  submitOntap(context) {
    if (isMobile && !UtilRegExp.phone(accountControll.text)) {
      return;
    }
    if (!isMobile && !UtilRegExp.email(accountControll.text)) {
      return;
    }
    CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
      dynamic data = result;
      dynamic account;
      if (isMobile) {
        data['mobileNumber'] = accountControll.text;
        data['countryCode'] = AreaGetx.to.areaCode;
        account = data['mobileNumber'];
        verificatioData.account = account;
        verificatioData.country = data['countryCode'];
      } else {
        data['email'] = accountControll.text;
        account = data['email'];
        verificatioData.account = account;
      }
      try {
        ResetPasswordStepModel? res =
            await UserApi.instance().resetpasswordstepone(data);
        if (res != null) {
          verificatioData.token = res.token;
          verificatioData.showAccount = account;
          verificatioData.isMask = false;
          SafeGetx.to.goIsSafe(
              mobileVerific: isMobile
                  ? SafeGoModel(
                      type: UserSafeVerificationEnum.MOBILE_FORGOT,
                      verificatioData: verificatioData)
                  : null,
              emailVerific: isMobile
                  ? null
                  : SafeGoModel(
                      type: UserSafeVerificationEnum.EMAIL_FORGOT,
                      verificatioData: verificatioData),
              onTap: getresetpasswordsteptwo);
        }
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
        update();
      }
    });
  }

  getresetpasswordsteptwo(vData) async {
    var data = {"token": verificatioData.token, ...vData};
    var res = await resetpasswordsteptwo(data);
    if (res == true) {
      Get.toNamed(Routes.LOGIN_FORGOT_PWD, arguments: {
        'type': isMobile
            ? UserSafeVerificationEnum.MOBILE_REGISTERED
            : UserSafeVerificationEnum.EMAIL_REGISTERED,
        'verificatioData': verificatioData
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
