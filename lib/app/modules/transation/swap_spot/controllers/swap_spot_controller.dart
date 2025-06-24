import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/controllers/swap_spot_all_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/controllers/swap_spot_option_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../getX/user_Getx.dart';

class SwapSpotController extends GetxController {
  List<String> tabs = [];
  late TextEditingController textEditingController;
  RxString searchKey = ''.obs;
  late Worker worker;

  @override
  void onInit() {
    if (UserGetx.to.isLogin) {
      tabs = [LocaleKeys.trade179.tr, LocaleKeys.trade115.tr];
      Get.put(SwapSpotAllController());
      Get.put(SwapSpotOptionController());
    } else {
      tabs = [LocaleKeys.trade115.tr];
      Get.put(SwapSpotAllController());
    }

    worker = debounce<String>(searchKey, (callback) {
      SwapSpotAllController.to.search(callback);
      SwapSpotOptionController.to.search(callback);
    }, time: const Duration(milliseconds: 1000));

    textEditingController = TextEditingController()
      ..addListener(() {
        searchKey.value = textEditingController.text.trim();
      });
    super.onInit();
  }

  @override
  void onClose() {
    worker.dispose();
    textEditingController.dispose();
    Get.delete<SwapSpotAllController>();
    Get.delete<SwapSpotOptionController>();
    super.onClose();
  }
}
