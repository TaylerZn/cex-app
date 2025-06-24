import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/user/user_interface.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:screenshot/screenshot.dart';

class MySafeGoogleBindController extends GetxController {
  ScreenshotController controller = ScreenshotController();
  TextEditingController loginPwd = TextEditingController();
  TextEditingController googleCode = TextEditingController();
  MyPageLoadingController loadingController = MyPageLoadingController();
  Uint8List? bytes;
  UsertoopegoogleModel? googleData;

  void onInit() {
    getusertoopegoogleauthenticator();
    super.onInit();
  }

  onSubmit() async {
    EasyLoading.show();

    var data = {
      'googleKey': googleData?.googleKey ?? '',
      'loginPwd': loginPwd.text,
      'googleCode': googleCode.text,
    };
    var res = await usergoogleverify(data);
    EasyLoading.dismiss();
    if (res == true) {
      UserGetx.to.getRefresh();
      Get.back(result: true);
    }
  }

  // 获取google信息
  getusertoopegoogleauthenticator() async {
    UsertoopegoogleModel? res = await usertoopegoogleauthenticator({});
    print(res);
    if (res != null) {
      googleData = res;
      // 这里是你的Base64字符串
      if (res.googleImg != null) {
        bytes = await MyFileUtil.parseBase64(res.googleImg);
      }

      loadingController.setSuccess();
      update();
    } else {
      loadingController.setError();
      update();
    }
  }

  bool canNextPage() {
    if (googleData != null &&
        googleCode.text.isNotEmpty &&
        loginPwd.text.isNotEmpty) {
      return true;
    }
    return false;
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
