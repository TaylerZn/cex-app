// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_traderdetail.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_cell_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowTakerDrawLine extends StatefulWidget {
  const FollowTakerDrawLine({super.key, this.monthProfit});
  final List? monthProfit;

  @override
  State<FollowTakerDrawLine> createState() => _FollowTakerDrawLineState();
}

class _FollowTakerDrawLineState extends State<FollowTakerDrawLine> {
  bool allPositive = false;
  bool allNegative = false;
  double maxValue = double.negativeInfinity;
  double minValue = double.infinity;
  double maxAbsoluteNumber = 0;
  final List<String> dates = [];

  @override
  Widget build(BuildContext context) {
    double maxIndex = 0;
    double minIndex = 0;

    allPositive = false;
    allNegative = false;
    maxValue = double.negativeInfinity;
    minValue = double.infinity;
    maxAbsoluteNumber = 0;

    List<FlSpot> spotArray = [];
    if (widget.monthProfit != null && widget.monthProfit!.isNotEmpty) {
      for (var i = 0; i < widget.monthProfit!.length; i++) {
        spotArray.add(FlSpot((i + 0) * 1.0, (widget.monthProfit![i] * 1.0)));

        if (widget.monthProfit![i] > maxValue) {
          maxValue = widget.monthProfit![i] * 1.0;
          maxIndex = i * 1.0;
        }
        if (widget.monthProfit![i] < minValue) {
          minValue = widget.monthProfit![i] * 1.0;
          minIndex = i * 1.0;
        }
      }
      dates.clear();
      dates.addAll(getDates(DateTime.now(), (widget.monthProfit!.length / 7).ceil()));
      maxAbsoluteNumber = maxValue.abs() > minValue.abs() ? maxValue.abs() : minValue.abs();
      allPositive = widget.monthProfit!.every((element) => element >= 0);
      allNegative = widget.monthProfit!.every((element) => element <= 0);
    }

    return widget.monthProfit != null
        ? SizedBox(
            height: 156.h,
            child: LayoutBuilder(builder: (context, c) {
              return Stack(
                children: [
                  Column(
                    children: [
                      getTopWidget(),
                      Container(
                        // color: Colors.amber,
                        height: 12.h,
                        padding: EdgeInsets.only(left: 36.w, right: 15.w),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: dates
                                .map((e) => Text(
                                      e,
                                      style: AppTextStyle.f_10_500.color999999,
                                    ))
                                .toList()),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 36.w,
                    top: 24.h,
                    right: 0,
                    bottom: 36.h,
                    child: LineChart(
                      LineChartData(
                          // backgroundColor: Colors.pink,
                          lineTouchData: const LineTouchData(enabled: false),
                          gridData: const FlGridData(drawVerticalLine: false, drawHorizontalLine: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: spotArray,
                              isCurved: true,
                              preventCurveOverShooting: true,
                              curveSmoothness: 0.5,
                              color: AppColor.upColor,
                              barWidth: 2,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green.withOpacity(0.3),
                                    Colors.green.withOpacity(0.1),
                                    Colors.green.withOpacity(0.0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              dotData: const FlDotData(
                                show: false,
                              ),
                            ),
                          ],
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: widget.monthProfit!.length.toDouble(),
                          minY: getminY(),
                          maxY: getmaxY()),
                    ),
                  ),
                  Positioned(
                    left: (maxIndex / widget.monthProfit!.length) < 0.5
                        ? 40.w + (maxIndex / widget.monthProfit!.length) * (c.maxWidth - 36.w)
                        : 36.w + (maxIndex / widget.monthProfit!.length) * (c.maxWidth - 56.w),
                    top: 12.h,
                    child: Container(
                      // color: Colors.black,
                      child: Text(
                        getmaxYText(),
                        style: AppTextStyle.f_10_500.upColor,
                      ),
                    ),
                  ),
                  Positioned(
                    left: (minIndex / widget.monthProfit!.length) < 0.5
                        ? 40.w + (minIndex / widget.monthProfit!.length) * (c.maxWidth - 36.w)
                        : 36.w + (minIndex / widget.monthProfit!.length) * (c.maxWidth - 56.w),
                    bottom: 24.h,
                    child: Text(
                      getminYText(),
                      style: AppTextStyle.f_10_500.upColor,
                    ),
                  ),
                ],
              );
            }),
          )
        : const SizedBox();
  }

  Widget getTopWidget() {
    List array = getLeftSide();
    List<Widget> widgetArr = [];
    for (var i = 0; i < array.length; i++) {
      var alignment = i < 2
          ? Alignment.topCenter
          : i == array.length - 1
              ? Alignment.bottomCenter
              : Alignment.center;
      var e = Expanded(
        child: Container(
          alignment: alignment,
          child: Row(
            children: [
              SizedBox(
                width: 26.w,
                child: AutoSizeText('${formatterNum(array[i], 1)}%',
                    textAlign: TextAlign.right, maxLines: 1, minFontSize: 4, style: AppTextStyle.f_10_500.color999999),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 0.5,
                  color: AppColor.colorF5F5F5,
                ),
              )
            ],
          ),
        ),
      );
      widgetArr.add(e);
    }

    return Expanded(
      child: Container(
          // color: Colors.red,
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: widgetArr)),
    );
  }

  List<double> getLeftSide() {
    if (maxValue == minValue) {
      return maxValue == 0
          ? [minValue + 10, minValue + 5, minValue, -(minValue + 5), -(minValue + 10)]
          : [1.2 * maxValue, 1.1 * maxValue, maxValue, -(1.1 * maxValue), -(1.2 * maxValue)];
    } else {
      if (allPositive) {
        return [
          1.2 * maxValue,
          (maxValue + minValue) * 0.75,
          (maxValue + minValue) * 0.5,
          (maxValue + minValue) * 0.25,
          minValue == 0 ? -(maxValue * 0.25) : 0.8 * minValue
        ];
      } else if (allNegative) {
        return [
          maxValue == 0 ? -(minValue * 0.25) : 0.8 * maxValue,
          (maxValue + minValue) * 0.25,
          (maxValue + minValue) * 0.5,
          (maxValue + minValue) * 0.75,
          1.2 * minValue,
        ];
      } else {
        return [maxValue * 1.2, maxValue * 0.5, 0, minValue * 0.5, minValue * 1.2];
      }
    }
  }

  String getminYText() {
    if (maxValue == minValue) {
      return '';
    } else {
      return '${formatterNum(minValue, 1)}%';
    }
  }

  String getmaxYText() {
    if (maxValue == minValue) {
      return '';
    } else {
      return '${formatterNum(maxValue, 1)}%';
    }
  }

  double getminY() {
    if (maxValue == minValue) {
      return minValue == 0
          ? -10
          : minValue > 0
              ? 0.8 * maxValue
              : 1.2 * maxValue;
    } else {
      return minValue;
    }
  }

  double getmaxY() {
    if (maxValue == minValue) {
      return maxValue == 0
          ? 10
          : maxValue > 0
              ? 1.2 * maxValue
              : 0.8 * maxValue;
    } else {
      return maxValue;
    }
  }

  List<String> getDates(DateTime baseDate, int count) {
    List<String> result = [];
    for (int i = 0; i < count; i++) {
      DateTime currentDate = baseDate.subtract(Duration(days: i * 7));
      String dateString = '${currentDate.month}/${currentDate.day}';
      result.add(dateString);
    }
    return result.reversed.toList();
  }

  // Widget leftTitleWidgets(double value, TitleMeta meta) {
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     child: Text(
  //       '$value',
  //       style: AppTextStyle.small3_500.color999999,
  //     ),
  //   );
  // }

  Widget bottomTitles(double value, TitleMeta meta) {
    int index = value.toInt() ~/ 7;
    final Widget textWidget = Text(
      dates[index],
      style: AppTextStyle.f_10_500.color999999,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: textWidget,
    );
  }
}

