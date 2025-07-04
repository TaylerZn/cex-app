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

class FollowQuestionrDrawRadarMin extends StatelessWidget {
  final num basicSupport; // 基础支持分
  final num liquidity; // 流动性分
  final num riskTolerance; // 风险承受能力分
  final num investmentKnowledge; // 投资经验分
  final num investmentPreference; // 投资偏好
  const FollowQuestionrDrawRadarMin(
      {super.key,
      required this.basicSupport,
      required this.liquidity,
      required this.riskTolerance,
      required this.investmentKnowledge,
      required this.investmentPreference});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126.w,
      height: 85.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Text(LocaleKeys.follow428.tr,
                    style: AppTextStyle.f_6_400.colorABABAB), //'基础知识'
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(LocaleKeys.follow416.tr, //'投资偏好',
                          style: AppTextStyle.f_6_400.colorABABAB),
                    ),
                    SizedBox(width: 74.w,),
                    Expanded(
                      child: Text(LocaleKeys.follow521.tr, //'风险承受',
                        style: AppTextStyle.f_6_400.colorABABAB,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(LocaleKeys.follow405.tr, //'投资知识',
                            style: AppTextStyle.f_6_400.colorABABAB),
                      ),
                      56.horizontalSpace,
                      Expanded(
                        child:  Text(
                          LocaleKeys.follow407.tr, //'资金流动性',
                          style: AppTextStyle.f_6_400.colorABABAB,
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
              width: 74.w,
              height: 74.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FollowPolygon(
                    width: 74.w,
                    sides: 5,
                    borderColor: AppColor.colorF6F6F6,
                  ),
                  FollowPolygon(
                      width: 56.w, sides: 5, borderColor: AppColor.colorF6F6F6),
                  FollowPolygon(
                      width: 38.w, sides: 5, borderColor: AppColor.colorF6F6F6),
                  FollowPolygon(
                      width: 20.w, sides: 5, borderColor: AppColor.colorF6F6F6),
                  Container(
                    // color: Colors.amber,
                    width: 74.w,
                    height: 74.w,
                    child: RadarChart(
                      RadarChartData(
                        radarShape: RadarShape.polygon,
                        dataSets: [
                          RadarDataSet(
                            fillColor: const Color(0xFF2EBD87).withAlpha(0),
                            borderColor: const Color(0xFF2EBD87),
                            entryRadius: 1,
                            dataEntries: [
                              RadarEntry(value: basicSupport.toDouble()),
                              RadarEntry(value: riskTolerance.toDouble()),
                              RadarEntry(value: liquidity.toDouble()),
                              RadarEntry(value: investmentKnowledge.toDouble()),
                              RadarEntry(
                                  value: investmentPreference.toDouble()),
                            ],
                          ),
                        ],
                        gridBorderData:
                            const BorderSide(color: Colors.transparent),
                        radarBorderData:
                            const BorderSide(color: Colors.transparent),
                        ticksTextStyle: const TextStyle(
                            color: Colors.transparent, fontSize: 0),
                        tickBorderData:
                            const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ],
              )),
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
