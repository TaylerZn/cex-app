import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/file/file.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_apply_info.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_public_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/bean/input_bean.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/dialog/deposit_dialog.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/widget/content_option_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/kyc_check_dialog.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:vm_service/vm_service.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../api/file/file_interface.dart';
import '../../../../../routes/app_pages.dart';
import '../../home/model/customer_model.dart';
import '../../utils/otc_config_utils.dart';

class CustomerApplyController extends GetxController {
  //TODO: Implement CustomerOrderController
  InputBean? inputBean;

  int imageMax = 3;
  int applyStage = 0;
  OtcApplyInfo? applyInfo;
  final ValueNotifier<bool> isVisible = ValueNotifier<bool>(true);
  RxBool stat = RxBool(false);
  int? merchantType;
  @override
  void onInit() {
    super.onInit();
    merchantType = Get.arguments?['type'];
    loadForm(0);
  }

  @override
  void onReady() {
    super.onReady();
    // loadData();
  }

  void loadForm(int index) {
    rootBundle.loadString(index == 0 ? 'assets/json/market_apply.json' : 'assets/json/no_market_apply.json').then((value) {
      InputBean? bean;
      if (ObjectUtil.isNotEmpty(inputBean)) {
        bean = InputBean.fromJson(inputBean!.toJson());
      }
      inputBean = inputBeanFromJson(value);
      inputBean?.data?.forEach((element) {
        if (element.key == 'applyMerchantType') {
          element.optionList = OtcConfigUtils().applyMerchantList;
          if (merchantType != null) {
            element.value = merchantType.toString();
          }
        }
        bean?.data?.forEach((t) {
          if (element.key == t.key) {
            element.value = t.value;
          }
        });
      });
      update();
    });
  }

  Future<void> loadData() async {
    EasyLoading.show();
    applyInfo = await OtcApi.instance().applyInfo();
    EasyLoading.dismiss();

    if (applyInfo?.otcStatus == OTCApplyStatus.verifying) {
      applyStage = 1;
    }

    if (applyInfo?.otcStatus == OTCApplyStatus.verifySucces || applyInfo?.otcStatus == OTCApplyStatus.revoking) {
      applyStage = 2;
    }

    update();
  }

  Future<void> validateForm() async {
    bool completed = true;
    InputBean? bean = inputBean;
    Map<String, dynamic> params = {};
    List<AssetEntity?> images = [];

    inputBean?.data?.forEach((element) {
      element.showError = false;
      element.match = true;

      if (element.mandatory == true && element.empty()) {
        element.showError = true;
        completed = false;
        return;
      }

      if (element.fillType == ContentFillType.input &&
          ObjectUtil.isNotEmpty(element.value) &&
          ObjectUtil.isNotEmpty(element.regex)) {
        if (!element.matchValue()) {
          element.match = false;
          element.showError = true;
          completed = false;
        }
      }

      if (element.key == 'isOtherPlatformMerchant' || element.key == 'applyMerchantType') {
        params[element.key!] = int.parse(element.value!);
      } else {
        params[element.key!] = element.value;
      }
      if (element.fillType == ContentFillType.image) {
        images = element.images ?? [];
      }
    });

    update();
    if (!completed) {
      return;
    }
    List<String> uploadImageUrl = [];

    EasyLoading.show();
    await Future.forEach((images), (temp) async {
      try {
        File? file = await temp?.file;
        CommonuploadimgModel? data = await commonuploadimg(file!);
        uploadImageUrl.add('${data?.baseImageUrl}${data?.filename}');
      } on dio.DioException catch (e) {
        UIUtil.showError(e.message ?? LocaleKeys.public55.tr);
      }
    });
    params['otherPlatformAccountImages'] = uploadImageUrl;

    try {
      bool? response = await OtcApi.instance().applyC2C(
          isOtherPlatformMerchant: params['isOtherPlatformMerchant'],
          applyMerchantType: params['applyMerchantType'],
          phone: params['phone'],
          email: params['email'],
          otherPlatformAccountImages: uploadImageUrl,
          otherPlatformName: params['otherPlatformName'] ?? '',
          tgAccount: params['tgAccount'],
          twitterAccount: params['twitterAccount'],
          discordAccount: params['discordAccount']);
      EasyLoading.dismiss();
      if (response == null) {
        Future.delayed(Duration(milliseconds: 300)).then((value) {
          Get.back();
        });
      }
    } on dio.DioException catch (e) {
      UIUtil.showError(e.error ?? LocaleKeys.public55.tr);
    }
  }

  Future<void> payDeposit(int type) async {
    //0：缴费 1:取回
    // await showModalBottomSheet(
    //   context: Get.context!,
    //   isScrollControlled: true,
    //   useSafeArea: true,
    //   builder: (BuildContext context) {
    //     return DepositDialog(type: type, applyInfo: applyInfo);
    //   },
    // );
    // loadData();
  }

  Future<void> performCase() async {
    try {
      EasyLoading.show();
      await UserGetx.to.getRefresh();
      EasyLoading.dismiss();

      if (!UserGetx.to.isKyc) {
        await showKycDialog();
        return;
      }

      if (applyInfo?.otcStatus == OTCApplyStatus.payDeposit) {
        payDeposit(0);
        return;
      }

      await Get.toNamed(Routes.CUSTOMER_APPLY);
      loadData();
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
  }

  Future<void> showKycDialog() async {
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return KYCCheckDialog();
      },
    );
  }

  Future<dynamic> reqDepositPayment(Map<String, dynamic> params) async {
    EasyLoading.show();
    dynamic response;

    try {
      response = await OtcApi.instance()
          .bondDeposit(smsCode: params['smsCode'], emailCode: params['emailCode'], googleCode: params['googleCode']);
      EasyLoading.dismiss();
      return response;
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
      return '';
    }

    return response;
  }

  Future<dynamic> reqRefundPayment(Map<String, dynamic> params) async {
    EasyLoading.show();
    dynamic response;
    try {
      response = await OtcApi.instance()
          .refundDeposit(smsCode: params['smsCode'], emailCode: params['emailCode'], googleCode: params['googleCode']);
      EasyLoading.dismiss();
      return response;
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
      return '';
    }
    EasyLoading.dismiss();
    return response;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
