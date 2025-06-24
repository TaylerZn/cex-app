import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/config/config_api.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/config/check_version_res.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckAppUpdate {
  /// 检测版本更新并且自动弹窗
  static void autoCheck({isLatest = false, Function? onComplete}) {
    onlyCheckUpdate().then((value) {
      if (value != null) {
        var needUpdate = value['update'];
        CheckVersionV1Model updateData = value['model'];
        if (needUpdate) {
          //  appUpdateDialog(versionModel: updateData);
        } else {
          if (isLatest) {
            UIUtil.showToast(LocaleKeys.user233.tr);
          }
        }
        if (onComplete != null) {
          onComplete();
        }
      } else {
        if (isLatest) {
          UIUtil.showToast(LocaleKeys.user233.tr);
        }
        EasyLoading.dismiss();
      }
    });
  }

  /// 只检测版本更新不进行弹窗
  static Future<Map<String, dynamic>?> onlyCheckUpdate() async {
    CheckVersionV1Model? checkModel = await checkAppVersion();
    if (checkModel?.build != null) {
      bool needUpdate = true;
      return {'update': needUpdate, 'model': checkModel};
    } else {
      return null;
    }
  }
}

//检查版本更新
Future<CheckVersionV1Model?> checkAppVersion() async {
  try {
    CheckVersionV1Model? res =
        await ConfigApi.instance().checkVersionV1('${MyTimeUtil.now()}');

    return res;
  } catch (e) {
    return null;
  }
}

void appUpdateDialog({CheckVersionV1Model? versionModel}) {
  var isMaybeUpdate = (versionModel?.forceUpdate ?? 0) == 0;
  Get.dialog(
      barrierDismissible: isMaybeUpdate,
      GestureDetector(
        onTap: () {
          if (isMaybeUpdate) Get.back();
        },
        child: Material(
          color: Colors.transparent,
          child: Center(
              child: Stack(clipBehavior: Clip.none, children: [
            Container(
                clipBehavior: Clip.none,
                width: 247.w,
                padding: EdgeInsets.fromLTRB(24.w, 90.h, 24.w, 20.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColor.colorWhite),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleKeys.user234.tr,
                      style: AppTextStyle.f_18_600,
                    ),
                    2.verticalSpace,
                    Text(
                      '${LocaleKeys.user235.tr} ${versionModel?.version ?? ''}',
                      style: AppTextStyle.f_14_400.color666666,
                    ),
                    20.verticalSpace,
                    Container(
                      width: Get.width,
                      constraints: BoxConstraints(maxHeight: 300.h),
                      child: SingleChildScrollView(
                        child: Text(
                          versionModel?.content ?? '',
                          style: AppTextStyle.f_14_400.color666666,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    MyButton(
                      height: 44.h,
                      text: LocaleKeys.user236.tr,
                      onTap: () async {
                        if (!await launchUrl(
                            Uri.parse(versionModel?.downloadUrl ?? ''),
                            mode: LaunchMode.externalApplication)) {
                          print('error---- app update');
                        }
                      },
                    )
                    // InkWell(

                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     height: 44.h,
                    //     decoration: BoxDecoration(
                    //         color: Color(0xff01E785),
                    //         borderRadius: BorderRadius.circular(6.w)),
                    //     child: Text(
                    //       '马上更新',
                    //       style: MyDefaultFontStyle.copyWith(
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 16.sp,
                    //           color: Color(0xff111111)),
                    //     ),
                    //   ),
                    // )
                  ],
                )),
            Positioned(
              top: -41.h,
              left: 0.w,
              right: 0,
              child: MyImage(
                'home/update_bg'.svgAssets(),
                width: 140.w,
              ),
            ),
          ])),
        ),
      ));
}
