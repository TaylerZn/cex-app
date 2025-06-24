import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_draw.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowQuestionrDrawRadar extends StatelessWidget {
  final num basicSupport ; // 基础支持分
  final num liquidity ; // 流动性分
  final num riskTolerance ; // 风险承受能力分
  final num investmentKnowledge ; // 投资经验分
  final num investmentPreference ; // 投资偏好
  const FollowQuestionrDrawRadar({super.key, required this.basicSupport, required this.liquidity, required this.riskTolerance, required this.investmentKnowledge, required this.investmentPreference});

  @override
Widget build(BuildContext context) {
  return SizedBox(
    width: 356.w,
    height: 174.w,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Column(
            children: <Widget>[
              Text(LocaleKeys.follow428.tr, style: AppTextStyle.f_12_400.color7E7E7E), //'基础知识'
              Spacer(),
              Row(
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
                            Expanded(
                              child: Text(
                                LocaleKeys.follow416.tr, //'投资偏好',
                                style: AppTextStyle.f_12_400.color7E7E7E,
                                // overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Spacer(),
                            Expanded(
                              child: Text(
                                LocaleKeys.follow521.tr, //'风险承受',
                                style: AppTextStyle.f_12_400.color7E7E7E,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 10.w),
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
                              Expanded(
                                child: Text(
                                  LocaleKeys.follow405.tr, //'投资知识',
                                  style: AppTextStyle.f_12_400.color7E7E7E,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
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
                              Expanded(
                                child: Text(
                                  LocaleKeys.follow407.tr, //'资金流动性',
                                  style: AppTextStyle.f_12_400.color7E7E7E,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          width: 148.w,
          height: 148.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              FollowPolygon(
                width: 148.w,
                sides: 5,
                borderColor: AppColor.color2E2E2E,
              ),
              FollowPolygon(
                width: 112.w,
                sides: 5,
                borderColor: AppColor.color2E2E2E,
              ),
              FollowPolygon(
                width: 76.w,
                sides: 5,
                borderColor: AppColor.color2E2E2E,
              ),
              FollowPolygon(
                width: 40.w,
                sides: 5,
                borderColor: AppColor.color2E2E2E,
              ),
              Container(
                width: 148.w,
                height: 148.w,
                child: RadarChart(
                  RadarChartData(
                    radarShape: RadarShape.polygon,
                    dataSets: [
                      RadarDataSet(
                        fillColor: const Color(0xFFFFD429).withOpacity(0.05),
                        borderColor: const Color(0xFFFFD429),
                        entryRadius: 1,
                        dataEntries: [
                          RadarEntry(value: basicSupport.toDouble()),
                          RadarEntry(value: riskTolerance.toDouble()),
                          RadarEntry(value: liquidity.toDouble()),
                          RadarEntry(value: investmentKnowledge.toDouble()),
                          RadarEntry(value: investmentPreference.toDouble()),
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
            ],
          ),
        ),
      ],
    ),
  );
}
}

class FollowQuestionPercentage extends StatelessWidget {
  const FollowQuestionPercentage(
      {super.key,
      required this.percentage,
      this.width = 84,
      this.height = 4,
      required this.leftText});

  final double percentage;
  final double width;
  final double height;
  final String leftText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            width: 50.w,
            child: Text('${percentage * 100}%',
                    style: AppTextStyle.f_8_500.color666666.ellipsis)
                .paddingOnly(left: 4.w)),
        Stack(
          children: [
            Container(
              width: width.w,
              height: height.w,
              decoration: ShapeDecoration(
                color: AppColor.colorF1F1F1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            ),
            Container(
              width: width.w * percentage,
              height: height.w,
              decoration: ShapeDecoration(
                color: AppColor.upColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
