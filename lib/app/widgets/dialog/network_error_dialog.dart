import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

bool isShowing = false;

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({super.key});

  static show() async {
    if (isShowing) return;
    isShowing = true;

    final res = await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const NetworkErrorDialog(),
      ),
    );
    isShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 238.w,
      padding: EdgeInsets.all(10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          6.verticalSpace,
          MyImage(
            'default/network_error_dialog'.svgAssets(),
            width: 50.w,
            height: 50.w,
          ),
          16.verticalSpace,
          Text(
            LocaleKeys.public58.tr,
            style: AppTextStyle.f_12_400.color666666,
            textAlign: TextAlign.left,
          ),
          16.verticalSpace,
          MyButton(
            text: LocaleKeys.public57.tr,
            height: 44.h,
            onTap: () {
              AppSettings.openAppSettings(type: AppSettingsType.wifi);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
