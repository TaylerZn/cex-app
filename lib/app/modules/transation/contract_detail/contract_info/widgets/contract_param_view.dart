import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/utilities/number_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ContractParamWidget extends StatelessWidget {
  const ContractParamWidget({super.key, required this.contractInfo, required this.maxLevel});

  final ContractInfo? contractInfo;
  final int maxLevel;

  @override
  Widget build(BuildContext context) {
    num multiplier = contractInfo?.multiplier ?? 0;
    return Column(
      children: [
        _buildItem(LocaleKeys.trade360.tr, "${contractInfo?.multiplier.toString() ?? '--'} ${contractInfo?.base ?? '-'}"),
        _buildItem(LocaleKeys.trade328.tr, contractInfo?.coinResultVo?.priceRange.toString() ?? '--'),
        _buildItem(LocaleKeys.trade329.tr, "${NumberUtil.getPrice((contractInfo?.coinResultVo?.maxMarketVolume  ?? 0) * multiplier , 0)} ${contractInfo?.base ?? '-'}"),
        _buildItem(LocaleKeys.trade330.tr,"${NumberUtil.getPrice(contractInfo?.coinResultVo?.maxMarketMoney ?? 0, 0)} ${contractInfo?.quote ?? '-'}"),
        _buildItem(LocaleKeys.trade331.tr,"${NumberUtil.getPrice((contractInfo?.coinResultVo?.maxLimitVolume ?? 0) * multiplier, 0)} ${contractInfo?.base ?? '-'}"),
        _buildItem(LocaleKeys.trade332.tr,"${NumberUtil.getPrice(contractInfo?.coinResultVo?.maxLimitMoney ?? 0, 0)} ${contractInfo?.quote ?? '-'}"),
        _buildItem(LocaleKeys.trade334.tr,  maxLevel.toString()),
        _buildItem(LocaleKeys.trade95.tr,
            '${contractInfo?.capitalFrequency.toString() ?? '8'}H'),
      ],
    ).marginSymmetric(horizontal: 16.w);
  }

  Widget _buildItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.f_14_400.color666666,
            maxLines: 1,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.f_14_500.color111111,
        ),
      ],
    ).marginOnly(bottom: 16.h);
  }
}
