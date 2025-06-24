import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k_chart/entity/depth_entity.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_draw.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/custom_loading_progress_indicator.dart';
import 'package:nt_app_flutter/app/widgets/dialog/tip_dialog.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';
import '../../../models/contract/res/funding_rate.dart';
import '../../../utils/utilities/number_util.dart';
import '../../../widgets/basic/my_dotted_text.dart';
import '../../../widgets/basic/my_image.dart';
import '../../../widgets/components/transaction/selection_button.dart';
import '../mixin/depth_controller.dart';

// 深度图控件
class DepthMapWidget extends StatelessWidget {
  const DepthMapWidget(
      {super.key,
      required this.onValueChanged,
      required this.price,
      required this.amount,
      required this.height,
      required this.amountPrecision,
      required this.onChangePrecision,
      required this.precisionList,
      required this.precision,
      required this.buyAskType,
      required this.onChangeBuyAskType,
      required this.asks,
      required this.buys,
      required this.askMaxVol,
      required this.buyMaxVol,
      required this.fundingRate,
      required this.closePrice,
      required this.color});

  final String price;
  final String amount;
  final double height;
  final int amountPrecision;

  /// 卖盘
  final List<DepthEntity> asks;

  /// 买盘
  final List<DepthEntity> buys;
  final num askMaxVol;
  final num buyMaxVol;

  /// 资金费率
  final Rxn<FundingRate> fundingRate;

  /// 最新成交价
  final String closePrice;
  final Color color;

  final ValueChanged<DepthEntity?> onValueChanged;

  final List<num> precisionList;
  final num precision;
  final ValueChanged<num> onChangePrecision;

  final BuyAskType buyAskType;
  final ValueChanged<BuyAskType> onChangeBuyAskType;

