import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/model/assets_exchange_rate.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class TooltipLinePainter extends CustomPainter {
  final Offset position;
  final bool showLine;

  TooltipLinePainter(this.position, this.showLine);

  @override
  void paint(Canvas canvas, Size size) {
    if (!showLine) return;

    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final circlePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // Draw vertical line
    canvas.drawLine(
      Offset(position.dx, 0),
      Offset(position.dx, size.height),
      linePaint,
    );

    // Draw circle at the touch point
    const circleRadius = 6.0;
    canvas.drawCircle(position, circleRadius, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class AssetsStockChart extends StatefulWidget {
  const AssetsStockChart({super.key, this.profitRateList, this.haveBottom = false, this.color = const Color(0XFFFDBC0A)});
  final List<AssetsKLIneModel>? profitRateList;
  final bool haveBottom;
  final Color color;

  @override
  State<AssetsStockChart> createState() => _AssetsStockChartState();
}

class _AssetsStockChartState extends State<AssetsStockChart> {
  OverlayEntry? _overlayEntry;
  Offset _tooltipPosition = Offset.zero;
  String _tooltipText = '';
  bool _showLine = false;
  var currentIndex = 1;
  var array = [1, 7, 30, 180];
  List<FlSpot> spotArray = [];
  double offset = 40;

  // void _showTooltip(Offset position, String text) {
  //   _tooltipText = text;

  //   _overlayEntry?.remove();
  //   _overlayEntry = OverlayEntry(
  //     builder: (context) => Stack(
  //       children: [
  //         CustomPaint(
  //           size: MediaQuery.of(context).size,
  //           painter: TooltipLinePainter(position, _showLine),
  //         ),
  //         Positioned(
  //           left: _tooltipPosition.dx,
  //           top: _tooltipPosition.dy,
  //           child: Material(
  //             color: Colors.transparent,
  //             child: Container(
  //               padding: EdgeInsets.all(8),
  //               decoration: BoxDecoration(
  //                 color: Colors.black.withOpacity(0.7),
  //                 borderRadius: BorderRadius.circular(4),
  //               ),
  //               child: Text(
  //                 _tooltipText,
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );

  //   Overlay.of(context)?.insert(_overlayEntry!);
  // }

  // void _hideTooltip() {
  //   _overlayEntry?.remove();
  //   _overlayEntry = null;
  // }

  @override
  Widget build(BuildContext context) {
    num maxNumber = double.negativeInfinity;
    num minNumber = double.infinity;
    spotArray = [];
    bool haveData = widget.profitRateList != null && widget.profitRateList!.length > 1;
    if (haveData) {
      var dataArray = widget.profitRateList!.length > (array[currentIndex] * 6)
          ? widget.profitRateList!.sublist(widget.profitRateList!.length - (array[currentIndex] * 6))
          : widget.profitRateList!;

      maxNumber =
          dataArray.reduce((value, element) => value.totalBalance > element.totalBalance ? value : element).totalBalance;

      minNumber =
          dataArray.reduce((value, element) => value.totalBalance < element.totalBalance ? value : element).totalBalance;

      for (var i = 0; i < dataArray.length; i++) {
        spotArray.add(FlSpot(i * 1.0, dataArray[i].totalBalance * 1.0));
      }
    }
    // final renderBox = context.findRenderObject() as RenderBox;

    var view = haveData
        ? LineChart(
            LineChartData(
              // backgroundColor: Colors.green,
              // lineTouchData: LineTouchData(enabled: haveBottom ? true : false),
              lineTouchData: LineTouchData(
                  getTouchLineEnd: (barData, spotIndex) {
                    return barData.spots[spotIndex].y + (maxNumber - minNumber) * 0.45;
                  },
                  getTouchedSpotIndicator: (LineChartBarData barData, List<int> spots) {
                    return spots.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color: widget.color,
                          strokeWidth: 1,
                          dashArray: [2, 2],
                        ),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 6,
                              color: widget.color,
                              strokeWidth: 6,
                              strokeColor: widget.color.withAlpha(50),
                            );
                          },
                        ),
                      );
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    tooltipMargin: 45,
                    tooltipHorizontalOffset: offset,
                    tooltipPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    tooltipBorder: const BorderSide(color: AppColor.colorF5F5F5, width: 1),
                    tooltipBgColor: Colors.white,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        // print(
                        //     'hhhhhhhhh111--------${'X:${touchedSpot.x.toStringAsFixed(2)} Y:${touchedSpot.y.toStringAsFixed(2)}'}');
                        return LineTooltipItem(
                          getTimeArr()[touchedSpot.x.toInt()],
                          AppTextStyle.f_9_400.copyWith(color: const Color(0xFFE6AA04)),
                          textAlign: TextAlign.left,
                          children: [
                            TextSpan(text: '\n${touchedSpot.x.toStringAsFixed(2)}', style: AppTextStyle.f_11_500.color333333)
                          ],
                        );
                      }).toList();
                    },
                  ),
                  // touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                  //   if (event is FlLongPressStart || event is FlLongPressMoveUpdate) {
                  //     final touchPosition = event.localPosition;

                  //     final globalPosition = renderBox.localToGlobal(touchPosition!);

                  //     // final topLeftOffset = renderBox.localToGlobal(Offset.zero);
                  //     // final topPosition = topLeftOffset.dy;

                  //     // print('hhhhhhhhhh-----------$topPosition');
                  //     // TouchLineBarSpot touchedSpot = response!.lineBarSpots!.first;

                  //     if (response?.lineBarSpots == null) {
                  //       _hideTooltip();
                  //       return;
                  //     }

                  //     final touchedSpot = response!.lineBarSpots!.first;
                  //     // print(
                  //     //     'hhhhhhhhhh-------${response!.lineBarSpots!.length}----${touchedSpot.distance}----${touchedSpot.barIndex}----${touchedSpot.y}');

                  //     final tooltipText = '${touchedSpot.x.toStringAsFixed(2)}\n${touchedSpot.y.toStringAsFixed(2)}';
                  //     print('hhhhhhhhh222--------${'X:${touchedSpot.x.toStringAsFixed(2)}--${touchedSpot.y.toStringAsFixed(2)}'}');

                  //     _tooltipPosition = Offset(
                  //       touchPosition?.dx.clamp(0, MediaQuery.of(context).size.width - 50) ?? 0,
                  //       touchPosition?.dy.clamp(200, MediaQuery.of(context).size.height - 0) ?? 0,
                  //     );
                  //     // Show tooltip
                  //     _showTooltip(Offset(touchedSpot.x, touchedSpot.y), tooltipText);

                  //     // setState(() {
                  //     //   _tooltipPosition = Offset(
                  //     //     touchPosition?.dx.clamp(0, MediaQuery.of(context).size.width - 50) ?? 0,
                  //     //     touchPosition?.dy.clamp(200, MediaQuery.of(context).size.height - 0) ?? 0,
                  //     //   );
                  //     //   _showLine = true;
                  //     // });
                  //   } else {
                  //     _hideTooltip();
                  //     setState(() {
                  //       _showLine = false;
                  //     });
                  //   }
                  // },
                  handleBuiltInTouches: false),

              // handleBuiltInTouches: widget.haveBottom ? true : false),
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(
                show: false,
              ),
              minX: 0,
              maxX: spotArray.length * 1.0 - 1,

              minY: minNumber * 0.9999,
              maxY: maxNumber * 1.0001,
              lineBarsData: [
                LineChartBarData(
                  barWidth: 1,
                  spots: spotArray,
                  isCurved: true,
                  curveSmoothness: 0.1,
                  color: widget.color,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        widget.color.withOpacity(0.3),
                        widget.color.withOpacity(0.1),
                        widget.color.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();

    return widget.haveBottom
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 120,
                child: view,
              ),
              Expanded(flex: 35, child: getDate()),
              Expanded(
                flex: 19,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: getBottomView(),
                ).paddingSymmetric(horizontal: 8.w),
              )
            ],
          )
        : view;
    ;
  }

  // Offset calculateTooltipOffset(BuildContext context, LineBarSpot spot) {
  //   final renderBox = context.findRenderObject() as RenderBox;
  //   final size = renderBox.size;

  //   final screenWidth = MediaQuery.of(context).size.width;

  //   // Default tooltip size
  //   const tooltipWidth = 100.0;
  //   const tooltipHeight = 50.0;

  //   // Calculate x position with some margin
  //   double xPosition = spot.barIndex * 100.0; // Example position based on index
  //   double adjustedXPosition = xPosition + tooltipWidth > screenWidth ? screenWidth - tooltipWidth : xPosition;

  //   // Calculate y position
  //   double yPosition = spot.barIndex * 50.0; // Example position based on index

  //   return Offset(adjustedXPosition, yPosition);
  // }

  List<Widget> getBottomView() {
    List<Widget> dataArr = [];
    for (var i = 0; i < array.length; i++) {
      dataArr.add(GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = i;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: ShapeDecoration(
            color: i == currentIndex ? AppColor.colorF9F9F9 : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            '${array[i]} ${LocaleKeys.assets157.tr}',
            style: i == currentIndex ? AppTextStyle.f_11_400.color333333 : AppTextStyle.f_11_400.color999999,
          ),
        ),
      ));
    }
    return dataArr;
  }

  Widget getDate() {
    var nowDate = DateTime.now();
    DateTime currentDate = nowDate.subtract(Duration(days: array[currentIndex]));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '${currentDate.year}-${currentDate.month}-${currentDate.day}',
          style: AppTextStyle.f_9_400.colorABABAB,
        ),
        Text(
          '${nowDate.year}-${nowDate.month}-${nowDate.day}',
          style: AppTextStyle.f_9_400.colorABABAB,
        ),
      ],
    ).paddingSymmetric(vertical: 12.w);
  }

  List<String> getTimeArr() {
    DateTime today = DateTime.now();
    List<String> timePoints = ['0点', '4点', '8点', '12点', '16点', '20点'];
    List<String> result = [];
    DateTime startDate = today.subtract(Duration(days: array[currentIndex]));
    for (int i = 0; i < spotArray.length; i++) {
      int dayOffset = i ~/ 6;
      DateTime targetDate = startDate.add(Duration(days: dayOffset));
      int timePointIndex = i % 6;
      String timePoint = timePoints[timePointIndex];
      result.add('${targetDate.month}/${targetDate.day} $timePoint');
    }
    return result;
  }
}

