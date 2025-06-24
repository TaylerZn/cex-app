import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class LoginForgotPwdController extends GetxController {
  //TODO: Implement LoginForgotPwdController

  var type;
  VerificationDataModel? verificatioData;

  LoginForgotPwdController({required this.type, required this.verificatioData});
  bool passwordBool = false;
  bool againPasswordBool = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController againPasswordController = TextEditingController();
  @override
  void onInit() {
    passwordController.addListener(() {
      update();
    });
    againPasswordController.addListener(() {
      update();
    });

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
      "loginPword": againPasswordController.text,
      "token": verificatioData?.token
    };
    var res = await resetpasswordstepthree(data);
    if (res == true) {
      UIUtil.showSuccess(
        LocaleKeys.user19.tr,
      );
      Get.untilNamed(Routes.LOGIN);
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
    super.onClose();
  }
}
