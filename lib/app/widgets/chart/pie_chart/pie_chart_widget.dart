import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key, required this.pieChartDatas});
  final List<PieChartConfigInfo> pieChartDatas;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          alignment: Alignment.center,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: showingSections(),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return widget.pieChartDatas.asMap().entries.map((e) {
      final isTouched = e.key == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: e.value.color,
        value: e.value.value.toDouble(),
        title: e.value.title,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColor.colorWhite,
          shadows: shadows,
        ),
      );
    }).toList();
  }

  Widget _createDescItem(PieChartConfigInfo sectionData) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            color: sectionData.color,
          ),
        ),
        SizedBox(width: 4.w),
        SizedBox(
          width: 60.w,
          child: Text(
            sectionData.title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.color666666,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: 66.w,
          child: Text(
            '${(sectionData.percent * 100).toStringAsFixed(2)}%',
            style: TextStyle(
              color: AppColor.color4D4D4D,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          width: 60.w,
          child: Text(
            _formatNumber(sectionData.value),
            style: TextStyle(
              color: AppColor.color4D4D4D,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  String _formatNumber(num value) {
    // 如果大于1k，显示为k，并保留两位小数
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)}k';
    }
    return value.toStringAsFixed(2);
  }
}

class PieChartConfigInfo {
  final Color color;
  final String title;
  final double percent;
  final num value;

  PieChartConfigInfo({
    required this.color,
    required this.title,
    required this.percent,
    required this.value,
  });
}
