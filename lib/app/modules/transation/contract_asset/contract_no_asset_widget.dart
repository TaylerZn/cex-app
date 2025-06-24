import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class NoAssetWidget extends StatelessWidget {
  const NoAssetWidget({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        Text(
          LocaleKeys.trade387.tr,
          style: AppTextStyle.f_15_500.colorTextPrimary,
        ),
        12.verticalSpace,
        Text(
          LocaleKeys.trade388.tr,
          style: AppTextStyle.f_12_400.colorTextPrimary,
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              'assets/images/trade/no_asset_recharge.svg',
              LocaleKeys.assets35.tr,
              () {
                RouteUtil.goTo('/recharge');
              },
            ),
            20.horizontalSpace,
            _buildButton(
              'assets/images/trade/no_asset_transfer.svg',
              LocaleKeys.assets7.tr,
              onTap,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MyImage(
            icon,
            width: 46.w,
          ),
          10.verticalSpace,
          Text(
            title,
            style: AppTextStyle.f_12_400.colorTextTertiary,
          )
        ],
      ),
    );
  }
}
