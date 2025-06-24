import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_contract/controllers/swap_contract_all_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_contract/controllers/swap_contract_option_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../getX/user_Getx.dart';

class SwapContractController extends GetxController {
  List<String> tabs = [];
  late TextEditingController textEditingController;
  RxString searchKey = ''.obs;
  late Worker worker;

  @override
  void onInit() {
    if (UserGetx.to.isLogin) {
      tabs = [LocaleKeys.trade179.tr, LocaleKeys.trade115.tr];
      Get.put(SwapContractAllController());
      Get.put(SwapContractOptionController());
    } else {
      tabs = [LocaleKeys.trade115.tr];
      Get.put(SwapContractAllController());
    }
    worker = debounce<String>(searchKey, (callback) {
      SwapContractAllController.to.search(callback);
      SwapContractOptionController.to.search(callback);
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
    Get.delete<SwapContractAllController>();
    Get.delete<SwapContractOptionController>();
    super.onClose();
  }
}
