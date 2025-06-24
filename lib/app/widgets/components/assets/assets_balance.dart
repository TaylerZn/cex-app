import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_exchange_rate.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_eyes.dart';

class AssetsBalance extends StatelessWidget {
  final String title;
  final String balance;
  final AssetsTabEnumn? tabType;
  final TextStyle? titleStyle;
  final bool newStyle;

  const AssetsBalance(
      {super.key,
      this.title = '',
      this.balance = '',
      this.newStyle = false,
      this.tabType,
      this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: titleStyle ?? AppTextStyle.f_12_400.color4D4D4D),
            SizedBox(
              width: 4.w,
            ),
            AssetsEyes().marginOnly(left: 4.w),
            const Spacer(),
            tabType == AssetsTabEnumn.spots ||
                    // tabType == AssetsTabEnumn.funds ||
                    tabType == AssetsTabEnumn.contract ||
                    tabType == AssetsTabEnumn.standardContract
                ? InkWell(
                    onTap: () {
                      if (tabType == AssetsTabEnumn.spots) {
                        Get.toNamed(Routes.WALLET_HISTORY, arguments: 0);
                      } else if (tabType == AssetsTabEnumn.funds) {
                        Get.toNamed(Routes.CUSTOMER_ORDER,
                            arguments: {'isHome': false});
                      } else if (tabType == AssetsTabEnumn.contract) {
                        Get.toNamed(Routes.ENTRUST);
                      } else if (tabType == AssetsTabEnumn.standardContract) {
                        Get.toNamed(Routes.COMMODITY_HISTORY_MAIN);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(3.h),
                      child: Center(
                        child: MyImage(
                          newStyle
                              ? 'assets/asset_history'.svgAssets()
                              : 'default/history'.svgAssets(),
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: AutoSizeText(
                NumberUtil.mConvert(balance,
                    isEyeHide: true,
                    count: 2,
                    isRate: IsRateEnum.usdt,
                    isShowLogo: false),
                style: AppTextStyle.f_32_600.color111111,
                maxLines: 1,
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const AssetsExchangeRate(),
                SizedBox(
                  height: 7.w,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