class FollowTakerDrawPie extends StatefulWidget {
  const FollowTakerDrawPie({super.key, this.array});
  final List<PositionPreferencesModel>? array;
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<FollowTakerDrawPie> {
  List<PositionPreferencesModel> dataArr = [];
  var currentModel = PositionPreferencesModel();
  num sum = 0;

// FFB904
// 4484FF
// 3ADFCB
// 9278BE
// 0067B9
// 9278BE
  List colorArr = [
    const Color(0xFFFFB904),
    const Color(0XFF4484FF),
    const Color(0XFF3ADFCB),
    const Color(0XFF0067B9),
    const Color(0XFF9278BE),
    const Color(0XFFF6D836),
    const Color(0XFFA786DF),
    const Color(0XFFFFC0AD),
    const Color(0XFFFF8E3C),
    const Color(0XFF50A1FF),
    const Color(0XFF50A1FF),
  ];
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.array != null) {
      dataArr.clear();
      for (var element in widget.array!) {
        dataArr.add(element);
      }
      dataArr.sort((a, b) => b.longValue.compareTo(a.longValue));

      if (dataArr.length > 5) {
        num sum = dataArr.sublist(5).fold(0, (acc, map) => acc + map.longValue);
        List<PositionPreferencesModel> processArr = dataArr.sublist(0, 5);
        processArr.add(PositionPreferencesModel(key: 'Other', longValue: sum));
        dataArr = processArr;
      }

      sum = dataArr.fold(0, (acc, map) => acc + map.longValue);
    }
    return dataArr.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180.w,
                    height: 180.w,
                    child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 2,
                        centerSpaceRadius: 70.w,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                    height: 180.w,
                    child: PieChart(
                      swapAnimationDuration: const Duration(milliseconds: 0),
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              var index = pieTouchResponse?.touchedSection?.touchedSectionIndex;
                              if (index != null && index >= 0) {
                                selectIndex = index;
                              }
                            });
                          },
                        ),
                        sectionsSpace: 2,
                        centerSpaceRadius: 66.w,
                        sections: showingSections2(),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        dataArr[selectIndex].key.contains('-') == true
                            ? dataArr[selectIndex].key.split('-').first
                            : dataArr[selectIndex].key,
                        style: AppTextStyle.f_15_600.color333333,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${((dataArr[selectIndex].longValue / sum) * 100).toStringAsFixed(2)}%',
                            style: AppTextStyle.f_11_400.color333333,
                          ),
                          4.horizontalSpace,
                          Text(
                            dataArr[selectIndex].amountStr,
                            style: AppTextStyle.f_11_400.color999999,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              16.verticalSpace,
              getTag()
            ],
          )
        : const SizedBox();
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> array = [];
    for (var i = 0; i < dataArr.length; i++) {
      var value = dataArr[i].longValue.toDouble();
      array.add(PieChartSectionData(color: colorArr[i], value: value, radius: 10.w, title: ''));
    }
    return array;
  }

  List<PieChartSectionData> showingSections2() {
    List<PieChartSectionData> array = [];
    for (var i = 0; i < dataArr.length; i++) {
      var value = dataArr[i].longValue.toDouble();
      array.add(PieChartSectionData(
          color: i == selectIndex ? colorArr[i] : Colors.transparent, value: value, radius: 18.w, title: ''));
    }
    return array;
  }

  Widget getTag() {
    List<Widget> array = [];
    for (var i = 0; i < dataArr.length; i++) {
      var name = dataArr[i].key.contains('-') == true ? dataArr[i].key.split('-').first : dataArr[i].key;

      var value = dataArr[i].longValue;
      array.add(
        InkWell(
          onTap: () {
            setState(() {
              selectIndex = i;
            });
          },
          child: Container(
            width: 166.w,
            padding: EdgeInsets.all(6.w),
            decoration: ShapeDecoration(
              color: i == selectIndex ? AppColor.colorF9F9F9 : Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: Indicator(
                color: colorArr[i], text: name, amountStr: value, textNumber: '${((value / sum) * 100).toStringAsFixed(2)}%'),
          ),
        ),
      );
    }
    return Wrap(spacing: 10.w, runSpacing: 8.w, children: array);
  }
}

