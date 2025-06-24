import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_apply_info.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_public_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/dialog/deposit_dialog.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/kyc_check_dialog.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

class MerchantApplyController extends GetxController {
  OtcApplyInfo? applyInfo;
  var pageController = PageController(viewportFraction: 0.92);
  var pageOffset = 0.0.obs;
  var currentIndex = 0.obs;

  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();
  final SwiperController swiperController = SwiperController();
  List<ApplyMerchantModel> merchantTypeList = [];
  @override
  void onInit() {
    super.onInit();
    merchantTypeList = OtcConfigUtils().applyMerchantListModel;

    pageController.addListener(() {
      pageOffset.value = (pageController.page ?? 0.0);
      currentIndex.value = pageController.page?.round() ?? 0;
    });
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  Future<void> loadData() async {
    EasyLoading.show();
    applyInfo = await OtcApi.instance().applyInfo();
    merchantTypeList.forEach((element) {
      element.getButtonState(applyInfo?.otcStatus, amount: applyInfo?.amountStr, merchantType: applyInfo?.merchantType);
    });
    EasyLoading.dismiss();

    update();
  }

  performCase() {
    var state = applyInfo?.otcStatus;
    switch (state) {
      case OTCApplyStatus.fillForm:
        fillForm();
      case OTCApplyStatus.payDeposit:
        payDeposit(0);
        break;

      case OTCApplyStatus.verifySucces:
        payDeposit(1);
        break;
      default:
    }
  }

  Future<void> fillForm() async {
    try {
      EasyLoading.show();
      await UserGetx.to.getRefresh();
      EasyLoading.dismiss();

      if (!UserGetx.to.isKyc) {
        await showKycDialog();
        return;
      }

      await Get.toNamed(Routes.CUSTOMER_APPLY, arguments: {'type': currentIndex.value});
      loadData();
    } on dio.DioException catch (e) {
      UIUtil.showError('${e.error}');
    }
  }

  Future<void> payDeposit(int type) async {
    //0：缴费 1:取回
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return DepositDialog(type: type, applyInfo: applyInfo, controller: this);
      },
    );
    loadData();
  }

  Future<void> showKycDialog() async {
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return const KYCCheckDialog();
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
