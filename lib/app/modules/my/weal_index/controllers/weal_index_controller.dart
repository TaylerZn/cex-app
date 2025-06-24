import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/modules/my/widgets/Kyc_Info_Page.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/system_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WealIndexController extends GetxController {
  String title = LocaleKeys.other49;
  String url = '';

  late WebViewController controller;
  var progress = 0.obs;
  RxBool isLoading = true.obs;
  final key = UniqueKey();
  bool canReload = false;
  @override
  void onInit() {
    super.onInit();

    url = Get.arguments?['url'] ?? BestApi.getApi().welfareUrl;

    title = Get.arguments?['title'] ?? LocaleKeys.other49;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.colorBlack)
      ..setUserAgent('BITCOCO')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) async {
            this.progress.value = progress;
          },
          onPageStarted: (url) {
            // controller.runJavaScriptReturningResult('navigator.userAgent').then((value) {
            // if (Platform.isIOS) {
            // controller.setUserAgent('$value BITCOCO');
            // } else {
            //   controller.runJavaScript('navigator.__defineGetter__("userAgent", function(){ return "$value BITCOCO"; });');
            // }
            // });
          },
          onPageFinished: (url) {
            isLoading.value = false;

            // SystemUtil.commonHeaderParams().then((value) {
            //   if (UserGetx.to.isLogin) {
            //     var token = UserGetx.to.user?.token;
            //     value["exchange-token"] = "$token";
            //   }
            //   controller.runJavaScript('receiveAppParams(${jsonEncode(value)});');
            // });
          },
        ),
      )
      ..addJavaScriptChannel('AppChannel', onMessageReceived: (JavaScriptMessage receiver) => receiverMessage(receiver.message))
      ..loadRequest(Uri.parse(url));
  }

// 1 打开登录
// 2 打开交易
// 3 打开认证 kyc
// 4 打开充值
// 5 打开 c2c
// 6 打开 卡券
// 7 跟单风险评估
// 8 kyc审核中

  receiverMessage(String message) async {
    Map json = jsonDecode(message);
    num type = json['type'];
    canReload = false;
    switch (type) {
      case 1: //登录
        canReload = true;
        await Get.toNamed(Routes.LOGIN);
        // controller.reload();
        break;
      case 2:
        goToTrade(0, contractInfo: CommodityDataStoreController.to.getContractInfoByContractId(1));
        break;
      case 3:
        canReload = true;
        await Get.toNamed(Routes.KYC_INDEX);
        // controller.reload();

        break;
      case 4:
        canReload = true;
        await Get.toNamed(Routes.CURRENCY_SELECT, arguments: {'type': AssetsCurrencySelectEnumn.depoit});
        // controller.reload();

        break;
      case 5:
        RouteUtil.goTo('/otc-c2c');
        break;
      case 6:
        RouteUtil.goTo('/coupon_center');
        break;
      case 7:
        canReload = true;
        await Get.toNamed(Routes.FOLLOW_QUESTIONNAIRE);
        // controller.reload();
        break;
      case 8:
        Get.to(KycInfoPage());
        break;
      case 9:
        SystemUtil.commonHeaderParams().then((value) {
          if (UserGetx.to.isLogin) {
            var token = UserGetx.to.user?.token;
            value["exchange-token"] = "$token";
          }
          controller.runJavaScript('receiveAppParams(${jsonEncode(value)});');
        });
        break;

      default:
    }
  }
}
