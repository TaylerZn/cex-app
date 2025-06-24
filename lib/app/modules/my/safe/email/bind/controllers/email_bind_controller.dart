import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/safe/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySafeEmailBindController extends GetxController {
  TextEditingController newEmail = TextEditingController();

  void onInit() {
    newEmail.addListener(() {
      update();
    });
    super.onInit();
  }

  onSubmit() async {
    if (canNext()) {
      SafeGetx.to.goIsSafe(
          newEmailVerific: SafeGoModel(
              type: UserSafeVerificationEnum.EMAIL_BIND,
              verificatioData: VerificationDataModel(
                  showAccount: newEmail.text,
                  account: newEmail.text,
                  isMask: false)),
          emailVerific: UserGetx.to.isSetEmail
              ? SafeGoModel(
                  type: UserSafeVerificationEnum.CHANGE_EMAIL_BIND,
                  verificatioData: VerificationDataModel(
                    showAccount: UserGetx.to.user?.info?.email ?? '',
                  ))
              : null,
          mobileVerific: UserGetx.to.isMobileVerify
              ? SafeGoModel(
                  type: UserGetx.to.isSetEmail
                      ? UserSafeVerificationEnum.CHANGE_EMAIL_BIND_MOBILE_VER
                      : UserSafeVerificationEnum.EMAIL_BIND_MOBILE_VER,
                  verificatioData: VerificationDataModel(
                    showAccount: UserGetx.to.mobile,
                  ))
              : null,
          onTap: UserGetx.to.isSetEmail
              ? getuseremailupdate
              : getuseremailbindsave);
    }
  }

  //绑定邮箱号
  getuseremailbindsave(vData) async {
    // var data = { ...vData};
    var data = {"email": newEmail.text, ...vData};
    if (data.containsKey('smsCode')) {
      var smsCode = data['smsCode'];
      data.remove('smsCode');
      data['smsValidCode'] = smsCode;
    }
    if (data.containsKey('emailNewCode')) {
      var emailCode = data['emailNewCode'];
      data.remove('emailNewCode');
      data['emailValidCode'] = emailCode;
    }

    var res = await useremailbindsave(data);
    if (res == true) {
      UserGetx.to.user?.info?.email = newEmail.text.accountMask();
      UserGetx.to.update();
      Get.find<UserGetx>().getRefresh();
      Get.back();
      UIUtil.showSuccess(
        LocaleKeys.user133.tr,
      );
    }
  }

  //更新邮箱号
  getuseremailupdate(vData) async {
    var data = {"email": newEmail.text, ...vData};
    if (data.containsKey('emailCode')) {
      var emailCode = data['emailCode'];
      data.remove('emailCode');
      data['emailOldValidCode'] = emailCode;
    }
    if (data.containsKey('smsCode')) {
      var smsCode = data['smsCode'];
      data.remove('smsCode');
      data['smsValidCode'] = smsCode;
    }
    if (data.containsKey('emailNewCode')) {
      var emailCode = data['emailNewCode'];
      data.remove('emailNewCode');
      data['emailNewValidCode'] = emailCode;
    }
    var res = await useremailupdate(data);
    if (res == true) {
      UserGetx.to.user?.info?.email = newEmail.text.accountMask();
      UserGetx.to.update();
      UserGetx.to.getRefresh();
      Get.back();
      UIUtil.showSuccess(
        LocaleKeys.user134.tr,
      );
    }
  }

  bool canNext() {
    if (!UtilRegExp.email(newEmail.text, isToast: false)) {
      return false;
    }
    return true;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    newEmail.dispose();
    super.onClose();
  }
}
