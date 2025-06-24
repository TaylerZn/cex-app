import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/cancel_config_bottom_button.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_slider_widget.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'bottom_sheet_util.dart';

class LeverageMultipleBottomSheet extends StatefulWidget {
  const LeverageMultipleBottomSheet(
      {super.key,
      required this.nowLevel,
      required this.minLevel,
      required this.maxLevel,
      required this.userMaxLevel,
      required this.margin});

  final int nowLevel;
  final int minLevel;
  final int maxLevel;
  final int userMaxLevel;

  /// 当前保证金
  final num margin;

  static Future<int?> show(int nowLevel, int minLevel, int maxLevel,
      int userMaxLevel, num margin) async {
    return await showBSheet<int>(
      LeverageMultipleBottomSheet(
        nowLevel: nowLevel,
        minLevel: minLevel,
        maxLevel: maxLevel,
        userMaxLevel: userMaxLevel,
        margin: margin,
      ),
    );
  }

  @override
  State<LeverageMultipleBottomSheet> createState() =>
      _LeverageMultipleBottomSheetState();
}

class _LeverageMultipleBottomSheetState
    extends State<LeverageMultipleBottomSheet> {
  /// 倍数
  double count = 1;
  Decimal changeDecimal = Decimal.zero;

  @override
  void initState() {
    count = widget.nowLevel.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String changeTile = '${LocaleKeys.trade221.tr} 0 USDT';
    if (changeDecimal == Decimal.zero) {
      changeTile = '${LocaleKeys.trade221.tr} 0 USDT';
    } else if (changeDecimal > Decimal.zero) {
      changeTile =
          '${LocaleKeys.trade221.tr} ${changeDecimal.toPrecision(widget.margin.numDecimalPlaces())} USDT';
    } else {
      changeTile =
          '${LocaleKeys.trade222.tr} ${changeDecimal.abs().toPrecision(widget.margin.numDecimalPlaces())} USDT';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            Text(
              LocaleKeys.assets33.tr,
              style: TextStyle(
                color: AppColor.color111111,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            24.verticalSpace,
            Container(
              height: 44.h,
              decoration: ShapeDecoration(
                color: AppColor.colorF4F4F4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              child: Row(
                children: [
                  _buildBtn('-', () {
                    count -= 1;
                    change();
                    setState(() {});
                  }, count > widget.minLevel),
                  Expanded(
                    child: Text(
                      '${max(1, count).toInt()}x',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.color111111,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _buildBtn('+', () {
                    count += 1;
                    change();
                    setState(() {});
                  }, count < min(widget.userMaxLevel.toDouble(), widget.maxLevel.toDouble())),
                ],
              ),
            ),
            16.verticalSpace,
            MyPercentSliderWidget(
              value: count,
              showLabels: true,
              enableTooltip: false,
              min: widget.minLevel.toDouble(),
              max: min(widget.userMaxLevel.toDouble(), widget.maxLevel.toDouble()),
              labelFormatterCallback:
                  (dynamic actualValue, String formattedText) {
                return actualValue == 0
                    ? '1x'
                    : '${(actualValue as num).toInt()}x';
              },
              onChanged: (value) {
                // if (value <= widget.userMaxLevel) {
                  count = value;
                  change();
                  setState(() {});
                // } else {
                //   count = widget.userMaxLevel.toDouble();
                //   change();
                //   setState(() {});
                // }
              },
            ),
            16.verticalSpace,
            Text(
              LocaleKeys.trade223.tr,
              style: TextStyle(
                color: AppColor.color666666,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            8.verticalSpace,
            Text(
              changeTile,
              style: TextStyle(
                color: AppColor.color666666,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            16.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info,
                  size: 16.sp,
                  color: AppColor.colorDanger,
                ).marginOnly(top: 2.h, right: 4.w),
                Expanded(
                  child: Text(
                    LocaleKeys.trade224.tr,
                    style: TextStyle(
                      color: Color(0xFFF53F57),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).marginSymmetric(horizontal: 16.w),
        23.verticalSpace,
        Divider(
          height: 1.h,
          color: AppColor.colorF5F5F5,
        ),
        CancelConfirmBottomButton(onCancel: () {
          Get.back();
        }, onConfirm: () {
          Get.back(result: count.toInt());
        }).marginAll(16.w),
      ],
    );
  }

  change() {
    Decimal userLevel = Decimal.parse(widget.nowLevel.toString());
    Decimal nowLevel = Decimal.parse(count.toInt().toString());
    Decimal userMargin = Decimal.parse(widget.margin.toString());

    /// 原始金额
    Decimal origin = userLevel * userMargin;

    /// 调整杠杆后需要的保证金
    Decimal nowMargin = (origin / nowLevel)
        .toDecimal(scaleOnInfinitePrecision: widget.margin.numDecimalPlaces());
    changeDecimal = nowMargin - userMargin;
    Get.log('changeDecimal: $changeDecimal $nowMargin $userMargin');
  }

  _buildBtn(String title, VoidCallback onTap, bool enable) {
    return InkWell(
      onTap: () {
        if (enable) {
          onTap();
        }
      },
      child: Container(
        width: 44.w,
        height: 44.h,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 30.sp,
            color: enable ? AppColor.color111111 : AppColor.color999999,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
