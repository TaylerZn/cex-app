import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssetsFundsController extends GetxController {
  final RefreshController refreshController = RefreshController();
  TextEditingController textEditSearch = TextEditingController();
  final FocusNode focusNode = FocusNode();

  // TODO:暂时隐藏，后期扩展AssetsAction
  var actions = [LocaleKeys.assets144, LocaleKeys.assets145, LocaleKeys.assets7];
  void actionHandler(val) async {
    if (OtcConfigUtils().haveC2C) {
      if (val == 0) {
        RouteUtil.goTo('/otc-b2c');
      } else if (val == 1) {
        RouteUtil.goTo('/otc-c2c');
      } else if (val == 2) {
        try {
          final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {"from": 3, "to": 4});
          if (res) {
            UIUtil.showSuccess(LocaleKeys.assets10.tr);
            AssetsGetx.to.getTotalAccountBalance();
          }
        } catch (e) {
          print(e);
        }
      }
    } else {
      if (val == 0) {
        RouteUtil.goTo('/otc-b2c');
      } else if (val == 1) {
        try {
          final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {"from": 3, "to": 4});
          if (res) {
            UIUtil.showSuccess(LocaleKeys.assets10.tr);
            AssetsGetx.to.getTotalAccountBalance();
          }
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    actions = OtcConfigUtils().haveC2C
        ? [LocaleKeys.assets144, LocaleKeys.assets145, LocaleKeys.assets7]
        : [LocaleKeys.assets144, LocaleKeys.assets7];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
