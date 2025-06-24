import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/spot_goods/spot_trade_res.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../utils/utilities/number_util.dart';

class SpotDealItem extends StatelessWidget {
  const SpotDealItem({super.key, required this.item});
  final SpotTradeInfo item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${item.baseCoin}/${item.quoteCoin}',
                style: AppTextStyle.f_16_500.color111111,
              ),
              Text(
                DateUtil.formatDate(item.ctimeFormat,
                    format: 'yyyy-MM-dd HH:mm:ss'),
                style: AppTextStyle.f_12_400.color999999,
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            item.trendSide == 'BUY'
                ? LocaleKeys.trade47.tr
                : LocaleKeys.trade48.tr,
            style: AppTextStyle.f_14_600.copyWith(
              color: item.trendSide == 'BUY'
                  ? AppColor.upColor
                  : AppColor.downColor,
            ),
          ),
          10.verticalSpace,
          getRow('${LocaleKeys.trade34.tr}（${item.quoteCoin}）',
              NumberUtil.mConvert(item.price)),
          getRow('${LocaleKeys.trade49.tr} (${item.baseCoin})',
              NumberUtil.mConvert(item.volume)),
          getRow(LocaleKeys.trade50.tr, item.role),
          getRow('${LocaleKeys.trade51.tr} (${item.baseCoin})',
              NumberUtil.mConvert(item.fee)),
          getRow(
              '${LocaleKeys.trade52.tr}（${item.quoteCoin}）',
              NumberUtil.mConvert((Decimal.parse('${item.price}') *
                  Decimal.parse('${item.volume}')))),
          // getRow('总价（${item.quoteCoin}）', '≈${item.totalPrice}'),
        ],
      ),
    );
  }

  Widget getRow(String left, String right) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(left, style: AppTextStyle.f_12_500.color999999),
          Text(right, style: AppTextStyle.f_12_500.color333333),
        ],
      ),
    );
  }
}