class AssetsDrawPie extends StatefulWidget {
  const AssetsDrawPie({super.key, this.array, this.limit = 8});
  final List? array;
  final int limit;

  @override
  State<StatefulWidget> createState() => AssetsChart2State();
}

class AssetsChart2State extends State<AssetsDrawPie> {
  List<Map<String, num>> dataArr = [];
  List colorArr = [
    const Color(0xFFFFB804),
    const Color(0xFF2871FF),
    const Color(0xFF3ADECA),
    const Color(0xFF0067B9),
    const Color(0xFFCCCCCC),
  ];
  int currentIndex = 0;
  int? stateIndex;
  num sum = 1;
  @override
  Widget build(BuildContext context) {
    if (widget.array != null) {
      dataArr.clear();
      for (var element in widget.array!) {
        Map dict = element;
        dataArr.add({dict.keys.first: dict.values.first});
      }
      if (dataArr.length > widget.limit) {
        num sum = dataArr.sublist(widget.limit).fold(0, (acc, map) => acc + map.values.first);
        List<Map<String, num>> processArr = dataArr.sublist(0, widget.limit);
        processArr.add({'Other': sum});
        dataArr = processArr;
      }
      currentIndex = stateIndex != null
          ? stateIndex!
          : dataArr.indexOf(dataArr.firstWhere((element) => element.values.first > 0, orElse: () => dataArr.first));

      sum = dataArr.fold(0, (acc, map) => acc + map.values.first);
    }
    return dataArr.isNotEmpty
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 134.w,
                    height: 134.w,
                    child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        // centerSpaceColor: Colors.amber,
                        centerSpaceRadius: 47.w,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(dataArr[currentIndex].keys.first.tr, style: AppTextStyle.f_13_400.color333333),
                      Text('${((dataArr[currentIndex].values.first / sum) * 100).toStringAsFixed(2)}%',
                          style: AppTextStyle.f_16_500.color333333)
                    ],
                  ),
                ],
              ),
              Expanded(child: getTag())
            ],
          )
        : const SizedBox();
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> array = [];
    for (var i = 0; i < dataArr.length; i++) {
      var value = dataArr[i].values.first.toDouble();
      array.add(PieChartSectionData(color: colorArr[i], value: value, radius: 20.w, title: ''));
    }
    return array;
  }

  Widget getTag() {
    // num sum = dataArr.fold(0, (acc, map) => acc + map.values.first);

    List<Widget> array = [];
    for (var i = 0; i < dataArr.length; i++) {
      var name = dataArr[i].keys.first.contains('-') == true ? dataArr[i].keys.first.split('-').first : dataArr[i].keys.first;

      var value = dataArr[i].values.first;
      if (value > 0) {
        array.add(GestureDetector(
          onTap: () {
            setState(() {
              stateIndex = i;
            });
          },
          child: AssetsIndicator(
              color: colorArr[i],
              text: name,
              isSquare: false,
              isSelected: i == currentIndex,
              textNumber: '${((value / sum) * 100).toStringAsFixed(2)}%'),
        ));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: array);
  }
}

class AssetsIndicator extends StatelessWidget {
  const AssetsIndicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 8,
    this.textColor,
    required this.textNumber,
    required this.isSelected,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;
  final String textNumber;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 38.w, bottom: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
      decoration: ShapeDecoration(
        color: isSelected ? AppColor.colorF9F9F9 : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: size.w,
            height: size.w,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: 7.w),
          Text(text, style: AppTextStyle.f_14_500.color4D4D4D),
          const Spacer(),
          Text(textNumber, style: AppTextStyle.f_13_500.color333333)
        ],
      ),
    );
  }
}
