import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/safe/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySafePwdChangeController extends GetxController {
  VerificationDataModel verificatioData = VerificationDataModel();

  bool oldPasswordBool = false;
  bool passwordBool = false;
  bool againPasswordBool = false;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController againPasswordController = TextEditingController();
  @override
  void onInit() {
    oldPasswordController.addListener(() {
      update();
    });
    passwordController.addListener(() {
      update();
    });
    againPasswordController.addListener(() {
      update();
    });

    super.onInit();
  }

  bool canNextPage() {
    if (oldPasswordController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        againPasswordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  onSubmit() async {
    if (oldPasswordController.text.isEmpty) {
      UIUtil.showToast(LocaleKeys.user177.tr);
      return;
    }
    if (!UtilRegExp.password(passwordController.text, isToast: false)) {
      UIUtil.showToast(LocaleKeys.user174.tr);
      return;
    }
    if (againPasswordController.text.isEmpty) {
      UIUtil.showToast(LocaleKeys.user181.tr);
      return;
    }
    if (againPasswordController.text != passwordController.text) {
      UIUtil.showToast(LocaleKeys.user20.tr);
      return;
    }
    SafeGetx.to.goIsSafe(
        mobileVerific: UserGetx.to.isMobileVerify
            ? SafeGoModel(
                type: UserSafeVerificationEnum.CHANGE_PWD,
                verificatioData: verificatioData
                  ..showAccount = UserGetx.to.mobile,
              )
            : null,
        onTap: (vData) async {
          if (vData.containsKey('smsCode')) {
            var smsCode = vData['smsCode'];
            vData.remove('smsCode');
            vData['smsAuthCode'] = smsCode;
          }
          var data = {
            "loginPword": oldPasswordController.text,
            "newLoginPword": againPasswordController.text,
            ...vData
          };
          var res = await userpasswordupdate(data);
          if (res == true) {
            UserGetx.to.signOut();
            UIUtil.showSuccess(LocaleKeys.user175.tr);
          }
        });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    passwordController.dispose();
    againPasswordController.dispose();
    super.onClose();
  }
}
