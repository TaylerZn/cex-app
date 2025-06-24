import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/trades/controllers/trades_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssetsSpotsController extends GetxController {
  final RefreshController refreshController = RefreshController();
  TextEditingController textEditSearch = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final actions = [
    LocaleKeys.assets52,
    LocaleKeys.assets53,
    LocaleKeys.assets7,
    LocaleKeys.trade289
  ];
  void actionHandler(val) async {
    switch (val) {
      case 0:
        {
          Get.toNamed(Routes.CURRENCY_SELECT,
              arguments: {'type': AssetsCurrencySelectEnumn.depoit});
        }
        break;
      case 1:
        {
          // if (await UserGetx.to.goIsKyc() == true) {
          //   Get.toNamed(Routes.CURRENCY_SELECT,
          //       arguments: {'type': AssetsCurrencySelectEnumn.withdraw});
          // }
          RouteUtil.goTo('/withdraw', requireLogin: true);
        }
        break;
      case 2:
        {
          try {
            final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER,
                arguments: {"from": 3, "to": 0});
            if (res) {
              UIUtil.showSuccess(LocaleKeys.assets10.tr);
              AssetsGetx.to.getTotalAccountBalance();
            }
          } catch (e) {
            print(e);
          }
        }
        break;
      case 3:
        {
          Get.find<MainTabController>().changeTabIndex(2); //.login(user);
          Get.find<TradesController>().onTabChange(TradeIndexType.immediate);
        }
        break;
    }
  }

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
}
