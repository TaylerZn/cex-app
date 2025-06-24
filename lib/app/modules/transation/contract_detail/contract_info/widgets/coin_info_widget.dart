import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../models/contract/res/coin_info.dart';
import '../../../../../models/contract/res/public_info.dart';
import '../../../../../widgets/basic/my_image.dart';

class CoinInfoWidget extends StatelessWidget {
  const CoinInfoWidget(
      {super.key, required this.coinInfo, required this.contractInfo});

  final CoinInfo coinInfo;
  final ContractInfo contractInfo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconInfo(),
          _item(LocaleKeys.trade397.tr, 'No.${coinInfo.cmcRank ?? 1}'),
          _item(LocaleKeys.trade398.tr,
              '\$${coinInfo.marketCap?.toInt().formatOrderQuantity(2) ?? '--'}'),
          _item(LocaleKeys.trade399.tr,
              '${coinInfo.circulatingSupply?.formatOrderQuantity(2) ?? '--'} ${contractInfo.base}'),
          _item(LocaleKeys.trade400.tr,
              '${coinInfo.totalSupply?.formatOrderQuantity(2) ?? '--'} ${contractInfo.base}'),
          _item(
              LocaleKeys.trade401.tr,
              DateUtil.formatDateMs(coinInfo.publishTimestamp?.toInt() ?? 0,
                  format: 'yyyy-MM-dd')),
          _item(LocaleKeys.trade402.tr, '\$${coinInfo.hprice}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateUtil.formatDate(coinInfo.hpriceTime, format: 'yyyy-MM-dd'),
                style: AppTextStyle.f_11_400.colorTextDescription,
              ),
            ],
          ),
          24.verticalSpaceFromWidth,
          _link(),
          24.verticalSpaceFromWidth,
          _des(),
        ],
      ),
    );
  }

  Widget _link() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.trade403.tr,
          style: AppTextStyle.f_16_600.colorTextPrimary,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _linkBtn(LocaleKeys.trade404.tr, 'assets/images/commodity/coin_office.svg', () {
                launchUrl(Uri.parse(coinInfo!.officialUrl ?? ''));
              }),
              _linkBtn(LocaleKeys.trade405.tr, 'assets/images/commodity/coin_book.svg', () {
                launchUrl(Uri.parse(coinInfo!.blockchainUrl ?? ''));
              }),
              _linkBtn(LocaleKeys.trade406.tr, 'assets/images/commodity/coin_link.svg', () {
                launchUrl(Uri.parse(coinInfo!.blockchainBrowser ?? ''));
              }),
            ],
          ).marginOnly(top: 16.w),
        ),
      ],
    );
  }

  Widget _iconInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyImage(
          coinInfo.icon ?? '',
          width: 24.w,
          height: 24.w,
        ),
        4.horizontalSpace,
        Text(
          coinInfo.fullName ?? '',
          style: AppTextStyle.f_16_600.colorTextPrimary,
        ),
      ],
    ).marginOnly(top: 16.w);
  }

  Widget _item(String title, String des) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyle.f_13_400.colorTextDescription,
        ),
        Text(
          des,
          style: AppTextStyle.f_13_500.colorTextPrimary,
        ),
      ],
    ).marginOnly(top: 16.w);
  }

  Widget _linkBtn(String title, String icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(color: AppColor.colorBorderStrong),
        ),
        margin: EdgeInsets.only(right: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyImage(
              icon,
              width: 16.w,
            ),
            4.horizontalSpace,
            Text(
              title,
              style: AppTextStyle.f_13_400.colorTextSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _des() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.trade407.tr,
          style: AppTextStyle.f_16_600.colorTextPrimary,
        ),
        10.verticalSpaceFromWidth,
        Text(
          coinInfo.introduction ?? '',
          style: AppTextStyle.f_13_400_15.colorTextDescription,
          textAlign: TextAlign.start,
        )
      ],
    );
  }
}
