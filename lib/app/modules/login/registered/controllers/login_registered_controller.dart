import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/getX/captcha_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class LoginRegisteredController extends GetxController {
  //TODO: Implement LoginRegisteredController
  bool passwordBool = false;
  bool againPasswordBool = false;
  bool isAgree = false;
  TextEditingController codeController = TextEditingController();
  TextEditingController accountControll = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController againPasswordController = TextEditingController();
  TextEditingController inviteController = TextEditingController();
  bool isMobile = false;
  bool isSelected = false;

  String? thirdType;
  String? thirdData;
  @override
  void onInit() {
    passwordController.addListener(() {
      update();
    });
    againPasswordController.addListener(() {
      update();
    });
    // if (widget.codeString != null) {
    //   setInviteCodeAddress(widget.codeString);
    // }
    if (Get.arguments != null) {
      thirdType = Get.arguments['type'];
      thirdData = Get.arguments['data'];

      if (thirdType != "Telegram") {
        accountControll.text = Get.arguments['data'];
      }
    }
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
    if (isSelected == false) {
      UIUtil.showToast(LocaleKeys.user24.tr);
      return;
    }
    CaptchaService.logic().showVerify(onVerifySuccess: (result) async {
      var data = result;
      if (isMobile) {
        data['mobile'] = accountControll.text;
        data['countryCode'] = AreaGetx.to.areaCode;
      } else {
        data['email'] = accountControll.text;
      }
      if (thirdType != null) {
        data['auth_type'] = thirdType;
        data['email_auth'] = thirdData;
      }
      try {
        var res = await UserApi.instance().userregisterOne(data);
        VerificationDataModel verificatioData = VerificationDataModel();
        verificatioData.token = res['token'];
        verificatioData.account = isMobile ? data['mobile'] : data['email'];

        verificatioData.showAccount = isMobile
            ? data['countryCode'] + ' ' + data['mobile']
            : data['email'];
        if (isMobile) {
          verificatioData.country = data['countryCode'];
        }
        Get.toNamed(Routes.LOGIN_REGISTERED_VERIFICATION, arguments: {
          'type': isMobile
              ? UserSafeVerificationEnum.MOBILE_REGISTERED
              : UserSafeVerificationEnum.EMAIL_REGISTERED,
          'verificatioData': verificatioData
        });
      } on DioException catch (e) {
        UIUtil.showError('${e.error}');
        update();
      }
    });
  }

  setInviteCodeAddress(value) {
    print(value);
    if (value != null) {
      value = value.replaceRange(0, 6, '');
      print(value);
      codeController.text = value;
      update();
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
