import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_text_style.dart';

class MyPercentSliderWidget extends StatelessWidget {
  const MyPercentSliderWidget(
      {super.key,
      required this.value,
      required this.onChanged,
      this.stepSize,
      this.labelFormatterCallback,
      this.showLabels = false,
      this.min,
      this.max,
      this.enableTooltip});

  final double? stepSize;
  final double value;
  final Function(double) onChanged;
  final LabelFormatterCallback? labelFormatterCallback;
  final bool? showLabels;
  final double? min;
  final double? max;
  final bool? enableTooltip;

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        // 轨道高度
        activeTrackHeight: 2,
        inactiveTrackHeight: 2,
        // 轨道圆角
        trackCornerRadius: 2,
        // 主要节点大小
        activeDividerRadius: 5,
        inactiveDividerRadius: 5,
        overlayRadius: 0,
        // 轨道颜色
        activeTrackColor: AppColor.colorBlack,
        inactiveTrackColor: AppColor.colorF2F2F2,
        // 节点指示颜色
        activeDividerStrokeColor: AppColor.colorWhite,
        activeTickColor: AppColor.colorBlack,
        inactiveDividerStrokeColor: AppColor.colorF2F2F2,
        // 节点指示边框宽度
        activeDividerStrokeWidth: 2,
        inactiveDividerStrokeWidth: 2,
        activeDividerColor: AppColor.colorBlack,
        inactiveDividerColor: AppColor.colorWhite,
        thumbStrokeWidth: 2,
        thumbRadius: 6,
        thumbStrokeColor: AppColor.colorBlack,
        thumbColor: AppColor.colorWhite,
        // tooltip背景颜色
        tooltipBackgroundColor: AppColor.colorBlack,
        activeLabelStyle: AppTextStyle.f_14_500.color111111,
        inactiveLabelStyle: AppTextStyle.f_14_500.color111111,
        // tooltip文字颜色
        tooltipTextStyle: TextStyle(
          color: AppColor.colorWhite,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: SfSlider(
        min: min ?? 0.0,
        max: max ?? 1.0,
        numberFormat: NumberFormat('#0%'),
        labelPlacement: LabelPlacement.onTicks,
        showLabels: showLabels ?? false,
        shouldAlwaysShowTooltip: false,

        enableTooltip: enableTooltip ?? true,
        tooltipShape: const SfPaddleTooltipShape(),
        // inactiveColor: AppColor.colorF2F2F2,
        value: value,
        interval: max != null && min != null ? (max! - min!) / 5 : 0.25,
        stepSize: stepSize ?? 0.01,
        // 显示分割节点
        showDividers: true,
        labelFormatterCallback: labelFormatterCallback,
        onChanged: (value) {
          if (GetPlatform.isIOS) {
            HapticFeedback.lightImpact();
          } else {
            HapticFeedback.selectionClick();
          }

          /// 只返回 0.01 的倍数
          value = (value * 100).round() / 100;
          onChanged(value);
        },
      ),
    );
  }
}
