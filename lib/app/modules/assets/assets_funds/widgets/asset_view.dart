import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_funds.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

import '../../../../utils/utilities/string_util.dart';

class FundsAssetView extends StatelessWidget {
  final List<AssetsFundsAllCoinMapModel> list;
  final String keyword;
  final bool hideZero;

  const FundsAssetView(
      {super.key,
      required this.list,
      this.keyword = "",
      this.hideZero = false});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.addAll(list
        .asMap()
        .entries
        .map(
          (e) => checkHideZeroOrHasKeysord(
                  e.value.coinSymbol, e.value.totalBalance)
              ? InkWell(
                  onTap: () {
                    Get.toNamed(Routes.ASSETS_FUNDS_INFO,
                        arguments: {"index": e.key, "data": e.value});
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: AppColor.colorEEEEEE))),
                    child: Row(
                      children: [
                        // MyImage(
                        //   e.value.icon ?? '',
                        //   width: 24.w,
                        // ),
                        MarketIcon(
                          iconName: e.value.coinSymbol ?? '',
                          width: 24.w,
                        ),

                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.value.coinSymbol ?? '',
                              style: AppTextStyle.f_16_500.color111111,
                            ),
                            Text(e.value.showName ?? '--',
                                style: AppTextStyle.f_10_400.color666666),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              NumberUtil.mConvert(
                                e.value.totalBalance,
                                isEyeHide: true,
                              ),
                              style: const TextStyle(
                                color: AppColor.color111111,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              // '${e.btcValuatin}',
                              NumberUtil.mConvert(e.value.totalBalance,
                                  isEyeHide: true,
                                  count: !TextUtil.isEmpty(AssetsGetx()
                                          .currentRate
                                          ?.coinPrecision)
                                      ? int.parse(AssetsGetx()
                                          .currentRate!
                                          .coinPrecision
                                          .toString())
                                      : 2,
                                  isRate: IsRateEnum.usdt),
                              style: AppTextStyle.f_12_400.color999999,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
              : Container(),
        )
        .toList());
    return Column(
      children: children,
    );
  }

  bool checkHideZeroOrHasKeysord(String? coinSymbol, String? balance) {
    return !TextUtil.isEmpty(coinSymbol) &&
        containsIgnoreCase(coinSymbol, keyword) &&
        !(hideZero &&
            !TextUtil.isEmpty(balance) &&
            double.parse(balance.toString()) == 0);
  }
}
