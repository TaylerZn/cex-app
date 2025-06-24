import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_commondity/controllers/swap_commodity_all_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_commondity/controllers/swap_commodity_option_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class SwapCommodityController extends GetxController {
  List<String> tabs = [];
  late TextEditingController textEditingController;
  RxString searchKey = ''.obs;
  late Worker worker;

  @override
  void onInit() {
    if (UserGetx.to.isLogin) {
      tabs = [LocaleKeys.trade179.tr, LocaleKeys.trade115.tr];
      Get.put(SwapCommodityAllController());
      Get.put(SwapCommodityOptionController());
    } else {
      tabs = [LocaleKeys.trade115.tr];
      Get.put(SwapCommodityAllController());
    }
    worker = debounce<String>(searchKey, (callback) {
      SwapCommodityAllController.to.search(callback);
      SwapCommodityOptionController.to.search(callback);
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
    Get.delete<SwapCommodityAllController>();
    Get.delete<SwapCommodityOptionController>();
    super.onClose();
  }
}