class FollowTakerDrawProgress extends StatelessWidget {
  const FollowTakerDrawProgress(
      {super.key, required this.left, required this.right, this.leftColor, this.rightColor, this.height, this.marginTop});
  final num left;
  final num right;
  final Color? leftColor;
  final Color? rightColor;
  final double? height;
  final double? marginTop;

  @override
  Widget build(BuildContext context) {
    int flexL = 0;
    int flexR = 0;
    if (left == right) {
      flexL = 50;
      flexR = 50;
    } else if (right == 0) {
      flexL = 100;
    } else if (left == 0) {
      flexR = 100;
    } else {
      flexL = ((left / (left + right) * 1.0) * 100).floor();
      flexR = ((right / (left + right) * 1.0) * 100).ceil();
    }

    return LayoutBuilder(builder: (context, c) {
      return Container(
        margin: EdgeInsets.only(top: marginTop ?? 6.h),
        height: height ?? 6,
        child: Stack(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  flex: flexL,
                  child: Container(
                    decoration: BoxDecoration(
                        color: leftColor ?? AppColor.upColor,
                        borderRadius: BorderRadius.horizontal(
                            left: const Radius.circular(10), right: Radius.circular(flexL == 100 ? 10 : 0))),
                  ),
                ),
                Expanded(
                  flex: flexR,
                  child: Container(
                    decoration: BoxDecoration(
                        color: rightColor ?? AppColor.colorCCCCCC,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(flexR == 100 ? 10 : 0), right: const Radius.circular(10))),
                  ),
                ),
              ],
            ),
            (left == 0 || right == 0)
                ? const SizedBox()
                : Positioned(
                    top: 0,
                    bottom: 0,
                    left: c.maxWidth * (flexL * 0.01 - (height ?? 6) / c.maxWidth),
                    child: MyImage(
                      'flow/follow_progress'.svgAssets(),
                      height: height ?? 6,
                    ),
                  ),
          ],
        ),
      );
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    this.size = 8,
    this.textColor,
    required this.textNumber,
    required this.amountStr,
  });
  final Color color;
  final String text;
  final double size;
  final Color? textColor;
  final String textNumber;
  final num amountStr;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 7.w),
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(text, style: AppTextStyle.f_12_500.color4D4D4D),
            2.verticalSpace,
            Text('$amountStr${LocaleKeys.follow466.tr}', style: AppTextStyle.f_8_400.color999999)
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('$textNumber%', style: AppTextStyle.f_12_500.color4D4D4D),
          ],
        )
      ],
    );
  }
}

