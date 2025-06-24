import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/my/settings/exchange_rate/views/exchange_rate_view.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/package_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../language_set/controllers/language_set_controller.dart';

class MySettingsController extends GetxController {
  TextEditingController accountControll = TextEditingController();
  TextEditingController passwordControll = TextEditingController();
  TextEditingController yzmControll = TextEditingController();
  bool passwordBool = false;
  bool isMobile = false;
  bool isLoading = false;

  void setIsLoading() {
    isLoading = !isLoading;
    update();
  }

  List<MenuEntry> entries(BuildContext context) {
    var assetsGetx = AssetsGetx.to;

    String rateCoin = assetsGetx.rateCoin;

    return [
      MenuEntry(
          name: LocaleKeys.user192.tr,
          behindName: '',
          icon: '',
          onTap: () {
            LanguageSetController.to.getLangList();
            Get.toNamed(Routes.LANGUAGE_SET);
          }),
      MenuEntry(
          name: LocaleKeys.user190.tr,
          behindName: rateCoin,
          icon: '',
          onTap: () {
            Get.to(
              ExchangeRateView(),
              transition: Transition.cupertino,
            );
            // Get.toNamed(Routes.LANGUAGE_SET);
          }),
    ];
  }

  List<MenuEntry> entriesTwo(BuildContext context) {
    return [
      MenuEntry(
          name: LocaleKeys.user193.tr,
          icon: '',
          onTap: () {
            Get.toNamed(Routes.WEBVIEW,
                arguments: {'url': LinksGetx.to.accountProtocol});
          }),
      PackageUtil.getPlatformCuNum() == 9
          ? MenuEntry(
              name: '设置代理',
              behindName: '',
              icon: '',
              onTap: () {
                Get.toNamed(Routes.SET_HTTPOVERRIDES);
              })
          : MenuEntry(),
    ];
  }

  @override
  void onInit() {
    accountControll.addListener(() {
      var text = accountControll.text;
      if (text != '' && UtilRegExp.isNumeric(text)) {
        isMobile = true;
      } else {
        isMobile = false;
      }
      update();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    accountControll.dispose();
    super.onClose();
  }
}
