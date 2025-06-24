import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/spot_goods/spot_order_res.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';

class SpotHistoryEntrustWidget extends StatelessWidget {
  const SpotHistoryEntrustWidget({super.key, required this.orderInfo});

  final SpotOrderInfo orderInfo;

  @override
  Widget build(BuildContext context) {
    final leftStyle = AppTextStyle.f_13_400.color666666;
    final rightStyle = AppTextStyle.f_13_400.color111111;
    List<Color> colors = [];
    List<String> tags = [];
    if (orderInfo.side == 'SELL') {
      tags.add(LocaleKeys.trade48.tr);
      colors.add(AppColor.downColor);
    } else {
      tags.add(LocaleKeys.trade47.tr);
      colors.add(AppColor.upColor);
    }
    if (orderInfo.type == 1) {
      tags.add(LocaleKeys.trade73.tr);
      colors.add(AppColor.downColor);
    } else {
      tags.add(LocaleKeys.trade74.tr);
      colors.add(AppColor.upColor);
    }

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20.h),
      padding: EdgeInsets.only(bottom: 20.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${orderInfo.baseCoin}/${orderInfo.countCoin}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.color111111,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 6.h,
                  ),
                  _buildTags(tags, colors),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
              Text(
                  DateUtil.formatDate(orderInfo.createdAt,
                      format: 'yyyy-MM-dd HH:mm:ss'),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColor.color999999,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${LocaleKeys.trade27.tr} (${orderInfo.baseCoin})',
                    style: leftStyle),
                Text('${orderInfo.dealVolume}/${orderInfo.volume}',
                    style: rightStyle),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade34.tr, style: leftStyle),
                Text('${orderInfo.avgPrice} / ${orderInfo.price}',
                    style: rightStyle),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(LocaleKeys.trade43.tr, style: leftStyle),
              Text(orderInfo.getStatusStr(orderInfo.status),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.upColor,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTags(List<String> tags, List<Color> colors) {
    return Row(
      children: tags
          .asMap()
          .entries
          .map(
            (e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              height: 16.h,
              margin: EdgeInsets.only(right: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: colors[e.key].withOpacity(0.1),
              ),
              alignment: Alignment.center,
              child: Text(
                e.value,
                style: AppTextStyle.f_10_500.copyWith(color: colors[e.key]),
              ),
            ),
          )
          .toList(),
    );
  }
}
