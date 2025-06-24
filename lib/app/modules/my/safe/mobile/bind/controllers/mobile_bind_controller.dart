import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/area_Getx.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/safe/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySafeMobileBindController extends GetxController {
  VerificationDataModel verificatioData = VerificationDataModel();
  TextEditingController newPhone = TextEditingController();

  void onInit() {
    newPhone.addListener(() {
      update();
    });
    super.onInit();
  }

  onSubmit() async {
    if (canNext()) {
      verificatioData.account = newPhone.text;
      verificatioData.country = AreaGetx.to.areaCode;

      SafeGetx.to.goIsSafe(
          newMobileVerific: SafeGoModel(
              type: UserSafeVerificationEnum.MOBILE_BIND,
              verificatioData: verificatioData
                ..showAccount = newPhone.text
                ..isMask = false),
          mobileVerific: UserGetx.to.isMobileVerify
              ? SafeGoModel(
                  type: UserSafeVerificationEnum.CHANGE_MOBILE_BIND,
                  verificatioData: VerificationDataModel()
                    ..showAccount = UserGetx.to.mobile,
                )
              : null,
          onTap: UserGetx.to.isMobileVerify
              ? getusermobileupdate
              : getusermobilebindsave);
    }
  }

  //绑定手机号
  getusermobilebindsave(vData) async {
    // var data = { ...vData};
    if (vData.containsKey('smsNewCode')) {
      var smsNewCode = vData['smsNewCode'];
      vData.remove('smsNewCode');
      vData['smsAuthCode'] = smsNewCode;
    }
    var data = {
      "mobileNumber": verificatioData.account,
      'countryCode': verificatioData.country,
      ...vData
    };

    var res = await usermobilebindsave(data);
    if (res == true) {
      Get.find<UserGetx>().getRefresh();
      Get.back();
      UIUtil.showSuccess(LocaleKeys.public12.tr);
    }
  }

  //更新手机号
  getusermobileupdate(vData) async {
    // var data = { ...vData};
    if (vData.containsKey('smsCode')) {
      var smsCode = vData['smsCode'];
      vData.remove('smsCode');
      vData['authenticationCode'] = smsCode;
    }

    if (vData.containsKey('smsNewCode')) {
      var smsCode = vData['smsNewCode'];
      vData.remove('smsNewCode');
      vData['smsAuthCode'] = smsCode;
    }
    var data = {
      "mobileNumber": verificatioData.account,
      'countryCode': verificatioData.country,
      ...vData
    };

    var res = await usermobileupdate(data);
    if (res == true) {
      Get.find<UserGetx>().getRefresh();
      Get.back();
      UIUtil.showSuccess(LocaleKeys.public12.tr);
    }
  }

  bool canNext() {
    if (newPhone.text.isNotEmpty != true) {
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
    newPhone.dispose();
    super.onClose();
  }
}
