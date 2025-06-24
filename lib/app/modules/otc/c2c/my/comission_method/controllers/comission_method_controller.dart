import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/payment_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../routes/app_pages.dart';
import '../../../../../../widgets/dialog/confirm_dialog.dart';

class ComissionMethodController extends GetxController {
  //TODO: Implement ComissionMethodController
  RefreshController refreshController = RefreshController();
  final RxList<PaymentInfo?> paymentList = RxList();
  bool isRequest = false;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    EasyLoading.show();
    try {
      paymentList.value = await OtcApi.instance().paymentList() ?? [];
      isRequest = true;
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }

    //
    // TODO: implement fetchData
    EasyLoading.dismiss();
  }

  Future<void> performAction(int index, PaymentInfo? paymentInfo) async {
    switch (index) {
      case 0:
        Get.toNamed(Routes.COMISSION_CARD_FILL, arguments: {'info': paymentInfo});
        break;
      case 1:
        {
          Get.dialog(ConfirmDialog(
              title: LocaleKeys.c2c48.tr,
              confirmCallback: () async {
                try {
                  EasyLoading.show();
                  dynamic stat = await OtcApi.instance().paymentDelete(paymentInfo?.id ?? 0);
                  EasyLoading.dismiss();
                  if (stat == null) {
                    UIUtil.showSuccess(LocaleKeys.c2c144.tr);
                    fetchData();
                  }
                } on dio.DioException catch (e) {
                  UIUtil.showError('${e.error}');
                }
              }));
        }
        break;
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
