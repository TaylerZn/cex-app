import 'dart:ui';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowkolTraderDetailModel with PagingModel, PagingError {
  num winRate = 0;
  num traderProfitDay = 0;
  num traderLossesDay = 0;
  num traderTotalMargin = 0;
  num avgOrderAmount = 0;
  num traderTotalAmount = 0;
  num tokenEquity = 0;
  num singleMinAmount = 0;
  num singleMaxAmount = 0;
  num totalNumber = 0;
  num weekDayFollowNum = 0;
  num currentNumber = 0;
  num followProfit = 0;
  List? monthProfit;
  List? positionPreferences;
  num returnRate = 0;
  num monthProfitAmount = 0;
  num weekDayFollowNumRate = 0;

  //v2
  FollowTraderScore? copyTrader;
  FollowTraderScore? copyTraderAvgCount;
  num? traderScore;
  num? grade;

  num? rankingRatio;
  num? orderNumber;
  num? winNumber;
  num? lossesNumber;
  num? orderFrequency;
  num? dayCount;
  num? lastTradeTime;
  num? shareProfitRate;
  List? monthProfitRateList;
  num? mTime;

  num? monthProfitRate;
  List<PositionPreferencesModel>? positionPreferencesV2;

  FollowkolTraderDetailModel(
      {this.winRate = 0,
      this.traderProfitDay = 0,
      this.traderLossesDay = 0,
      this.traderTotalMargin = 0,
      this.avgOrderAmount = 0,
      this.traderTotalAmount = 0,
      this.tokenEquity = 0,
      this.singleMinAmount = 0,
      this.singleMaxAmount = 0,
      this.totalNumber = 0,
      this.weekDayFollowNum = 0,
      this.currentNumber = 0,
      this.monthProfit,
      this.positionPreferences,
      this.returnRate = 0,
      this.followProfit = 0,
      this.monthProfitAmount = 0,
      this.weekDayFollowNumRate = 0,
      this.copyTrader,
      this.copyTraderAvgCount,
      this.traderScore,
      this.grade,
      this.rankingRatio,
      this.orderNumber,
      this.winNumber,
      this.lossesNumber,
      this.orderFrequency,
      this.dayCount,
      this.lastTradeTime,
      this.shareProfitRate,
      this.monthProfitRateList,
      this.monthProfitRate});

  FollowkolTraderDetailModel.fromJson(Map<String, dynamic> json) {
    winRate = json['winRate'] ?? 0;
    traderProfitDay = json['traderProfitDay'] ?? 0;
    traderLossesDay = json['traderLossesDay'] ?? 0;
    traderTotalMargin = json['traderTotalMargin'] ?? 0;
    avgOrderAmount = json['avgOrderAmount'] ?? 0;
    traderTotalAmount = json['traderTotalAmount'] ?? 0;
    tokenEquity = json['tokenEquity'] ?? 0;
    singleMinAmount = json['singleMinAmount'] ?? 0;
    singleMaxAmount = json['singleMaxAmount'] ?? 0;
    totalNumber = json['totalNumber'] ?? 0;
    weekDayFollowNum = json['weekDayFollowNum'] ?? 0;
    currentNumber = json['currentNumber'] ?? 0;
    monthProfit = json['monthProfit'];
    positionPreferences = json['positionPreferences'];
    returnRate = json['returnRate'] ?? 0;
    followProfit = json['followProfit'] ?? 0;
    monthProfitAmount = json['monthProfitAmount'] ?? 0;
    weekDayFollowNumRate = json['weekDayFollowNumRate'] ?? 0;

    copyTrader = json['copyTrader'] != null ? FollowTraderScore.fromJson(json['copyTrader']) : null;
    copyTraderAvgCount = json['copyTraderAvgCount'] != null ? FollowTraderScore.fromJson(json['copyTraderAvgCount']) : null;
    traderScore = json['traderScore'];
    grade = json['grade'];

    rankingRatio = json['rankingRatio'];
    orderNumber = json['orderNumber'];
    winNumber = json['winNumber'];
    lossesNumber = json['lossesNumber'];
    orderFrequency = json['orderFrequency'];

    dayCount = json['dayCount'];
    lastTradeTime = json['lastTradeTime'];
    mTime = json['mTime'];

    shareProfitRate = json['shareProfitRate'];
    monthProfitRateList = json['monthProfitRateList'];
    monthProfitRate = json['monthProfitRate'];
    if (json['positionPreferencesV2'] != null) {
      positionPreferencesV2 = <PositionPreferencesModel>[];
      json['positionPreferencesV2'].forEach((v) {
        positionPreferencesV2!.add(PositionPreferencesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['winRate'] = winRate;
    data['traderProfitDay'] = traderProfitDay;
    data['traderLossesDay'] = traderLossesDay;
    data['traderTotalMargin'] = traderTotalMargin;
    data['avgOrderAmount'] = avgOrderAmount;
    data['traderTotalAmount'] = traderTotalAmount;
    data['tokenEquity'] = tokenEquity;
    data['singleMinAmount'] = singleMinAmount;
    data['singleMaxAmount'] = singleMaxAmount;
    data['totalNumber'] = totalNumber;
    data['weekDayFollowNum'] = weekDayFollowNum;
    data['currentNumber'] = currentNumber;
    data['monthProfit'] = monthProfit;
    data['positionPreferences'] = positionPreferences;
    data['returnRate'] = returnRate;
    data['followProfit'] = followProfit;
    data['monthProfitAmount'] = monthProfitAmount;
    data['weekDayFollowNumRate'] = weekDayFollowNumRate;
    if (copyTrader != null) {
      data['copyTrader'] = copyTrader!.toJson();
    }
    if (copyTraderAvgCount != null) {
      data['copyTraderAvgCount'] = copyTraderAvgCount!.toJson();
    }
    data['traderScore'] = traderScore;
    data['grade'] = grade;

    data['rankingRatio'] = rankingRatio;
    data['orderNumber'] = orderNumber;
    data['winNumber'] = winNumber;
    data['lossesNumber'] = lossesNumber;
    data['orderFrequency'] = orderFrequency;

    data['dayCount'] = dayCount;
    data['lastTradeTime'] = lastTradeTime;

    data['shareProfitRate'] = shareProfitRate;
    data['monthProfitRateList'] = monthProfitRateList;
    data['monthProfitRate'] = monthProfitRate;
    data['mTime'] = mTime;

    return data;
  }

  String get rateStr => getmRateConvert(winRate, havePrefix: false);
  String get traderTotalMarginStr => getmConvert(traderTotalMargin);
  String get avgOrderAmountStr => getmConvert(avgOrderAmount);
  String get traderTotalAmountStr => getmConvert(traderTotalAmount);
  String get currentNumberStr => getmConvert(currentNumber, isDefault: false);
  String get totalNumberStr => getmConvert(totalNumber, isDefault: false);
  String get weekDayFollowNumStr => (weekDayFollowNum > 0 ? '+' : '') + getmConvert(weekDayFollowNum, isDefault: false);
  String get followProfitStr => getmConvert(followProfit);

  String get todayEarn => getmRateConvert(monthProfitRate);
  // Color get todayEarnColor => getmColor(double.parse(todayEarn));
  Color get todayEarnColor => AppColor.upColor;

  String get weekDayFollowNumRateStr => '$weekDayFollowNumRate%';
  Color get weekDayFollowNumRateColor => getmColor(weekDayFollowNumRate);
  String get weekDayFollowStr => '$weekDayFollowNumStr($weekDayFollowNumRateStr)';

  //v2
  double get traderScoreStart => (traderScore ?? 0) / 20;
  String get traderScoreStr => '${LocaleKeys.follow306.tr} ${(traderScore ?? 0).toStringAsFixed(1)}';
  String get rankingRatioStr => ' ${getmRateConvert((rankingRatio ?? 0) * 100, havePrefix: false)} ';
  String get shareProfitRateStr => getmRateConvert(shareProfitRate, havePrefix: false);
  //3
  String get orderNumberStr => getmConvert(orderNumber, pricePrecision: 0);
  String get winNumberStr => getmConvert(winNumber, pricePrecision: 0);
  String get lossesNumberStr => getmConvert(lossesNumber, pricePrecision: 0);
  String get orderFrequencyStr => getmConvert(orderFrequency, pricePrecision: 0);
  String get dayCountStr => getmConvert(dayCount, pricePrecision: 0);
  String get lastTradeTimeStr => lastTradeTime == null ? '--' : MyTimeUtil.timestampToStr(lastTradeTime!.toInt());
  String get lastUpdateTimeStr => mTime == null ? '' : MyTimeUtil.timestampToStr(mTime!.toInt());
}

class FollowTraderScore with PagingModel {
  num? yieldRate;
  num? copyWinRate;
  num? transactionCount;
  num? wealth;
  num? reputation;
  num? copyTotal;

  FollowTraderScore({this.yieldRate, this.copyWinRate, this.transactionCount, this.wealth, this.reputation, this.copyTotal});

  FollowTraderScore.fromJson(Map<String, dynamic> json) {
    yieldRate = json['yieldRate'];
    copyWinRate = json['copyWinRate'];
    transactionCount = json['transactionCount'];
    wealth = json['wealth'];
    reputation = json['reputation'];
    copyTotal = json['copyTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['yieldRate'] = yieldRate;
    data['copyWinRate'] = copyWinRate;
    data['transactionCount'] = transactionCount;
    data['wealth'] = wealth;
    data['reputation'] = reputation;
    data['copyTotal'] = copyTotal;
    return data;
  }

  String get yieldRateStr => getmConvert(yieldRate, pricePrecision: 1);
  String get copyWinRateStr => getmConvert(copyWinRate, pricePrecision: 1);
  String get transactionCountStr => getmConvert(transactionCount, pricePrecision: 1);
  String get wealthStr => getmConvert(wealth, pricePrecision: 1);
  String get reputationStr => getmConvert(reputation, pricePrecision: 1);
  String get copyTotalStr => getmConvert(copyTotal, pricePrecision: 1);
}

class PositionPreferencesModel {
  String key = '';
  num longValue = 0;
  num bigDecimalValue = 0;
  String percent = '';

  PositionPreferencesModel({this.key = '', this.longValue = 0, this.bigDecimalValue = 0});

  PositionPreferencesModel.fromJson(Map<String, dynamic> json) {
    key = json['key'] ?? '';
    longValue = json['longValue'] ?? 0;
    bigDecimalValue = json['bigDecimalValue'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['key'] = key;
    data['longValue'] = longValue;
    data['bigDecimalValue'] = bigDecimalValue;
    return data;
  }

  String get amountStr => '$longValue${LocaleKeys.follow466.tr}';
}
