import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/safe/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySafeMobileController extends GetxController {
  VerificationDataModel verificatioData = VerificationDataModel();

  void onInit() {
    super.onInit();
  }

  // 改变手机认证状态
  changemobileverify() async {
    if (UserGetx.to.isGoogleVerify) {
      var isOpen =
          UserGetx.to.user?.info?.isOpenMobileCheck == 1 ? true : false;
      if (isOpen) {
        SafeGetx.to.goIsSafe(
            mobileVerific: UserGetx.to.isMobileVerify
                ? SafeGoModel(
                    type: UserSafeVerificationEnum.CLOSE_MOBILE_VERIFY,
                    verificatioData: verificatioData
                      ..showAccount = UserGetx.to.mobile,
                  )
                : null,
            onTap: (vData) async {
              if (vData.containsKey('smsCode')) {
                var smsCode = vData['smsCode'];
                vData.remove('smsCode');
                vData['smsValidCode'] = smsCode;
              }
              var res = await userclosemobileverify(vData);
              if (res == true) {
                UserGetx.to.user?.info?.isOpenMobileCheck == 0;
                UserGetx.to.update();
                UserGetx.to.getRefresh();
              }
            });
      } else {
        var res = await useropenmobileverify();
        if (res == true) {
          UserGetx.to.user?.info?.isOpenMobileCheck == 1;
          UserGetx.to.update();
          UserGetx.to.getRefresh();
        }
      }
    } else {
      UIUtil.showToast(LocaleKeys.user171.tr);
    }
  }

  onEdit() {
    if (UserGetx.to.isGoogleVerify) {
      Get.toNamed(Routes.MY_SAFE_MOBILE_BIND);
    } else {
      UIUtil.showToast(LocaleKeys.user171.tr);
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