  @override
  Widget build(BuildContext context) {
    double centerH = 40.h;
    double cellHeight = 18.h;
    int cellCount = 8;
    double rateH = 23.h;
    double titleH = 27.h;
    double cellTotalHeight = height - centerH - titleH - 8.h - 22.h - rateH;
    if (buyAskType != BuyAskType.all) {
      cellTotalHeight = height - centerH - titleH - 6.h - 22.h - rateH;
      cellCount = (cellTotalHeight / cellHeight).ceil();
      cellHeight = cellTotalHeight / cellCount;
    } else {
      cellCount = ((cellTotalHeight * 0.5) / cellHeight).ceil();
      cellHeight = ((cellTotalHeight * 0.5) / cellCount);
    }

    List<DepthEntity> top = [];
    Color topColor = AppColor.colorSuccess;
    num topMaxVol = 0;
    if (buyAskType == BuyAskType.all) {
      top = asks.sublist(0, min(cellCount, asks.length));
      topColor = AppColor.colorDanger;
    } else if (buyAskType == BuyAskType.buy) {
      top = buys.sublist(0, min(cellCount, asks.length));
      topColor = AppColor.colorSuccess;
    } else if (buyAskType == BuyAskType.ask) {
      top = asks.sublist(0, min(cellCount, asks.length));
      topColor = AppColor.colorDanger;
    } else {
      top = buys.sublist(0, min(cellCount, buys.length));
      topColor = AppColor.colorSuccess;
    }
    for (var element in top) {
      topMaxVol = max(topMaxVol, element.vol);
    }

    List<DepthEntity> bottom = [];
    Color bottomColor = AppColor.colorSuccess;
    num bottomMaxVol = 0;
    bottom = buys.sublist(0, min(cellCount, buys.length));
    for (var element in bottom) {
      bottomMaxVol = max(bottomMaxVol, element.vol);
    }

    return Container(
      width: 140.w,
      height: height + 1.h,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: titleH,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTitle(
                    LocaleKeys.trade34.tr, price, CrossAxisAlignment.start),
                _buildTitle(
                    LocaleKeys.trade27.tr, amount, CrossAxisAlignment.end),
              ],
            ),
          ),
          2.verticalSpace,
          Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                itemCount: cellCount,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemExtent: cellHeight,
                itemBuilder: (BuildContext context, int index) {
                  DepthEntity? orderBook = top.safe(index);
                  return _buildListItem(
                    orderBook,
                    cellHeight,
                    topMaxVol,
                    precision.numDecimalPlaces(),
                    topColor,
                    amountPrecision,
                    (value) => onValueChanged(value),
                  );
                },
              ),
              if (top.isEmpty)
                const Align(
                  alignment: Alignment.center,
                  child: CustomLoadingProgressIndicator(
                    width: 18,
                    height: 18,
                  ),
                ),
            ],
          ),
          Container(
            height: centerH,
            alignment: Alignment.centerLeft,
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    NumberUtil.getPrice(
                        closePrice.toNum() ?? 0, precision.numDecimalPlaces()),
                    style: AppTextStyle.f_15_600.copyWith(
                      color: color,
                    ),
                  ),
                  if (fundingRate.value != null)
                    Row(
                      children: [
                        MyImage(
                          'assets/images/trade/Union.svg',
                          width: 10.w,
                        ),
                        2.horizontalSpace,
                        MyDottedText(
                          '${fundingRate.value?.indexPrice != null ? NumberUtil.getPrice(fundingRate.value!.indexPrice ?? 0, precision.numDecimalPlaces()) : '--'}/${fundingRate.value?.tagPrice != null ? NumberUtil.getPrice(fundingRate.value!.tagPrice ?? 0, precision.numDecimalPlaces()) : '--'}',
                          style: AppTextStyle.f_11_400.colorTips,
                          isCenter: false,
                          onTap: () {
                            TipsDialog.show(
                              title: LocaleKeys.trade101.tr,
                              content:
                                  '${LocaleKeys.trade389.tr}\n\n${LocaleKeys.trade390.tr} ${NumberUtil.getPrice(fundingRate.value!.indexPrice ?? 0, precision.numDecimalPlaces())}',
                              okTitle: LocaleKeys.public76.tr,
                            );
                          },
                        ),
                      ],
                    ),
                ],
              );
            }),
          ),
          2.verticalSpace,
          Offstage(
            offstage: buyAskType != BuyAskType.all,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListView.builder(
                  itemCount: cellCount,
                  shrinkWrap: true,
                  itemExtent: cellHeight,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    DepthEntity? orderBook = buys.safe(index);
                    return _buildListItem(
                      orderBook,
                      cellHeight,
                      bottomMaxVol,
                      precision.numDecimalPlaces(),
                      bottomColor,
                      amountPrecision,
                      (value) => onValueChanged(value!),
                    );
                  },
                ).marginOnly(bottom: 2.h),
                if (buys.isEmpty)
                  const Align(
                    alignment: Alignment.center,
                    child: CustomLoadingProgressIndicator(
                      width: 18,
                      height: 18,
                    ),
                  ),
              ],
            ),
          ),
          _buildBuyAndSellRate(),
          2.verticalSpace,
          _buildPrecisionWidget(),
        ],
      ),
    );
  }

  /// 买卖比例
  Widget _buildBuyAndSellRate() {
    num askTotal = 0;
    for (var element in asks) {
      askTotal += element.vol;
    }
    num buyTotal = 0;
    for (var element in buys) {
      buyTotal += element.vol;
    }

    num total = buyTotal + askTotal;

    double buyPre = total == 0 ? 0.5 : buyTotal / total;
    double askPre = total == 0 ? 0.5 : askTotal / total;

    return Container(
      height: 23.h,
      alignment: Alignment.center,
      child: Column(
        children: [
          FollowTakerDrawProgress(
            left: buyPre,
            right: askPre,
            height: 3.h,
            leftColor: AppColor.colorFunctionBuy,
            rightColor: AppColor.colorFunctionSell,
            marginTop: 0,
          ),
          4.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(buyPre * 100).toPrecision(2)}%',
                style: AppTextStyle.f_10_400.colorFunctionBuy,
              ),
              Text(
                '${(askPre * 100).toPrecision(2)}%',
                style: AppTextStyle.f_10_400.colorFunctionSell,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildPrecisionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectionButton.normal(
          height: 22.h,
          width: 110.w,
          text: precision.toDecimal().toString(),
          // onTap: () async {
          // TODO:: 暂时去掉精度选择
          // final res = await CommonBottomSheet.show(
          //     titles: precisionList.map((e) => e.toString()).toList(),
          //     selectedIndex: precisionList.indexOf(precision));
          // if (res != null) {
          //   onChangePrecision(precisionList[res]);
          // }
          // },
        ),
        InkWell(
          onTap: () {
            if (buyAskType == BuyAskType.all) {
              onChangeBuyAskType(BuyAskType.buy);
            } else if (buyAskType == BuyAskType.buy) {
              onChangeBuyAskType(BuyAskType.ask);
            } else {
              onChangeBuyAskType(BuyAskType.all);
            }
          },
          child: Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColor.colorF5F5F5,
            ),
            alignment: Alignment.center,
            child: MyImage(
              buyAskTypeMap[buyAskType]!,
              width: 12.w,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildListItem(
      DepthEntity? depthInfo,
      double height,
      num maxVol,
      int fixed,
      Color color,
      int precision,
      ValueChanged<DepthEntity?> onValueChanged) {
    String price = depthInfo?.price != null
        ? NumberUtil.getPrice(depthInfo?.price ?? 0, fixed)
        : '--';
    String amount = depthInfo?.vol.formatOrderQuantity(precision) ?? '--';
    double percent = maxVol == 0 ? 0.0 : (depthInfo?.vol ?? 0) / (maxVol);

    return InkWell(
      onTap: () {
        if (depthInfo != null) {
          onValueChanged(depthInfo);
        }
      },
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(flex: ((1 - percent) * 100).toInt(), child: Container()),
              Expanded(
                flex: (percent * 100).toInt(),
                child: Container(
                  color: color.withOpacity(0.05),
                  height: height,
                ),
              ),
            ],
          ),
          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: AppTextStyle.f_11_400.copyWith(color: color),
                ),
                Text(
                  amount,
                  style: AppTextStyle.f_11_400.copyWith(
                    color: AppColor.color333333,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTitle(
      String title, String amount, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: AppTextStyle.f_10_400.colorTextDescription,
        ),
        Text(
          '($amount)',
          style: AppTextStyle.f_9_400.colorTextTips,
        ),
      ],
    );
  }
}
