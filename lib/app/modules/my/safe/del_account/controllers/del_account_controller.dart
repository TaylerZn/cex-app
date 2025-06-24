import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/safe/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class DelAccountController extends GetxController {
  late PageController childPageController; //控制器不能放在logic，会被多个子page复用
  var pageIndex = 0;

  List<String> reasonList = [LocaleKeys.user117.tr, LocaleKeys.user118.tr];
  int reasonIndex = 0;

  bool isSelected = false;

  @override
  void onInit() {
    childPageController = PageController();
    super.onInit();
  }

  onSubmit() async {
    if (isSelected == false) {
      UIUtil.showToast(LocaleKeys.user119.tr);
      return;
    }
    UIUtil.showConfirm(LocaleKeys.user120.tr,
        content: LocaleKeys.user121.tr,
        confirmBackgroundColor: AppColor.colorDanger, confirmHandler: () {
      Get.back();

      SafeGetx.to.goIsSafe(
          emailVerific: UserGetx.to.isSetEmail
              ? SafeGoModel(
                  type: UserSafeVerificationEnum.EMAIL_DELETE_ACCOUNT,
                  verificatioData: VerificationDataModel()
                    ..showAccount = UserGetx.to.user?.info?.email ?? '')
              : null,
          mobileVerific: UserGetx.to.isMobileVerify
              ? SafeGoModel(
                  type: UserSafeVerificationEnum.MOBILE_DELETE_ACCOUNT,
                  verificatioData: VerificationDataModel()
                    ..showAccount = UserGetx.to.mobile)
              : null,
          onTap: getuserDeleteAccount);
    });
  }

  //注销账号
  getuserDeleteAccount(vData) async {
    // var data = { ...vData};
    if (vData.containsKey('emailCode')) {
      var emailCode = vData['emailCode'];
      vData.remove('emailCode');
      vData['emailAuthCode'] = emailCode;
    }
    if (vData.containsKey('smsCode')) {
      var smsCode = vData['smsCode'];
      vData.remove('smsCode');
      vData['smsAuthCode'] = smsCode;
    }
    try {
      await UserApi.instance().userDeleteAccount(vData);

      Get.find<UserGetx>().signOut(isBackMain: false);
      Get.toNamed(Routes.DEL_ACCOUNT_SUCCESS);
    } on DioException catch (e) {
      UIUtil.showError('${e.error}');
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
