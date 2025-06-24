import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../../utils/utilities/string_util.dart';

class AssetView extends StatelessWidget {
  final List<AssetSpotsAllCoinMapModel> list;
  final String keyword;
  final bool hideZero;

  const AssetView(
      {super.key,
      required this.list,
      this.keyword = "",
      this.hideZero = false});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    Get.width;
    children.addAll(list
        .asMap()
        .entries
        .map(
          (e) => checkHideZeroOrHasKeysord(e.value.coinName, e.value.allBalance)
              ? InkWell(
                  onTap: () {
                    Get.toNamed(Routes.ASSETS_SPOTS_INFO,
                        arguments: {"index": e.key, "data": e.value});
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColor.colorF5F5F5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        MyImage(
                          e.value.icon ?? '',
                          width: 24.w,
                          height: 24.w,
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.value.coinName ?? '',
                              style: AppTextStyle.f_14_500.color111111,
                            ),
                            Text(
                              e.value.showName ?? (e.value.name ?? ''),
                              style: AppTextStyle.f_11_400.colorTextDescription,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              NumberUtil.mConvert(
                                // TODO: JH 26.USDT资产数量精度错误
                                (e.value.coinName == "USDT")
                                    ? e.value
                                        .usdtValuatin //JH: 加个补丁,总览币种USDT时加个allBalance 加上了和合约和跟单资产的总和,这里直换用usdtValuatin
                                    : e.value.allBalance,
                                count: !TextUtil.isEmpty(AssetsGetx
                                        .to
                                        .currentRate
                                        ?.coinPrecision) //???: 这里的精度需要时当前法币的精度?
                                    ? int.parse(AssetsGetx
                                        .to.currentRate!.coinPrecision
                                        .toString())
                                    : 2,
                                isEyeHide: true,
                              ),
                              style: AppTextStyle.f_14_500.color111111,
                              textAlign: TextAlign.end,
                            ),
                            2.verticalSpaceFromWidth,
                            Text(
                              // '${e.btcValuatin}',
                              '≈${NumberUtil.mConvert(e.value.usdtValuatin, //TODO: JH7.币种价格错了
                                  isEyeHide: true, count: !TextUtil.isEmpty(AssetsGetx.to.currentRate?.coinPrecision) ? int.parse(AssetsGetx.to.currentRate!.coinPrecision.toString()) : 2, isRate: IsRateEnum.usdt)}',
                              style: AppTextStyle.f_11_400.colorTextDescription,
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

  bool checkHideZeroOrHasKeysord(String? coinName, String? balance) {
    return !TextUtil.isEmpty(coinName) &&
        containsIgnoreCase(coinName, keyword) &&
        !(hideZero &&
            !TextUtil.isEmpty(balance) &&
            double.parse(balance.toString()) == 0);
  }
}