class FollowTakerDrawBar extends StatelessWidget {
  FollowTakerDrawBar({
    super.key,
    this.monthProfit,
  });
  final List? monthProfit;
  final List<double> sumForEachGroup = [];
  final List<BarChartGroupData> dataArray = [];
  final List<String> titles = [];

  @override
  Widget build(BuildContext context) {
    double maxAbsoluteNumber = 0;
    bool hasNegative = false;
    if (monthProfit != null && monthProfit!.isNotEmpty) {
      for (int i = 0; i < monthProfit!.length; i += 7) {
        int endIndex = (i + 7 <= monthProfit!.length) ? i + 7 : monthProfit!.length;
        List group = monthProfit!.sublist(i, endIndex);
        double sum = group.fold(0, (sum, element) => sum + element);

        var bar = BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: sum,
              color: sum > 0 ? AppColor.upColor : AppColor.downColor,
              width: 20,
              borderRadius: BorderRadius.zero,
            ),
          ],
        );

        dataArray.add(bar);
        sumForEachGroup.add(sum);
      }
      maxAbsoluteNumber = sumForEachGroup.map((e) => e.abs()).reduce((value, element) => value > element ? value : element);
      hasNegative = sumForEachGroup.any((element) => element < 0);

      for (var i = 0; i < sumForEachGroup.length; i++) {
        if (i == 0) {
          titles.add('近${sumForEachGroup.length}周');
        } else {
          titles.add('${sumForEachGroup.length - i}周');
        }
      }
    }

    return monthProfit != null
        ? Row(
            children: [
              Container(
                // color: Colors.red,
                height: 152.h,
                width: 35.w,
                padding: const EdgeInsets.only(right: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      maxAbsoluteNumber,
                      (maxAbsoluteNumber.floor() - 5) / 2.0,
                      0,
                      (5 - maxAbsoluteNumber.floor()) / 2.0,
                      -maxAbsoluteNumber
                    ]
                        .map((e) => Expanded(
                              child: Text(
                                e.toStringAsFixed(1),
                                style: AppTextStyle.f_10_500.color999999,
                              ),
                            ))
                        .toList()),
              ),
              Expanded(
                child: SizedBox(
                  height: 152.h,
                  child: BarChart(
                    BarChartData(
                        gridData: FlGridData(
                            drawVerticalLine: false,
                            horizontalInterval: (maxAbsoluteNumber.floor() - 5) / 2.0,
                            getDrawingHorizontalLine: (v) {
                              return const FlLine(color: AppColor.colorEEEEEE, strokeWidth: 1);
                            }),
                        alignment: BarChartAlignment.spaceAround,
                        minY: -maxAbsoluteNumber,
                        maxY: maxAbsoluteNumber,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(),
                          topTitles: const AxisTitles(),
                          rightTitles: const AxisTitles(),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true, getTitlesWidget: bottomTitles),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: dataArray),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    int index = value.toInt() ~/ 7;
    final Widget textWidget = Text(
      titles[index],
      style: AppTextStyle.f_10_500.color999999,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: textWidget,
    );
  }
}

class FollowStarWidget extends StatefulWidget {
  final double score;
  final int max;
  final double size;
  final double offsetX;
  final List? bottomWidgetArr;
  final double bottomTopOffset;
  final Color? color;
  final bool isHollow;
  final Function(int)? callback;

  const FollowStarWidget(
      {super.key,
      required this.score,
      this.max = 5,
      this.size = 20,
      this.offsetX = 0,
      this.bottomTopOffset = 0,
      this.bottomWidgetArr,
      this.color = AppColor.upColor,
      this.callback,
      this.isHollow = true});
  @override
  State<StatefulWidget> createState() => _FollowStarWidgetState();
}

class _FollowStarWidgetState extends State<FollowStarWidget> {
  double currentCount = 0;

  @override
  void initState() {
    super.initState();
    currentCount = widget.score;
  }

  @override
  Widget build(BuildContext context) {
    var startWidget = Stack(
      children: <Widget>[
        Row(mainAxisSize: MainAxisSize.min, children: unStar()),
        Row(mainAxisSize: MainAxisSize.min, children: star()),
      ],
    );
    if (widget.bottomWidgetArr?.length == widget.max) {
      return Column(
        children: <Widget>[
          startWidget,
          Padding(
            padding: EdgeInsets.only(top: widget.bottomTopOffset.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...widget.bottomWidgetArr!
                    .map((e) => SizedBox(width: widget.size.w + widget.offsetX.w, child: Center(child: Text(e))))
              ],
            ),
          )
        ],
      );
    } else {
      return startWidget;
    }
  }

  List<Widget> unStar() {
    return List.generate(widget.max, (index) {
      return Padding(
          padding: EdgeInsets.only(right: index < widget.max - 1 ? widget.offsetX.w : 0),
          child: widget.isHollow
              ? MyImage(
                  'flow/follow_unStart'.svgAssets(),
                  width: widget.size.w,
                  color: widget.color,
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      currentCount = (index + 1).toDouble();
                    });
                    widget.callback?.call(index + 1);
                  },
                  child: MyImage(
                    'flow/follow_start'.svgAssets(),
                    width: widget.size.w,
                    color: AppColor.colorDDDDDD,
                  ),
                ));
    });
  }

  List<Widget> star() {
    List<Widget> stars = [];
    final star = MyImage(
      'flow/follow_start'.svgAssets(),
      width: widget.size.w,
      color: widget.color,
    );

    int fullStarCount = (currentCount / 1.0).floor();
    for (var i = 0; i < fullStarCount; i++) {
      stars.add(Padding(
          padding: EdgeInsets.only(
              right: fullStarCount < widget.max
                  ? widget.offsetX.w
                  : i < widget.max - 1
                      ? widget.offsetX.w
                      : 0),
          child: InkWell(
              onTap: () {
                setState(() {
                  currentCount = (i + 1).toDouble();
                });
                widget.callback?.call(i + 1);
              },
              child: star)));
    }

    double leftWidth = (currentCount - 1.0 * fullStarCount) / 1.0 * widget.size;

    final partStar = ClipRect(
      clipper: FollowStarWidgetClipper(width: leftWidth),
      child: Padding(padding: EdgeInsets.only(right: fullStarCount == widget.max - 1 ? 0 : widget.offsetX.w), child: star),
    );
    stars.add(partStar);
    if (stars.length > widget.max) {
      return stars.sublist(0, widget.max);
    }
    return stars;
  }
}

