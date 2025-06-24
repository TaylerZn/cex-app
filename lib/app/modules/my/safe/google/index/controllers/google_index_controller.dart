import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/safe/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySafeGoogleController extends GetxController {
  VerificationDataModel verificatioData = VerificationDataModel();

  void onInit() {
    super.onInit();
  }

  delSubmit() async {
    if (UserGetx.to.isMobileVerify) {
      bool? res = await UIUtil.showConfirm(
        LocaleKeys.user148.tr,
        content: LocaleKeys.user149.tr,
      );
      if (res == true) {
        SafeGetx.to.goIsSafe(
            mobileVerific: UserGetx.to.isMobileVerify
                ? SafeGoModel(
                    type: UserSafeVerificationEnum.CLOSE_GOOGLE_VALID,
                    verificatioData: verificatioData
                      ..showAccount = UserGetx.to.mobile)
                : null,
            onTap: (vData) async {
              if (vData.containsKey('smsCode')) {
                var smsCode = vData['smsCode'];
                vData.remove('smsCode');
                vData['smsValidCode'] = smsCode;
              }
              var res = await userclosegoogleverify(vData);
              if (res == true) {
                UserGetx.to.user?.info?.googleStatus == 0;
                UserGetx.to.update();
                UserGetx.to.getRefresh();
                Get.back();
                UIUtil.showSuccess(LocaleKeys.user150.tr);
              }
            });
      }
    } else {
      UIUtil.showToast(
        LocaleKeys.user151.tr,
      );
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
