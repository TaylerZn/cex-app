import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';

class LoginRegisteredVerificationController extends GetxController {
  dynamic type;
  VerificationDataModel? verificatioData;

  LoginRegisteredVerificationController(
      {required this.type, required this.verificatioData});

  bool isGoogle = false;
  TextEditingController pinController = TextEditingController();

  onSubmit(pin) async {
    EasyLoading.show();
    var data = {
      'numberCode': pinController.text,
    };
    bool isMobile = type == UserSafeVerificationEnum.MOBILE_REGISTERED;
    data['registerCode'] = verificatioData?.account ?? '';
    data['token'] = verificatioData?.token ?? '';
    if (isMobile) {
      data['country'] = verificatioData?.country ?? '';
    }
    var res = await userregisterTwo(data);
    EasyLoading.dismiss();
    if (res != null) {
      Get.toNamed(Routes.LOGIN_REGISTERED_PWD, arguments: {
        'type': isMobile
            ? UserSafeVerificationEnum.MOBILE_REGISTERED
            : UserSafeVerificationEnum.EMAIL_REGISTERED,
        'verificatioData': verificatioData
      });
    } else {
      pinController.text = '';
      update();
    }
  }

  @override
  void onInit() {
    if (verificatioData?.googleAuth == '1') {
      isGoogle = true;
      update();
    }
    // var data = {'operationType': '2', 'token': verificatioData?.token};
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