class FollowStarWidgetClipper extends CustomClipper<Rect> {
  double width;
  FollowStarWidgetClipper({required this.width});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(covariant FollowStarWidgetClipper oldClipper) {
    return oldClipper.width != width;
  }
}

class FollowTakerDrawRadar extends StatelessWidget {
  const FollowTakerDrawRadar({super.key, required this.copyTrader, required this.copyTraderAvgCount});

  final FollowTraderScore copyTrader;
  final FollowTraderScore copyTraderAvgCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 343.w,
          height: 277.w,
          // color: Colors.green,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(copyTrader.yieldRateStr, style: AppTextStyle.f_13_600.upColor),
                                Text('/', style: AppTextStyle.f_13_600.colorECECEC),
                                Text(copyTraderAvgCount.yieldRateStr, style: AppTextStyle.f_13_600.color0075FF),
                              ],
                            ),
                            Text(LocaleKeys.follow314.tr, style: AppTextStyle.f_9_400.color999999),
                          ],
                        ),
                      ),
                      100.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(copyTrader.transactionCountStr, style: AppTextStyle.f_13_600.upColor),
                                Text('/', style: AppTextStyle.f_13_600.colorECECEC),
                                Text(copyTraderAvgCount.transactionCountStr, style: AppTextStyle.f_13_600.color0075FF),
                              ],
                            ),
                            Text(LocaleKeys.follow315.tr, style: AppTextStyle.f_9_400.color999999),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(copyTrader.copyWinRateStr, style: AppTextStyle.f_13_600.upColor),
                              Text('/', style: AppTextStyle.f_13_600.colorECECEC),
                              Text(copyTraderAvgCount.copyWinRateStr, style: AppTextStyle.f_13_600.color0075FF),
                            ],
                          ),
                          Text(LocaleKeys.follow319.tr, style: AppTextStyle.f_9_400.color999999),
                        ],
                      ),
                    ),
                    200.horizontalSpace,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(copyTrader.reputationStr, style: AppTextStyle.f_13_600.upColor),
                              Text('/', style: AppTextStyle.f_13_600.colorECECEC),
                              Text(copyTraderAvgCount.reputationStr, style: AppTextStyle.f_13_600.color0075FF),
                            ],
                          ),
                          Text(LocaleKeys.follow316.tr, style: AppTextStyle.f_9_400.color999999),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(copyTrader.copyTotalStr, style: AppTextStyle.f_13_600.upColor),
                                Text('/', style: AppTextStyle.f_13_600.colorECECEC),
                                Text(copyTraderAvgCount.copyTotalStr, style: AppTextStyle.f_13_600.color0075FF),
                              ],
                            ),
                            Text(LocaleKeys.follow318.tr, style: AppTextStyle.f_9_400.color999999),
                          ],
                        ),
                      ),
                      100.horizontalSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(copyTrader.wealthStr, style: AppTextStyle.f_13_600.upColor),
                                Text('/', style: AppTextStyle.f_13_600.colorECECEC),
                                Text(copyTraderAvgCount.wealthStr, style: AppTextStyle.f_13_600.color0075FF),
                              ],
                            ),
                            Text(LocaleKeys.follow317.tr, style: AppTextStyle.f_9_400.color999999),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        FollowPolygon(width: 170.w),
        FollowPolygon(width: 130.w),
        FollowPolygon(width: 90.w),
        FollowPolygon(width: 50.w),
        Transform.rotate(
          angle: 30 * (3.14159 / 180),
          // angle: 0,

          child: Container(
            // color: Colors.amber,
            width: 205.w,
            height: 205.w,
            child: RadarChart(
              RadarChartData(
                radarShape: RadarShape.polygon,
                dataSets: [
                  RadarDataSet(
                    fillColor: const Color(0xFF2EBD87).withAlpha(15),
                    borderColor: const Color(0xFF2EBD87),
                    entryRadius: 1,
                    dataEntries: [
                      // RadarEntry(value: (copyTrader.yieldRate ?? 0).toDouble()),
                      // RadarEntry(value: (copyTrader.transactionCount ?? 0).toDouble()),
                      // RadarEntry(value: (copyTrader.reputation ?? 0).toDouble()),
                      // RadarEntry(value: (copyTrader.wealth ?? 0).toDouble()),
                      // RadarEntry(value: (copyTrader.copyTotal ?? 0).toDouble()),
                      // RadarEntry(value: (copyTrader.copyWinRate ?? 0).toDouble()),
                      RadarEntry(value: (copyTrader.transactionCount ?? 0).toDouble()),
                      RadarEntry(value: (copyTrader.reputation ?? 0).toDouble()),
                      RadarEntry(value: (copyTrader.wealth ?? 0).toDouble()),
                      RadarEntry(value: (copyTrader.copyTotal ?? 0).toDouble()),
                      RadarEntry(value: (copyTrader.copyWinRate ?? 0).toDouble()),

                      RadarEntry(value: (copyTrader.yieldRate ?? 0).toDouble()),

                      // RadarEntry(value: 100),
                      // RadarEntry(value: 10),
                      // RadarEntry(value: 10),
                      // RadarEntry(value: 10),
                      // RadarEntry(value: 10),
                      // RadarEntry(value: 10),
                    ],
                  ),
                  RadarDataSet(
                    fillColor: const Color(0xFF0075FF).withAlpha(15),
                    borderColor: const Color(0xFF0075FF),
                    entryRadius: 1,
                    dataEntries: [
                      // RadarEntry(value: (copyTraderAvgCount.yieldRate ?? 0).toDouble()),
                      // RadarEntry(value: (copyTraderAvgCount.transactionCount ?? 0).toDouble()),
                      // RadarEntry(value: (copyTraderAvgCount.reputation ?? 0).toDouble()),
                      // RadarEntry(value: (copyTraderAvgCount.wealth ?? 0).toDouble()),
                      // RadarEntry(value: (copyTraderAvgCount.copyTotal ?? 0).toDouble()),
                      // RadarEntry(value: (copyTraderAvgCount.copyWinRate ?? 0).toDouble()),

                      RadarEntry(value: (copyTraderAvgCount.transactionCount ?? 0).toDouble()),
                      RadarEntry(value: (copyTraderAvgCount.reputation ?? 0).toDouble()),
                      RadarEntry(value: (copyTraderAvgCount.wealth ?? 0).toDouble()),
                      RadarEntry(value: (copyTraderAvgCount.copyTotal ?? 0).toDouble()),
                      RadarEntry(value: (copyTraderAvgCount.copyWinRate ?? 0).toDouble()),
                      RadarEntry(value: (copyTraderAvgCount.yieldRate ?? 0).toDouble()),

                      // RadarEntry(value: 10),
                      // RadarEntry(value: 0),
                      // RadarEntry(value: 0),
                      // RadarEntry(value: 0),
                      // RadarEntry(value: 0),
                      // RadarEntry(value: 0),
                    ],
                  ),
                ],
                gridBorderData: const BorderSide(color: Colors.transparent),
                radarBorderData: const BorderSide(color: Colors.transparent),
                ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
                tickBorderData: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FollowPolygon extends StatelessWidget {
  final int sides;
  final double width;
  final Color borderColor;

  const FollowPolygon({super.key, this.sides = 6, this.width = 100.0, this.borderColor = AppColor.colorF5F5F5});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, width),
      painter: PolygonPainter(sides, width, borderColor),
    );
  }
}

class PolygonPainter extends CustomPainter {
  final int sides;
  final double width;
  final Color borderColor;

  PolygonPainter(this.sides, this.width, this.borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    for (int i = 0; i < sides; i++) {
      double angle;
      if (sides == 5) {
        angle = (2 * pi / sides) * i - pi / 2;
      } else {
        angle = (2 * pi / sides) * i;
      }
      double x = width / 2 + (width / 2) * cos(angle);
      double y = width / 2 + (width / 2) * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.transparent);

    canvas.drawPath(
        path,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
