import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/coin_info_bottom_sheet.dart';
import 'package:nt_app_flutter/app/widgets/dialog/open_notify_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    super.key,
    this.contractInfo,
    this.marketInfo,
    required this.onTapTrade,
  });
  final ContractInfo? contractInfo;
  final MarketInfoModel? marketInfo;
  final VoidCallback onTapTrade;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.colorWhite,
        boxShadow: [
          BoxShadow(
            color: AppColor.colorBlack.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                _buildBtn('assets/images/trade/trade_more.svg',
                    LocaleKeys.public14.tr, () {
                  CoinInfoBottomSheet.show(
                    contractInfo: contractInfo,
                    marketInfo: marketInfo,
                  );
                }),
                _buildBtn('assets/images/trade/trade_alert.svg',
                    LocaleKeys.user220.tr, () async {
                  var status = await Permission.notification.request();
                  if (status != PermissionStatus.granted) {
                    Get.toNamed(Routes.NOTICE);
                  } else {
                    OpenNotifyDialog.show();
                  }
                }),
                _buildBtn('assets/images/trade/trade_convert.svg',
                    LocaleKeys.trade289.tr, () {
                  RouteUtil.goTo('/immediate-exchange');
                }),
                _buildBtn('assets/images/trade/trade_copy.svg',
                    LocaleKeys.follow17.tr, () {
                  RouteUtil.goTo('/follow-orders');
                }),
              ],
            ),
          ),
          16.horizontalSpace,
          MyButton(
            text: LocaleKeys.public17.tr,
            onTap: onTapTrade,
            width: 156.w,
            height: 38.h,
            borderRadius: BorderRadius.circular(20.h),
            backgroundColor: AppColor.colorBackgroundInversePrimary,
            textStyle: AppTextStyle.f_14_500.colorWhite,
          ),
          16.horizontalSpace,
        ],
      ),
    );
  }

  Widget _buildBtn(String icon, String title, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyImage(
              icon,
              width: 20.w,
              height: 20.w,
            ),
            4.verticalSpace,
            Text(
              title,
              style: AppTextStyle.f_10_500.colorTextDescription,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
