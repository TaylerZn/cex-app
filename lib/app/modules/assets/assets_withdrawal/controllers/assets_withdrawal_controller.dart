import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/models/assets/assets_withdraw_config.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/kyc_dialog_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../widgets/dialog/my_bottom_dialog.dart';
import '../dialog/withdrawal_confirm_dialog.dart';

class AssetsWithdrawalController extends GetxController {
  RxString currency = ''.obs;

  RxString balance = ''.obs;

  RxDouble amount = 0.0.obs;

  RxString min = ''.obs;

  TextEditingController amountController = TextEditingController();

  RxBool showAmountOutError = false.obs;
  RxBool overDayLimit = false.obs;
  MyPageLoadingController loadingController = MyPageLoadingController();
  TextEditingController textController = TextEditingController();
  String withdrawMaxDayBalance = '0';
  num withdrawMaxDay = 0;
  num limMaxWithdraw = 0;
  num showPrecision = 0; //显示精度
  List networkList = [];
  int networkIndex = 0;
  String defaultFee = '0';
  FocusNode _editNode = FocusNode();

  String get networkValue => networkList.isNotEmpty
      ? networkList[networkIndex]
      : LocaleKeys.assets179.tr;

  bool get allowSubmit =>
      textController.value.text.isNotEmpty &&
      !showAmountOutError.value &&
      amount.value > 0;


  int get precision => num.tryParse(min.value)?.numDecimalPlaces() ?? 0;

  String get temp =>
      '${Decimal.parse(amountController.value.text.isEmpty ? '0' : amountController.value.text) - Decimal.parse(defaultFee)}'
          .toPrecision(precision);

  String get receiveAmount => temp;

  bool get inSufficient => amountController.text.isEmpty
      ? false
      : Decimal.parse(amountController.text) >
          Decimal.parse(balance.isEmpty ? '0' : balance.value);

  void setMax() {
    reloadBalance();
    amountController.text = balance.value.toPrecision(precision);
    amount.value = balance.value.toDecimal().toDouble();
  }

  Future<void> withdrawal(BuildContext context) async {
    if (amount.value > 0) {
      List<bool> list = [
        UserGetx.to.isSetMobile,
        UserGetx.to.isSetEmail,
        UserGetx.to.isGoogleVerify
      ];
      if (list.where((element) => element).length < 2) {
        UIUtil.showToast(LocaleKeys.assets210.tr); //请绑定至 少2项安全验证方式
        return;
      }

      /// 非USDT币种 在与提交按钮交互时 判断有无KYC 无KYC用老弹窗 如有KYC正常走2FA流程
      if (currency.value != 'USDT') {
        if (await UserGetx.to.goIsKyc()) {
          _showConfirmDialog();
        }
      } else {
        /// USDT 24H提币是否超过限制5000，超过则弹窗提示
        /// 每日最大提币 - 每日提币剩余额度 = 今日提币额度
        if (amount.value.toNum() > withdrawMaxDayBalance.toNum() &&
            !UserGetx.to.isKyc) {
          KycDialogUtil.showKycDialog(title: LocaleKeys.assets212.tr);
        } else {
          _showConfirmDialog();
        }
      }
    }
  }

  _showConfirmDialog() async {
    await showMyBottomDialog(
      Get.context!,
      AssetsWithdrawalConfirmDialog(
        network: networkValue,
        address: textController.text,
        amount: amountController.value.text,
        currency: currency.value,
        defaultFee: defaultFee,
        receiveAmount: receiveAmount,
      ),
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
    );
  }

  @override
  void onInit() {
    AssetSpotsAllCoinMapModel currencyData = AssetSpotsAllCoinMapModel();
    for (var item in AssetsGetx.to.assetSpotsList) {
      if (item.coinName == Get.arguments) {
        currencyData = item;
        break;
      }
    }
    currency.value = currencyData.coinName ?? '';
    balance.value = currencyData.normalBalance ?? '';
    min.value = '${currencyData.withdrawMin ?? 0}'; //  -> depositMin
    showPrecision = currencyData.showPrecision ?? 0; //补充精度处理
    // 这里后台配置的是0, 但是按prd 的USDT 默认 按2位处理
    // if (currencyData.coinName == 'USDT' && showPrecision == 0) {
    //   showPrecision = 2;
    // }
    amountController.addListener(() {
      amount.value =
          double.tryParse(amountController.text.removeAllWhitespace) ??
              0.0; //存在空格,原因待查,会崩溃.这里简单处理下
      if (amount.value > double.parse(balance.value) &&
          withdrawMaxDay > 0 &&
          withdrawMaxDay > amount.value) {
        showAmountOutError.value = true;
      } else {
        showAmountOutError.value = false;
      }
      if (amount.value > withdrawMaxDay && withdrawMaxDay > 0) {
        overDayLimit.value = true;
      } else {
        overDayLimit.value = false;
      }
      // 追加一个补丁: 限制不能超过  balance.value
      double balanceValue = double.tryParse(balance.value) ?? 0.0;
      if (amount.value > balanceValue) {
        overDayLimit.value = true;
      }
      update();
    });
    _editNode.addListener(() {});
    getSymbolsupportnets();
    getWithdrawConfig();
    update();
    reloadBalance();
    super.onInit();
  }

  void reloadBalance() {
    balance.value =
        '${AssetsGetx.to.getSpotCanUseBalance(coinName: currency.value)}';
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getSymbolsupportnets() async {
    try {
      var res = await AssetsApi.instance().symbolsupportnets(currency.value);
      networkList = res;

      loadingController.setSuccess();
      update();
    } on DioException catch (e) {
      UIUtil.showError(e.error);
      loadingController.setError();
      update();
      Get.log('getSymbolsupportnets error: $e');
    }
  }

  void getWithdrawConfig() async {
    try {
      final AssetsWithdrawConfig res =
          await AssetsApi.instance().getWithdrawConfig(currency.value);
      withdrawMaxDay = res.withdrawMaxDay!;
      withdrawMaxDayBalance = res.withdrawMaxDayBalance.toString();
      defaultFee = res.defaultFee;
      //补充一个限制提现最大值的赋值
      num balanceValue = num.tryParse(balance.value) ?? 0.0;
      limMaxWithdraw =
          withdrawMaxDay > balanceValue ? balanceValue : withdrawMaxDay;
    } catch (e) {
      Get.log('getWithdrawConfig error: $e');
    }
  }

  datLimitCheck() {
    if (amountController?.text != '') {
      amount.value = double.parse(amountController!.text);
    } else {
      amount.value = 0.0;
    }
  }

  @override
  void onClose() {
    amountController!.dispose();
    super.onClose();
  }
}
