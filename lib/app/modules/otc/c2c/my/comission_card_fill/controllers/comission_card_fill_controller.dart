import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/payment_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/bean/input_bean.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/comission_method/controllers/comission_method_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/sales_comission/controllers/sales_comission_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import '../../../../../../utils/utilities/ui_util.dart';

class ComissionCardFillController extends GetxController {
  InputBean? inputBean;
  PaymentInfo? info;

  @override
  void onInit() {
    super.onInit();

    if (ObjectUtil.isNotEmpty(Get.arguments) && ObjectUtil.isNotEmpty(Get.arguments['info'])) {
      info = Get.arguments['info'];
    }
    loadForm();
  }

  void loadForm() {
    rootBundle.loadString('assets/json/add_bank.json').then((value) {
      InputBean? bean = InputBean();
      inputBean = inputBeanFromJson(value);
      if (ObjectUtil.isNotEmpty(info)) {
        bean.data?.forEach((element) {}); //inputBeanFromJson();
      }
      inputBean?.data?.forEach((element) {
        Map<String, dynamic>? params = info?.toJson();
        element.value = params?[element.key] ?? '';
      });
      update();
    });
  }

  Future<void> addBank() async {
    Map<String, dynamic> params = {'payment': OtcConfigUtils().selectedInfo?.key};
    if (ObjectUtil.isNotEmpty(info)) {
      params = info?.toJson() ?? {};
    }
    inputBean?.data?.forEach((element) {
      if (ObjectUtil.isNotEmpty(element.value)) {
        params[element.key!] = element.value;
      }
    });

    bool completed = true;
    inputBean?.data?.forEach((element) {
      element.showError = false;
      element.match = true;
      if (element.mandatory == true && element.empty()) {
        element.showError = true;
        completed = false;
        return;
      }
      params[element.key!] = element.value;
    });

    if (!completed) {
      update();
      return;
    }

    try {
      EasyLoading.show();
      dynamic status = ObjectUtil.isNotEmpty(info)
          ? await OtcApi.instance().paymentEdit(
              id: params['id'],
              payment: params['payment'],
              userName: params['userName'],
              account: params['account'],
              bankName: params['bankName'])
          : await OtcApi.instance().paymentAdd(
              payment: params['payment'],
              userName: params['userName'],
              account: params['account'],
              bankName: params['bankName']);
      EasyLoading.dismiss();
      if (status == null) {
        UIUtil.showSuccess(ObjectUtil.isNotEmpty(info) ? '修改成功' : '添加成功');
        Get.back();
        if (Get.isRegistered<SalesComissionController>()) {
          //从发布委托入口进来，添加成功后刷新
          Get.find<SalesComissionController>().loadData();
        }
        if (Get.isRegistered<ComissionMethodController>()) {
          //从收款方式进来
          Get.find<ComissionMethodController>().fetchData();
        }
      }
    } on dio.DioException catch (e) {
      print("--${e.error}");
      UIUtil.showError(ObjectUtil.isEmpty(e.error) ? LocaleKeys.public55.tr : e.error);
    }
  }
}
