import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

class SetHttpOverridesController extends GetxController {
  TextEditingController localhostController = TextEditingController();
  @override
  void onInit() {
    localhostController.text = StringKV.httpLocalhost.get() ?? '';
    super.onInit();
  }

  bool canNextPage() {
    if (localhostController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  onSubmit(context) async {
    StringKV.httpLocalhost.set(localhostController.text) ?? '';
    Get.forceAppUpdate();
    Get.back();
    UIUtil.showSuccess('设置成功');
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    localhostController.dispose();
    super.onClose();
  }
}
