import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/enums/login.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_charge_address.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_log_event_name.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_manager.dart';
import 'package:nt_app_flutter/app/utils/utilities/file_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_network_select.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_dialog.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:screenshot/screenshot.dart';

class AssetsDepositController extends GetxController {
  //TODO: Implement CurrencySelectController

  MyPageLoadingController loadingController = MyPageLoadingController();
  ScreenshotController controller = ScreenshotController();

  List networkList = [];

  int networkIndex = 0;

  String get networkValue =>
      networkList.isNotEmpty ? networkList[networkIndex] : '';

  String? address = '';

  String? addressQR = '';

  String currency = '';

  String depositMinStr = '0';

  Uint8List? bytes;
  bool isFirstAutoExecuteOnTap = false;
  var isDialogShown = false.obs;

  @override
  void onReady() {
    super.onReady();
    currency = Get.arguments ?? Get.parameters['symbol'] ?? '';
    //最小投资额
    depositMinStr = AssetsGetx.to.getMinDepositAmount(currency).toString();
    getSymbolsupportnets();
  }

  // 新添加的方法，包含了 onTap 方法中的所有操作
  void autoExecuteOnTap(BuildContext context) async {
    var res = await showMyBottomDialog(
      context,
      AssetsNetworkSelect(
        list: networkList,
        value: networkValue,
        isDeposit: true,
      ),
    );
    if (res != null) {
      EasyLoading.show();
      networkIndex = res;
      await getChargeAddress();
      EasyLoading.dismiss();
      update();
    }
  }

  void getSymbolsupportnets() async {
    try {
      var res = await AssetsApi.instance().symbolsupportnets(currency);
      networkList = res;

      if (networkList.isNotEmpty) {
        getChargeAddress();
      } else {
        loadingController.setSuccess();
        update();
      }
    } on DioException catch (e) {
      UIUtil.showError(e.error);
      loadingController.setError();
      update();
    }
  }

  //获取充值地址
  getChargeAddress() async {
    try {
      if(networkValue.contains('ERC20')) {
        AppsFlyerManager().logEvent(AFLogEventName.recharge_erc20);
      } else if(networkValue.contains('TRC20')) {
        AppsFlyerManager().logEvent(AFLogEventName.recharge_trc20);
      }  else if(networkValue.contains('BEP20')) {
        AppsFlyerManager().logEvent(AFLogEventName.recharge_bep20);
      } else if(networkValue.contains('Polygon')) {
        AppsFlyerManager().logEvent(AFLogEventName.recharge_polygon);
      }
      AssetsChargeAddress? res =
          await AssetsApi.instance().getChargeAddress(currency, networkValue);
      if (res != null) {
        address = res.addressStr;
        addressQR = res.addressQrCode;
        if (res.addressQrCode != null) {
          bytes = await MyFileUtil.parseBase64(res.addressQrCode);
        }
        loadingController.setSuccess();
      }
      if (!isFirstAutoExecuteOnTap) {
        autoExecuteOnTap(Get.context!); // 在页面加载完成后自动执行
        isFirstAutoExecuteOnTap = true;
      }

      update();
    } on DioException catch (e) {
      UIUtil.showError(e.error);
      loadingController.setError();
      update();
    }
  }

  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
