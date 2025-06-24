import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget(
      {super.key,
      required this.lineChart,
      this.showGrid = false,
      this.lineTouchEnable = false,
      this.gradientColors});

  final List<FlSpot> lineChart;
  final bool showGrid;
  final bool lineTouchEnable;
  final List<Color>? gradientColors;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: true),
        gridData: FlGridData(show: showGrid),
        lineTouchData: LineTouchData(
          enabled: lineTouchEnable,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: lineChart,
            isCurved: true,
            barWidth: 2,
            color: Colors.green,
            belowBarData: BarAreaData(
              show: true,
              gradient:
                  LinearGradient(
                    colors: gradientColors ?? [
                      Colors.green.withOpacity(0.8),
                      Colors.green.withOpacity(0.4),
                      Colors.green.withOpacity(0.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
            ),
            aboveBarData: BarAreaData(
              show: false,
              color: Colors.transparent,
              applyCutOffY: false,
            ),
            dotData: const FlDotData(
              show: false,
            ),
          ),
        ],
      ),
    );
  }
}
