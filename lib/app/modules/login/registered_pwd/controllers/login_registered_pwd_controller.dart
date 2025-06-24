import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class LoginRegisteredPwdController extends GetxController {
  //TODO: Implement LoginRegisteredPwdController

  var type;
  VerificationDataModel? verificatioData;

  LoginRegisteredPwdController(
      {required this.type, required this.verificatioData});
  bool passwordBool = false;
  bool againPasswordBool = false;
  bool isAgree = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController againPasswordController = TextEditingController();
  TextEditingController inviteController = TextEditingController();
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

    super.onInit();
  }

  bool canNextPage() {
    if (passwordController.text.isNotEmpty &&
        againPasswordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  onSubmit() async {
    if (!UtilRegExp.password(passwordController.text)) {
      return;
    }
    if (!UtilRegExp.password(againPasswordController.text, isToast: false)) {
      UIUtil.showToast(LocaleKeys.user18.tr);
      return;
    }
    if (againPasswordController.text != passwordController.text) {
      UIUtil.showToast(LocaleKeys.user20.tr);
      return;
    }
    var data = {
      "invitedCode": inviteController.text,
      "loginPword": passwordController.text,
      "newPassword": againPasswordController.text,
      "registerCode": verificatioData?.account,
      "token": verificatioData?.token
    };
    bool isPhone = type == UserSafeVerificationEnum.MOBILE_REGISTERED;
    if (isPhone) {
      data['country'] = verificatioData?.country;
      AreaGetx.to.setSP(AreaGetx.to.areaCode, isSave: true);
    } else if (type == UserSafeVerificationEnum.EMAIL_REGISTERED) {}
    await userregisterThree(data);
  }

  setInviteCodeAddress(value) {
    print(value);
    if (value != null) {
      value = value.replaceRange(0, 6, '');
      print(value);
      inviteController.text = value;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    passwordController.dispose();
    againPasswordController.dispose();
    inviteController.dispose();
    super.onClose();
  }
}
