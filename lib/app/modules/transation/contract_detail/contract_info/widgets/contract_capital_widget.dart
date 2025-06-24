import 'dart:collection';

import 'package:common_utils/common_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/capital_list_info.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../api/contract/contract_api.dart';
import '../../../../../models/contract/res/funding_rate.dart';
import '../../../../../models/contract/res/public_info.dart';
import '../../../../../widgets/no/loading_widget.dart';

class ContractCapitalWidget extends StatefulWidget {
  const ContractCapitalWidget({super.key, this.contractInfo});

  final ContractInfo? contractInfo;

  @override
  State<ContractCapitalWidget> createState() => _ContractCapitalWidgetState();
}

class _ContractCapitalWidgetState extends State<ContractCapitalWidget> {
  FundingRate? fundRate;
  CapitalListInfo? capitalListInfo;

  @override
  void initState() {
    super.initState();
    Get.engine.addPostFrameCallback((timeStamp) async {
      if (widget.contractInfo == null) return;
      if (widget.contractInfo!.contractType.contains('B')) {
        CommodityApi.instance()
            .getMarketInfo(widget.contractInfo!.symbol, widget.contractInfo!.id)
            .then((value) {
          if (mounted) {
            setState(() {
              fundRate = value;
            });
          }
        });
        CommodityApi.instance()
            .fundingRateList(widget.contractInfo!.id, 10, 1)
            .then((value) {
          capitalListInfo = value;

          /// 时间排序
          if (mounted) {
            setState(() {});
          }
        });
      } else {
        ContractApi.instance()
            .getMarketInfo(widget.contractInfo!.symbol, widget.contractInfo!.id)
            .then((value) {
          if (mounted) {
            setState(() {
              fundRate = value;
            });
          }
        });

        ContractApi.instance()
            .fundingRateList(widget.contractInfo!.id, 10, 1)
            .then((value) {
          if (mounted) {
            setState(() {
              capitalListInfo = value;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return capitalListInfo == null
        ? const Center(child: LoadingWidget())
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${LocaleKeys.trade88.tr}： ${fundRate?.currentFundRate == null ? '--' : (fundRate!.currentFundRate! * 100).toPrecision(5)}%',
                  style: AppTextStyle.f_16_500.color111111,
                ).marginSymmetric(horizontal: 16.w),
                26.verticalSpace,
                Container(
                  padding: EdgeInsets.only(left: 0, right: 16),
                  height: 160.h,
                  child: line(),
                ),
                20.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.verticalSpace,
                    Text(
                      LocaleKeys.trade87.tr,
                      style: AppTextStyle.f_16_500.colorTextPrimary,
                    ),
                    12.verticalSpaceFromWidth,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          LocaleKeys.trade89.tr,
                          style: AppTextStyle.f_11_500.color999999,
                        ),
                        Text(
                          LocaleKeys.trade88.tr,
                          style: AppTextStyle.f_11_500.color999999,
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: capitalListInfo?.historyList.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        var info = capitalListInfo!.historyList[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              DateUtil.formatDateMs(info.ctime),
                              style: AppTextStyle.f_12_400.color333333,
                            ),
                            Text(
                              '${(info.amount * 100).toNum().toPrecision(5)}%',
                              style: AppTextStyle.f_12_500.color333333,
                            ),
                          ],
                        ).marginOnly(bottom: 16.h);
                      },
                    ),
                  ],
                ).marginSymmetric(horizontal: 16.w),
              ],
            ),
          );
  }

  _getMinY() {
    double minY = 0;
    double maxY = 0;
    capitalListInfo?.historyList.forEach((element) {
      if (element.amount < minY) {
        minY = element.amount;
      }
      if (element.amount > maxY) {
        maxY = element.amount;
      }
    });
    minY = minY * 100;
    maxY = maxY * 100;
    return [minY, maxY]; // 返回最小值，最大值，间隔
  }

  Widget line() {
    /// 去除重复的数据
    LinkedHashMap<String, List<BrokenLineListElement>> hashMap =
        LinkedHashMap();
    capitalListInfo?.historyList.forEach((element) {
      String time = DateUtil.formatDateMs(element.ctime, format: 'yyyy-MM-dd');
      if (hashMap.containsKey(time)) {
        List<BrokenLineListElement> list = hashMap[time]!;
        if (list.indexWhere((e) => e.amount == element.amount) == -1) {
          list.add(element);
          hashMap[time] = list;
        }
      } else {
        hashMap[time] = [element];
      }
    });
    List<BrokenLineListElement> list =
        hashMap.values.expand((element) => element).toList();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: list
                        .map(
                          (e) =>
                              FlSpot((e.ctime).toDouble(), e.amount * 100),
                        ) // Convert amount to percentage
                        .toList() ??
                    [],
                isCurved: true,
                color: Colors.black,
                barWidth: 1,
                isStepLineChart: false,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: false,
                ),
              ),
            ],
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  getTitlesWidget: (value, meta) {
                    final date =
                        DateTime.fromMillisecondsSinceEpoch((value).toInt());
                    // if(value == capitalListInfo?.historyList.first.ctime || value == capitalListInfo?.historyList.last.ctime) return const SizedBox();
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 0,
                      child: Text(
                        DateUtil.formatDate(date, format: 'MM-dd'),
                        style: AppTextStyle.f_10_300.color666666,
                      ),
                    );
                  },
                  // reservedSize: 0,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 60.w,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        '${NumberUtil.getPrice(value, 5)}%',
                        // Convert to percentage format
                        style: AppTextStyle.f_10_400.colorTextDescription,
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              drawVerticalLine: false,
              drawHorizontalLine: true,
              // horizontalInterval: (_getMinYAndMaxy()[1] - _getMinYAndMaxy()[0]) / 4,
              getDrawingHorizontalLine: (value) {
                return const FlLine(color: AppColor.colorEEEEEE, strokeWidth: 0.4);
              },
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                top: BorderSide(color: AppColor.colorEEEEEE, width: 0.4),
                bottom: BorderSide(color: AppColor.colorEEEEEE, width: 0.4),
              ),
            ),
            minY: _getMinY()[0],
          ),
        ),
        Positioned(
          right: 0,
          bottom: -20,
          child: Container(
            width: Get.width - 60.w,
           child: Row(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: list.reversed.map((e) {
                  final date =
               DateTime.fromMillisecondsSinceEpoch((e.ctime).toInt());
               return Text(
                 DateUtil.formatDate(date, format: 'MM-dd'),
                 style: AppTextStyle.f_10_400.colorTextDescription,
               );
             }).toList(),
           ),
          ),
        ),
      ],
    );
  }
}
