import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/main/widget/customer_main_top.dart';
import '../../utils/otc_config_utils.dart';

class CustomerMainController extends GetxController {
  var type = MainViewType.option.obs;
  late PageController pageController;

  String currency = '';

  @override
  void onInit() {
    super.onInit();
    currency = Get.arguments?['currency'] ?? '';

    type.value = (Get.arguments?['index'] ?? 0) == 0 ? MainViewType.quick : MainViewType.option;
    pageController = PageController(initialPage: type.value.index);

    OtcConfigUtils().isHome = true;
    if (OtcConfigUtils().publicInfo == null) {
      OtcApi.instance().public_info().then((value) {
        OtcConfigUtils().publicInfo = value;
        update();
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    OtcConfigUtils().isHome = false;
  }
}
