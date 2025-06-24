import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/dialog/dialog_topWidget.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_bottom_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

Future otcBottomDialog(context,
    {String? title, bool haveBottom = true, Function(int)? callback}) async {
  return showMyBottomDialog(
      context,
      padding: EdgeInsets.fromLTRB(16.w, 19.h, 16.w, 16.h),
      Column(
        children: [
          // dialogTopWidget(title ?? '选择充币方式', ''),
          // otcBottomDialogItem('otc/open_b2c', '快捷买币', '使用Visa，万事达卡等支付方式购买加密货币', () {
          //   if (callback != null) {
          //     callback.call(0);
          //   } else {
          //     //
          //   }
          // }),
          // otcBottomDialogItem('otc/open_c2c', 'OTC交易', '灵活选择、100+收入方式、0手续费', () {
          //   if (callback != null) {
          //     callback.call(1);
          //   } else {
          //     //
          //   }
          // }),
          // haveBottom ? otcBottomDialogItem('otc/open_deposit', '充入数字货币', '从链上钱包或交易所转入数字货币', () {}) : const SizedBox(),

          dialogTopWidget(title ?? LocaleKeys.otc8.tr, ''),
          otcBottomDialogItem(
              'otc/open_b2c', LocaleKeys.otc2.tr, LocaleKeys.otc3.tr, () {
            if (callback != null) {
              callback.call(0);
            } else {
              RouteUtil.goTo('/otc-b2c');
            }
          }),
          if (OtcConfigUtils().haveC2C)
            otcBottomDialogItem(
                'otc/open_c2c', LocaleKeys.other35.tr, LocaleKeys.otc5.tr, () {
              if (callback != null) {
                callback.call(1);
              } else {
                RouteUtil.goTo('/otc-c2c');
              }
            }),
          haveBottom
              ? otcBottomDialogItem(
                  'otc/open_deposit', LocaleKeys.otc6.tr, LocaleKeys.otc7.tr,
                  () {
                  Get.toNamed(Routes.CURRENCY_SELECT,
                      arguments: {'type': AssetsCurrencySelectEnumn.depoit});
                })
              : const SizedBox(),
        ],
      ));
}

Widget otcBottomDialogItem(
    String svgUrl, String title, String content, GestureTapCallback? onTap) {
  return InkWell(
      onTap: throttle(() async {
        Get.back();
        if (onTap != null) {
          onTap();
        }
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1, color: AppColor.colorEEEEEE)),
        child: Row(
          children: [
            MyImage(
              svgUrl.svgAssets(),
              width: 24.w,
            ),
            15.horizontalSpace,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.f_16_500,
                ),
                4.verticalSpace,
                Text(
                  content,
                  style: AppTextStyle.f_12_400.color666666,
                )
              ],
            ))
          ],
        ),
      ));
}

Future exchangeTradeBottomDialog(context,
    {String? title, bool haveBottom = true, Function(int)? callback}) async {
  return showMyBottomDialog(
      context,
      padding: EdgeInsets.fromLTRB(16.w, 19.h, 16.w, 16.h),
      Column(
        children: [
          dialogTopWidget(title ?? LocaleKeys.otc8.tr, ''),
          otcBottomDialogItem(
              'otc/open_b2c', LocaleKeys.otc2.tr, LocaleKeys.otc3.tr, () {
            if (callback != null) {
              callback.call(0);
            } else {
              Get.toNamed(Routes.B2C);
            }
          }),
          otcBottomDialogItem(
              'otc/open_c2c', LocaleKeys.other35.tr, LocaleKeys.otc5.tr, () {
            if (callback != null) {
              callback.call(1);
            } else {
              RouteUtil.goTo('/otc-c2c');
            }
          }),
        ],
      ));
}
