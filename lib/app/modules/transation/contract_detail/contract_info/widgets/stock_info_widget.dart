

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../models/contract/res/public_info.dart';
import '../../../../../models/contract/res/stock_info.dart';
import '../../../../markets/market/widgets/market_list_icon.dart';

class StockInfoWidget extends StatelessWidget {
  const StockInfoWidget(
      {super.key, required this.stockInfo, required this.contractInfo});

  final StockInfo stockInfo;
  final ContractInfo contractInfo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          16.verticalSpaceFromWidth,
          Row(
            children: [
              MarketIcon(iconName: stockInfo.symbol ?? ''),
              4.horizontalSpace,
              Text(
                stockInfo.symbol ?? '',
                style: AppTextStyle.f_16_600.colorTextPrimary,
              ),
            ],
          ),
          _item(LocaleKeys.trade408.tr, stockInfo.name ?? '--'),
          _item(LocaleKeys.trade409.tr, stockInfo.symbol ?? ''),
          _item(
              LocaleKeys.trade410.tr,
              '\$${stockInfo.marketValue?.toInt().formatOrderQuantity(2)}'),
          _item( LocaleKeys.trade411.tr, stockInfo.industryPlate ?? '--'),
          _item( LocaleKeys.trade412.tr,
              '${stockInfo.totalShares?.toInt().formatOrderQuantity(2)}${LocaleKeys.trade421.tr}'),
          _item( LocaleKeys.trade413.tr, stockInfo.securityType ?? ''),
          _item( LocaleKeys.trade414.tr, '\$${stockInfo.dividend}'),
          _item( LocaleKeys.trade415.tr, '${(stockInfo.dividendRate ?? 0) * 100}%'),
          _item( LocaleKeys.trade416.tr, stockInfo.peTtm.toString()),
          _item( LocaleKeys.trade417.tr, stockInfo.peStatic.toString()),
          _item( LocaleKeys.trade418.tr, stockInfo.pb.toString()),
          _item( LocaleKeys.trade419.tr, '\$${stockInfo.high52W}'),
          _item( LocaleKeys.trade420.tr,'\$${stockInfo.low52W}'),
        ],
      ),
    );
  }

  Widget _item(String title, String des) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.f_13_400.colorTextDescription,
            maxLines: 1,
          ),
        ),
        Text(
          des,
          style: AppTextStyle.f_13_500.colorTextPrimary,
        ),
      ],
    ).marginOnly(top: 16.w);
  }
}

