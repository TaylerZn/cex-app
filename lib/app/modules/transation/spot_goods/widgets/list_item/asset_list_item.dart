import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

import '../../../../../enums/public.dart';

class AssetListItem extends StatelessWidget {
  const AssetListItem(
      {super.key, required this.coinName, required this.coinMap});

  final String coinName;
  final AssetSpotsAllCoinMapModel coinMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w, bottom: 20.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        children: [
          MarketIcon(iconName: coinName, width: 32.w),
          8.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coinName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.color111111,
                ),
              ),
              6.verticalSpace,
              Text(
                coinMap.coinName ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: AppColor.color999999,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                NumberUtil.mConvert(
                  coinMap.allBalance,
                  isEyeHide: true,
                ),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.color111111,
                ),
              ),
              Text(
                NumberUtil.mConvert(coinMap.usdtValuatin ?? '',
                    isEyeHide: true, isRate: IsRateEnum.usdt),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: AppColor.color999999,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
