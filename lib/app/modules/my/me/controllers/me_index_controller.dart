import 'package:extended_image/extended_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/my_shield_enum.dart';
import 'package:nt_app_flutter/app/modules/my/widgets/Me_About_Us.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/package_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_list.dart';
import 'package:nt_app_flutter/app/widgets/dialog/app_update_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MeIndexController extends GetxController {
  RefreshController refreshController = RefreshController();
  var touchedIndex = -1.obs;
  var showBool = false.obs;

  List<MenuEntry> entries(context) {
    var isUpdateApp = false;
    return [
      UserGetx.to.isLogin
          ? MenuEntry(
              name: LocaleKeys.user82.tr,
              nameColor: AppColor.color111111,
              behindName: '',
              icon: 'my/t_account'.svgAssets(),
              onTap: () {
                Get.toNamed(Routes.MY_SAFE);
              })
          : MenuEntry(),
      UserGetx.to.isLogin
          ? MenuEntry(
              name: LocaleKeys.user35.tr,
              nameColor: AppColor.color111111,
              behindName: '',
              icon: 'my/t_invite'.svgAssets(),
              bottomBorder: false,
              onTap: () {
                Get.toNamed(Routes.MY_INVITE);
              })
          : MenuEntry(),
      MenuEntry(
          name: LocaleKeys.user83.tr,
          nameColor: AppColor.color111111,
          behindName: '',
          icon: 'my/t_setting'.svgAssets(),
          bottomBorder: false,
          onTap: () async {
            Get.toNamed(Routes.MY_SETTINGS_INDEX);
          }),
      MenuEntry(
          name: LocaleKeys.user85.tr,
          nameColor: AppColor.color111111,
          behindName: '',
          icon: 'my/t_customer_service'.svgAssets(),
          bottomBorder: false,
          onTap: () {
            Get.toNamed(Routes.WEBVIEW,
                arguments: {'url': LinksGetx.to.onlineServiceProtocal});
          }),
      MenuEntry(
          name: LocaleKeys.user84.tr,
          nameColor: AppColor.color111111,
          behindName: '',
          icon: 'my/t_help'.svgAssets(),
          bottomBorder: false,
          onTap: () {
            Get.toNamed(Routes.WEBVIEW,
                arguments: {'url': LinksGetx.to.helpCenter});
          }),
      MenuEntry(
          name: LocaleKeys.user92.tr,
          nameColor: AppColor.color111111,
          behindName: '',
          icon: 'my/t_request'.svgAssets(),
          bottomBorder: false,
          onTap: () {
            Get.toNamed(
              Routes.REPORT,
            );
          }),
      MenuEntry(
          name: LocaleKeys.user93.tr,
          nameColor: AppColor.color111111,
          behindName: '',
          icon: 'my/t_blacklist'.svgAssets(),
          bottomBorder: false,
          onTap: () {
            Get.toNamed(Routes.MY_TAKE_BLOCK,
                arguments: {'type': MyTakeShieldActionType.blacklist});
          }),

      MenuEntry(
          name: LocaleKeys.user94.tr,
          nameColor: AppColor.color111111,
          behindName: '',
          icon: 'my/t_about'.svgAssets(),
          bottomBorder: false,
          onTap: () {
            Get.to(MeAboutUs());
          }),
      // MenuEntry(
      //     name: '线路切换',
      //     nameColor: AppColor.color111111,
      //     behindName: '',
      //     icon: 'my/t_line'.svgAssets(),
      //     bottomBorder: false,
      //     onTap: () {
      //       UIUtil.showToast('功能暂未开放');
      //     }),
      MenuEntry(
          name: LocaleKeys.user95.tr,
          icon: 'my/t_updates'.svgAssets(),
          nameColor: AppColor.color111111,
          behindName: 'V${PackageUtil.versionCode}',
          showNewPoint: isUpdateApp,
          onTap: () {
            EasyLoading.show();
            CheckAppUpdate.autoCheck(
                isLatest: true,
                onComplete: () {
                  EasyLoading.dismiss();
                });
          },
          bottomBorder: false),
      MenuEntry(
          name: LocaleKeys.user96.tr,
          nameColor: AppColor.color111111,
          behindName: '',
          icon: 'my/t_clear_cache'.svgAssets(),
          bottomBorder: false,
          onTap: () {
            UIUtil.showConfirm(LocaleKeys.user97.tr, confirmHandler: () {
              EasyLoading.show();
              clearMemoryImageCache();
              getMemoryImageCache();
              clearAllHistory();
              EasyLoading.dismiss();
              Get.back();
              UIUtil.showSuccess(
                LocaleKeys.user98.tr,
              );
            });
          }),
    ];
  }

  clearAllHistory() {
    ListKV.mainSearchHistory.clear();
    ListKV.marketSearchHistory.clear();
  }

  @override
  void onInit() {
    UserGetx.to.getRefresh();
    super.onInit();
  }
}
