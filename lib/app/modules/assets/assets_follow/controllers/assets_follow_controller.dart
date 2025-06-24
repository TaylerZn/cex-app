import 'dart:async';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../main_tab/controllers/main_tab_controller.dart';

class AssetsFollowController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<String> actions = [];
  // final kolActions = [LocaleKeys.assets46, LocaleKeys.assets7];
  Timer? timer;

  void actionHandler(val) async {
    if (val == 0) {
      MainTabController.to.changeTabIndex(3);
    } else if (val == 1) {
      try {
        final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {"from": 3, "to": 0});
        if (res) {
          UIUtil.showSuccess(LocaleKeys.assets10.tr);
          AssetsGetx.to.getTotalAccountBalance();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    actions = UserGetx.to.isKol ? [LocaleKeys.assets46, LocaleKeys.assets7] : [LocaleKeys.assets45, LocaleKeys.assets7];
  }

  @override
  void onReady() {
    super.onReady();
    fetchData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchData() {
    if (!UserGetx.to.isLogin || !UserGetx.to.isOpenContract) return;
    timer?.cancel();
    AssetsGetx.to.getFollowInfo();
    AssetsGetx.to.getTotalAccountBalance();
    timer = Timer.periodic(const Duration(seconds: contractTimerDurationSec), (timer) {
      AssetsGetx.to.getFollowInfo();
    });
  }
}
