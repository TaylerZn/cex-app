import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/third_login/third_login.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/third_login/third_login_info_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/third_login_utils.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_large_list.dart';
import 'package:nt_app_flutter/app/widgets/dialog/tips_change_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ThirdAccountController extends GetxController {
  var isBindApple = "".obs;
  var isBindGoogle = "".obs;
  var isBindTelegram = "".obs;

  ThirdLoginInfoModel? bingInfo;
  @override
  void onInit() {
    getInfo();
    super.onInit();
  }

  getInfo() async {
    EasyLoading.show();
    try {
      bingInfo = await ThirdLoginApi.instance().bindInfo();
      isBindApple.value = bingInfo?.apple?.userAccount ?? "";
      isBindGoogle.value = bingInfo?.google?.userAccount ?? "";
      isBindTelegram.value = bingInfo?.telegram?.userAccount ?? "";
      EasyLoading.dismiss();
    } on DioException catch (e) {
      UIUtil.showError('${e.error}');
      EasyLoading.dismiss();
    } catch (e) {
      AppLogUtil.e(e);
      EasyLoading.dismiss();
    }
  }

  List<MenuLargeEntry> entriesOne(BuildContext context) {
    return [
      MenuLargeEntry(
        name: "Apple ID",
        icon: 'default/third_apple'.svgAssets(),
        iconSize: 21.w,
        content: isBindApple.value != ""
            ? isBindApple.value.accountMask()
            : LocaleKeys.user344.tr,
        behindName: isBindApple.value != ""
            ? LocaleKeys.user345.tr
            : LocaleKeys.user346.tr,
        behindNameColor: isBindApple.value != ""
            ? AppColor.colorD29102
            : AppColor.color0C0D0F,
        behindbgColor: isBindApple.value != "" ? null : AppColor.colorF3F3F5,
        goIcon: false,
        onTap: () {
          isBindApple.value != ""
              ? TipsChangeDialog.show(
                  title: LocaleKeys.user347.trArgs(['Apple']),
                  content: LocaleKeys.user348.tr,
                  email: isBindApple.value.accountMask(),
                  isContentCenter: true,
                  okTitle: LocaleKeys.trade98.tr,
                  cancelTitle: LocaleKeys.trade99.tr,
                  onOk: () {
                    ThirdLoginUtils.unbind("Apple", isBindApple.value, () {
                      getInfo();
                    });
                  },
                )
              : ThirdLoginUtils.thirdLogin(1, isBind: true).then((value) {
                  if (value != null && value != "") {
                    ThirdLoginUtils.bind("Apple", value, () {
                      getInfo();
                    });
                  }
                });
        },
      ),
      MenuLargeEntry(
        name: "Google",
        icon: 'default/third_google'.svgAssets(),
        iconSize: 21.w,
        content: isBindGoogle.value != ""
            ? isBindGoogle.value.accountMask()
            : LocaleKeys.user344.tr,
        behindName: isBindGoogle.value != ""
            ? LocaleKeys.user345.tr
            : LocaleKeys.user346.tr,
        behindNameColor: isBindGoogle.value != ""
            ? AppColor.colorD29102
            : AppColor.color0C0D0F,
        behindbgColor: isBindGoogle.value != "" ? null : AppColor.colorF3F3F5,
        goIcon: false,
        onTap: () {
          isBindGoogle.value != ""
              ? TipsChangeDialog.show(
                  title: LocaleKeys.user347.trArgs(['Google']),
                  content: LocaleKeys.user348.tr,
                  email: isBindGoogle.value.accountMask(),
                  isContentCenter: true,
                  okTitle: LocaleKeys.trade98.tr,
                  cancelTitle: LocaleKeys.trade99.tr,
                  onOk: () {
                    ThirdLoginUtils.unbind("Google", isBindGoogle.value, () {
                      getInfo();
                    });
                  },
                )
              : ThirdLoginUtils.thirdLogin(2, isBind: true).then((value) {
                  if (value != null && value != "") {
                    ThirdLoginUtils.bind("Google", value, () {
                      getInfo();
                    });
                  }
                });
        },
      ),
      // MenuLargeEntry(
      //   name: "Telegram",
      //   icon: 'default/third_tg'.svgAssets(),
      //   iconSize: 21.w,
      //   content: isBindTelegram.value != ""
      //       ? isBindTelegram.value.accountMask()
      //       : LocaleKeys.user344.tr,
      //   behindName: isBindTelegram.value != ""
      //       ? LocaleKeys.user345.tr
      //       : LocaleKeys.user346.tr,
      //   behindNameColor: isBindTelegram.value != ""
      //       ? AppColor.colorD29102
      //       : AppColor.color0C0D0F,
      //   behindbgColor: isBindTelegram.value != "" ? null : AppColor.colorF3F3F5,
      //   goIcon: false,
      //   onTap: () {
      //     // isBindTelegram.value != ""
      //     //     ? TipsChangeDialog.show(
      //     //         title: LocaleKeys.user347.trArgs(['Telegram']),
      //     //         content: LocaleKeys.user348.tr,
      //     //         email: "",
      //     //         isContentCenter: true,
      //     //         okTitle: LocaleKeys.trade98.tr,
      //     //         cancelTitle: LocaleKeys.trade99.tr,
      //     //         onOk: () {
      //     //           ThirdLoginUtils.unbind("Telegram", isBindTelegram.value,
      //     //               () {
      //     //             getInfo();
      //     //           });
      //     //         },
      //     //       )
      //     //     :
      //     ThirdLoginUtils.thirdLogin(3, isBind: true).then((value) {
      //       if (value != null && value != "") {
      //         ThirdLoginUtils.bind("Temegram", value, () {
      //           getInfo();
      //         });
      //       }
      //     });
      //   },
      // ),
    ];
  }
}
