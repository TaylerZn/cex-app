import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/rate_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CommodityLastPriceWidget extends StatelessWidget {
  const CommodityLastPriceWidget({super.key, this.contractInfo});
  final ContractInfo? contractInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLeft(),
          _buildRight(),
        ],
      ),
    );
  }

  _buildRight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitleDetail(
            LocaleKeys.trade16.tr, contractInfo?.high.toString() ?? '--'),
        6.verticalSpace,
        _buildTitleDetail(
            LocaleKeys.trade17.tr, contractInfo?.low.toString() ?? '--'),
      ],
    );
  }

  _buildLeft() {
    String price = contractInfo?.close.toString() ?? '0';
    int precision =
        contractInfo?.coinResultVo?.symbolPricePrecision.toInt() ?? 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          contractInfo?.close.toPrecision(precision) ?? '--',
          style: AppTextStyle.f_24_600.copyWith(
              color: contractInfo?.priceColor ?? AppColor.color111111),
        ),
        Row(
          children: [
            Text(
              '≈${NumberUtil.format(price, count: precision)}',
              style: AppTextStyle.f_12_600.color111111,
              maxLines: 1,
            ),
            3.horizontalSpace,
            Text(
              rateFormat(contractInfo?.rose.toNum() ?? 0),
              style: TextStyle(
                color: contractInfo?.priceColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }

  _buildTitleDetail(String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyle.f_9_500.colorABABAB,
        ),
        2.verticalSpace,
        Text(
          detail,
          style: AppTextStyle.f_9_500.color111111,
          maxLines: 1,
        )
      ],
    );
  }
}
