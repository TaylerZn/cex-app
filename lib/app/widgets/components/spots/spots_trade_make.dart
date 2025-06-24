import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spot_trade_history.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class SpotsTradeMakeView extends StatelessWidget {
  final SpotsTradeHistoryListModel item;

  const SpotsTradeMakeView({super.key, required this.item});

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
                item.ctime != null ? MyTimeUtil.timestampToStr(item.ctime) : '',
                style: AppTextStyle.f_12_400.color999999,
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            item.trendSide == 'BUY' ? '买入' : '卖出',
            style: AppTextStyle.f_14_600.copyWith(
              color: item.trendSide == 'BUY'
                  ? AppColor.upColor
                  : AppColor.downColor,
            ),
          ),
          10.verticalSpace,
          getRow('价格（${item.quoteCoin}）', NumberUtil.mConvert(item.price)),
          getRow('成交数量 (${item.baseCoin})', NumberUtil.mConvert(item.volume)),
          getRow('角色', 'Taker'),
          getRow('手续费 (${item.baseCoin})', NumberUtil.mConvert(item.fee)),
          getRow(
              '总量（${item.quoteCoin}）',
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
