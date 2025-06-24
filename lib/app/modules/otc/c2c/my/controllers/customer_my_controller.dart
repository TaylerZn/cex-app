import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_user_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

class CustomerMyController extends GetxController {
  //TODO: Implement CustomerMyController
  OtcUserInfo? userInfo;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (UserGetx.to.isLogin) {
      loadData();
    }
  }

  Future<void> loadData() async {
    try {
      userInfo = await OtcApi.instance().personInfo(UserGetx.to.uid ?? 0);
      // OtcApi.instance().public_info().then((value) {
      //   OtcConfigUtils().publicInfo = value;
      // });
      update();
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
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

  void increment() => count.value++;
}
