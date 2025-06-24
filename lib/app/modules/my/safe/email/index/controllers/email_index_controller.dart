import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MySafeEmailController extends GetxController {
  void onInit() {
    super.onInit();
  }

  onEdit() {
    if (UserGetx.to.isGoogleVerify == false &&
        UserGetx.to.isMobileVerify == false) {
      UIUtil.showToast(
        LocaleKeys.user159.tr,
      );
    } else {
      Get.toNamed(Routes.MY_SAFE_EMAIL_BIND);
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
