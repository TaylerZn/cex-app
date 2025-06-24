import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/otc/b2c/widget/otc_open_bottom_dialog.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/main/controllers/customer_main_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';

import '../../../../../../generated/locales.g.dart';

enum MainViewType {
  quick,
  option,
  order,
  other;

  String get title => [
        LocaleKeys.otc2.tr,
        LocaleKeys.c2c190.tr,
        LocaleKeys.c2c145.tr,
        ''
      ][index];
}

class CustomerMainNav extends StatelessWidget {
  const CustomerMainNav(
      {super.key, required this.callback, required this.controller});
  final Function(int) callback;
  final CustomerMainController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.type.value.index < 2
        ? AppGuideView(
            order: 1,
            guideType: AppGuideType.c2c,
            child: GestureDetector(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.type.value.title,
                    style: AppTextStyle.f_16_500.color111111,
                  ).marginOnly(right: 3.w),
                  if (OtcConfigUtils().haveC2C && UserGetx.to.isLogin)
                    MyImage(
                      'otc/c2c/c2c_change'.svgAssets(),
                      width: 14.w,
                      height: 14.w,
                    ),
                ],
              ),
              onTap: () {
                if (OtcConfigUtils().haveC2C && UserGetx.to.isLogin) {
                  exchangeTradeBottomDialog(context,
                      title: LocaleKeys.c2c282.tr,
                      haveBottom: false,
                      callback: callback);
                }
              },
            ),
          )
        : Text(
            controller.type.value.title,
            style: AppTextStyle.f_16_500.color111111,
          ));
  }
}
