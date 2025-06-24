import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/price_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/rate_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class Coin24HInfoWidget extends StatelessWidget {
  const Coin24HInfoWidget({
    super.key,
    required this.contractInfo,
    this.isShowMarkPrice = false,
  });
  final ContractInfo? contractInfo;
  final bool isShowMarkPrice;

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitleDetail(
              LocaleKeys.trade193.tr,
              NumberUtil.getPrice(
                  contractInfo?.high.toNum() ?? 0,
                  contractInfo?.coinResultVo?.symbolPricePrecision.toInt() ??
                      2),
            ),
            10.verticalSpace,
            _buildTitleDetail(
              LocaleKeys.trade194.tr,
              NumberUtil.getPrice(
                  contractInfo?.low.toNum() ?? 0,
                  contractInfo?.coinResultVo?.symbolPricePrecision.toInt() ??
                      2),
            ),
          ],
        ),
        10.horizontalSpace,
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleDetail(
                '${LocaleKeys.trade195.tr}(${contractInfo?.base ?? '--'})',
                ((contractInfo?.vol.toNum() ?? 0) * 0.1).formatVolume() ??
                    '--'),
            10.verticalSpace,
            _buildTitleDetail(
                '${LocaleKeys.trade196.tr}(${contractInfo?.quote ?? '--'})',
                ((contractInfo?.amount.toNum() ?? 0) * 0.1).formatVolume() ??
                    '--'),
          ],
        ),
      ],
    );
  }

  _buildLeft() {
    PriceInfo? priceInfo;
    if (contractInfo?.getContractType == 'E' && isShowMarkPrice) {
      priceInfo = ContractDataStoreController.to
          .getPriceInfoBySubSymbol(contractInfo?.subSymbol ?? '');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (contractInfo?.contractType == 'E' && isShowMarkPrice)
          Text(
            LocaleKeys.trade275.tr,
            style: AppTextStyle.f_9_400.colorTextDescription,
          ),
        Text(
          NumberUtil.getPrice(contractInfo?.close.toNum() ?? 0,
              contractInfo?.coinResultVo?.symbolPricePrecision.toInt() ?? 2),
          style: AppTextStyle.f_28_600.copyWith(
            color: contractInfo?.priceColor ?? AppColor.colorBlack,
          ),
          strutStyle: const StrutStyle(
            height: 0.7,
          ),
        ),
        Row(
          children: [
            Text(
              '≈${NumberUtil.mConvert(
                contractInfo?.close.toNum() ?? 0,
                count: contractInfo?.coinResultVo?.symbolPricePrecision.toInt(),
                isRate: IsRateEnum.usdt,
              )}',
              style: AppTextStyle.f_12_500.colorTextPrimary,
              maxLines: 1,
            ),
            4.horizontalSpace,
            Text(
              rateFormat(contractInfo?.rose.toNum() ?? 0),
              style: AppTextStyle.f_12_500.copyWith(
                color: (contractInfo?.rose.toNum() ?? 0) >= 0
                    ? AppColor.upColor
                    : AppColor.downColor,
              ),
              maxLines: 1,
            ),
          ],
        ),
        2.verticalSpace,
        if (contractInfo?.contractType == 'E' && isShowMarkPrice)
          Row(
            children: [
              Text(
                LocaleKeys.trade110.tr,
                style: AppTextStyle.f_9_400.colorTextDescription,
              ),
              4.horizontalSpace,
              Text(
                NumberUtil.getPrice(
                    priceInfo?.tagPrice ?? 0,
                    contractInfo?.coinResultVo?.symbolPricePrecision.toInt() ??
                        2),
                style: AppTextStyle.f_10_500.colorTextSecondary,
              ),
            ],
          ),
      ],
    );
  }

  _buildTitleDetail(String title, String detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyle.f_9_400.colorTextTips,
        ),
        4.verticalSpace,
        Text(
          detail,
          style: AppTextStyle.f_10_500.colorTextPrimary,
        )
      ],
    );
  }
}
