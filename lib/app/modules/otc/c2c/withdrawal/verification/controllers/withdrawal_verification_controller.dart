import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

class MySafeWithdrawalVerificationController extends GetxController {
  dynamic type;
  VerificationDataModel? verificatioData;

  MySafeWithdrawalVerificationController(
      {required this.type, required this.verificatioData});

  bool isGoogle = false;
  TextEditingController pinController = TextEditingController();

  onSubmit(pin) async {
    Get.back(result: pin);
  }

  @override
  void onInit() {
    if (verificatioData?.type == '${Ver2FAEnum.google}') {
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
