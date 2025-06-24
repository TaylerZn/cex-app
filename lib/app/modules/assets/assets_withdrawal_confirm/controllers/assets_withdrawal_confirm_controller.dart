import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/safe_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_withdraw_result.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

class AssetsWithdrawalConfirmController extends GetxController {
  dynamic currency;
  dynamic amount;
  dynamic defaultFee;
  dynamic networkValue;
  dynamic address;

  AssetsWithdrawalConfirmController({
    required this.currency,
    required this.amount,
    required this.defaultFee,
    required this.networkValue,
    required this.address,
  });

  //TODO: Implement AssetsWithdrawalConfirmController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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

  void withdraw() async {
    var arguments = {
      'currency': currency,
      'amount': amount.toString(),
      'defaultFee': defaultFee,
      'networkValue': networkValue,
      'address': address,
    };

    SafeGetx.to.goIsSafe(
        isWithdrawal: true,
        onTap: (vData) async {
          var smsCode = vData['smsCode'];
          var googleCode = vData['googleCode'];
          var emailCode = vData['emailCode'];
          try {
            final AssetsWithdrawResult res = await AssetsApi.instance()
                .doWithdraw(currency, amount.toString(), address, smsCode,
                    googleCode, emailCode, networkValue);
            print(res);
            var arguments = {
              'currency': currency,
              'amount': amount.toString(),
            };
            AssetsGetx.to.getRefresh();
            Get.offNamed(Routes.ASSETS_WITHDRAWAL_RESULT,
                arguments: arguments);
          } on DioException catch (e) {
            print(e);
            Get.log('withdraw error: $e');
            UIUtil.showError(e.error);
          }
        });
  }
}
