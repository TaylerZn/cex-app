// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/community/activity.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///筛选项 枚举
enum FollowOrdersNavType {
  explore,
  futures;

  String get value => [LocaleKeys.follow439.tr, LocaleKeys.follow440.tr][index];
}

///筛选项 枚举
enum FollowOrdersType {
  aggregate,
  winRatio,
  yield,
  // revenueVolume,
  // currentNumber,
  other;

  String get value => [
        LocaleKeys.follow241.tr,
        LocaleKeys.follow9.tr,
        LocaleKeys.follow115.tr,
        // LocaleKeys.follow242.tr,
        // LocaleKeys.follow145.tr,
        'other'
      ][index];

  // int get orderType => [0, 3, 2, 1, 4, 5][index]; //1,收益额排序，2收益率排序，3胜率排序，4跟单人数
  int get orderType => [0, 3, 2, 5][index]; //1,收益额排序，2收益率排序，3胜率排序，4跟单人数
}

///筛选项 枚举
enum FollowActionType {
  shield,
  prohibit;
}

///筛选项 枚举
enum FollowFutureType {
  all,
  market,
  diamond,
  crypto,
  stocks,
  marketIndex,
  forex,
  bulk,
  eTFs;

  // String get value => ['全部', '超过大盘', '原石待雕', '加密货币', '股票', '指数', '外汇', '大宗', 'ETF'][index];
  String get value => [
        LocaleKeys.public35.tr,
        LocaleKeys.follow455.tr,
        LocaleKeys.follow456.tr,
        LocaleKeys.markets32.tr,
        LocaleKeys.markets11.tr,
        LocaleKeys.markets12.tr,
        LocaleKeys.markets13.tr,
        LocaleKeys.markets14.tr,
        'ETF',
        LocaleKeys.markets15.tr,
      ][index];
  int get orderType => [-1, 7, 6, 0, 1, 4, 2, 3, 5][index]; //1,收益额排序，2收益率排序，3胜率排序，4跟单人数
}

///筛选项 枚举
enum FollowFutureFilterType {
  earnRate,
  success,
  followDay,
  score,
  maxCustomer,
  trader;

  String get value => [
        LocaleKeys.follow115.tr,
        LocaleKeys.follow9.tr,
        LocaleKeys.follow326.tr,
        LocaleKeys.follow306.tr,
        LocaleKeys.follow449.tr,
        LocaleKeys.follow315.tr
      ][index];

//0 综合评分 1收益率 2胜率 3带单天数 4最多关注着 5交易次
  int get orderType => [1, 2, 3, 0, 4, 5][index];
}

class FollowTopModel {
  FollowKolTraderInfoModel kol = FollowKolTraderInfoModel();
  FollowGeneralInfoModel follow = FollowGeneralInfoModel();
  var cmsModel = CmsAdvertModel().obs;
}

class FollowKolTraderInfoModel with PagingModel {
  num waitProfit = 0;
  num currentFollowCount = 0;
  num maxFollowCount = 0;
  num i90TraderTotalAmount = 0;
  num rate = 0;
  num settingRange = 0;
  num sumShareProfit = 0;
  num latestShareProfit = 0;
  num totalEarnings = 0;
  num followAmount = 0;
  int uid = 0;
  num followTotal = 0;
  num followBalance = 0;
  num todaypnl = 0;
  String symbol = "";

  //v2
  num agentProfitRatio = 0;
  num rateLimit = 0;
  num monthProfitRate = 0;
  num winRate = 0;

  FollowKolTraderInfoModel(
      {this.waitProfit = 0,
      this.currentFollowCount = 0,
      this.maxFollowCount = 0,
      this.i90TraderTotalAmount = 0,
      this.rate = 0,
      this.settingRange = 0,
      this.sumShareProfit = 0,
      this.latestShareProfit = 0,
      this.totalEarnings = 0,
      this.followAmount = 0,
      this.followTotal = 0,
      this.followBalance = 0,
      this.todaypnl = 0,
      this.symbol = "",
      this.monthProfitRate = 0,
      this.winRate = 0});

  FollowKolTraderInfoModel.fromJson(Map<String, dynamic> json) {
    waitProfit = json['waitProfit'] ?? 0;
    currentFollowCount = json['currentFollowCount'] ?? 0;
    maxFollowCount = json['maxFollowCount'] ?? 0;
    i90TraderTotalAmount = json['90TraderTotalAmount'] ?? 0;
    rate = json['rate'] ?? 0;
    settingRange = json['settingRange'] ?? 0;
    sumShareProfit = json['sumShareProfit'] ?? 0;
    latestShareProfit = json['latestShareProfit'] ?? 0;
    totalEarnings = json['totalEarnings'] ?? 0;
    followAmount = json['followAmount'] ?? 0;
    followTotal = json['followTotal'] ?? 0;
    followBalance = json['followBalance'] ?? 0;
    todaypnl = json['today_pnl'] ?? 0;
    symbol = json['symbol'] ?? "";

    agentProfitRatio = json['agentProfitRatio'] ?? 0;
    rateLimit = json['rateLimit'] ?? 0;
    monthProfitRate = json['monthProfitRate'] ?? 0;
    winRate = json['winRate'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['waitProfit'] = waitProfit;
    data['currentFollowCount'] = currentFollowCount;
    data['maxFollowCount'] = maxFollowCount;
    data['90TraderTotalAmount'] = i90TraderTotalAmount;
    data['rate'] = rate;
    data['settingRange'] = settingRange;
    data['sumShareProfit'] = sumShareProfit;
    data['latestShareProfit'] = latestShareProfit;
    data['totalEarnings'] = totalEarnings;
    data['followAmount'] = followAmount;
    data['followTotal'] = followTotal;
    data['followBalance'] = followBalance;
    data['today_pnl'] = todaypnl;
    data['symbol'] = symbol;
    return data;
  }

  String get waitProfitStr => getmConvert(waitProfit);
  String get i90TraderTotalAmountStr => getmConvert(i90TraderTotalAmount);
  String get currentFollowCountStr => currentFollowCount.toString();
  String get maxFollowCountStr => '/${maxFollowCount.toString()}';
  String get rateStr => '$rate%';

  String get totalEarningsStr => getmConvert(totalEarnings);
  Color get totalEarningsColor => getmColor(totalEarnings);

  String get sumShareProfitStr => getmConvert(sumShareProfit);
  Color get sumShareProfitColor => getmColor(sumShareProfit);

  String get latestShareProfitStr => getmConvert(latestShareProfit);

  String get followAmountStr => getmConvert(followAmount);
}

class FollowGeneralInfoModel with PagingModel {
  num incomeRate = 0;
  num followAmount = 0;
  num followSubAmount = 0;
  num incomeAmount = 0;
  String? symbol;
  num followTotal = 0;
  num followBalance = 0;
  num todayPnl = 0;
  num yesterdayPnl = 0;
  num pnlRate = 0;
  num userRating = 0;
  num riskRating = 0;
  num followGold = 0;
  num unPnl = 0;

  FollowGeneralInfoModel({
    this.incomeRate = 0,
    this.followAmount = 0,
    this.incomeAmount = 0,
    this.symbol,
    this.followTotal = 0,
    this.followBalance = 0,
    this.todayPnl = 0,
    this.yesterdayPnl = 0,
    this.followSubAmount = 0,
    this.pnlRate = 0,
    this.userRating = 0,
    this.riskRating = 0,
    this.followGold = 0,
    this.unPnl = 0,
  });

  FollowGeneralInfoModel.fromJson(Map<String, dynamic> json) {
    incomeRate = json['income_rate'] ?? 0;
    followAmount = json['follow_amount'] ?? 0;
    followSubAmount = json['follow_sub_amount'] ?? 0;
    incomeAmount = json['income_amount'] ?? 0;
    symbol = json['symbol'];
    followTotal = json['followTotal'] ?? 0;
    followBalance = json['followBalance'] ?? 0;
    todayPnl = json['today_pnl'] ?? 0;
    yesterdayPnl = json['yesterday_pnl'] ?? 0;
    pnlRate = json['pnlRate'] ?? 0;
    userRating = json['userRating'] ?? 0;
    riskRating = json['riskRating'] ?? 0;
    followGold = json['followGold'] ?? 0;
    unPnl = json['unPnl'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['income_rate'] = incomeRate;
    data['follow_amount'] = followAmount;
    data['follow_sub_amount'] = followSubAmount;
    data['income_amount'] = incomeAmount;
    data['symbol'] = symbol;
    data['followTotal'] = followTotal;
    data['followBalance'] = followBalance;
    data['today_pnl'] = todayPnl;
    data['yesterday_pnl'] = yesterdayPnl;
    data['pnlRate'] = pnlRate;
    data['userRating'] = userRating;
    data['riskRating'] = riskRating;
    data['followGold'] = followGold;
    data['unPnl'] = unPnl;

    return data;
  }

  String get followAmountStr => getmConvert(followAmount);

  String get followfollowSubAmountStr => getmConvert(followSubAmount);

  String get incomeAmountStr {
    return incomeAmount >= 0 ? '+${getmConvert(incomeAmount)}' : getmConvert(incomeAmount);
  }

  String get incomeRateStr => getmRateConvert(incomeRate);

  Color get strColor => getmColor(incomeAmount);
}

class FollowKol {
  int? count;

  FollowKol({this.count});

  FollowKol.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    return data;
  }

  bool get isKol => count != null && count! > 0;
}

class FollowComment with PagingModel, PagingError {
  RatingResult? ratingResult;
  List<FollowCommentModel>? records;

  FollowComment({this.ratingResult});

  FollowComment.fromJson(Map<String, dynamic> json) {
    if (json['page'] != null && json['page']['records'] != null) {
      records = <FollowCommentModel>[];
      List array = json['page']['records'];
      array.forEach((v) {
        records!.add(FollowCommentModel.fromJson(v));
      });
    }

    ratingResult = json['ratingResult'] != null ? RatingResult.fromJson(json['ratingResult']) : null;
  }
}

class RatingResult {
  num? averageScore;
  num? topRate;
  num? score1Rate;
  num? score2Rate;
  num? score3Rate;
  num? score4Rate;
  num? score5Rate;

  RatingResult({this.score1Rate, this.score2Rate, this.score3Rate, this.score4Rate, this.score5Rate, this.averageScore});

  RatingResult.fromJson(Map<String, dynamic> json) {
    averageScore = json['averageScore'];
    score1Rate = json['score1Rate'] ?? 0;
    score2Rate = json['score2Rate'] ?? 0;
    score3Rate = json['score3Rate'] ?? 0;
    score4Rate = json['score4Rate'] ?? 0;
    score5Rate = json['score5Rate'] ?? 0;
    topRate = json['topRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['score1Percent'] = score1Rate;
    data['score2Percent'] = score2Rate;
    data['score3Percent'] = score3Rate;
    data['score4Percent'] = score4Rate;
    data['score5Percent'] = score5Rate;
    data['averageScore'] = averageScore;
    return data;
  }

  double get score1RateStr => double.parse(score1Rate!.toStringAsFixed(2));
  double get score2RateStr => double.parse(score2Rate!.toStringAsFixed(2));
  double get score3RateStr => double.parse(score3Rate!.toStringAsFixed(2));
  double get score4RateStr => double.parse(score4Rate!.toStringAsFixed(2));
  double get score5RateStr => double.parse(score5Rate!.toStringAsFixed(2));
}

class FollowCommentModel {
  num? id;
  num? reviewer;
  num? reviewedTrader;
  num rating = 0;
  num sortValue = 0;
  String? comment;
  dynamic ctime;
  num? mtime;
  String? name;
  String? img;

  bool haveExpansion = false;
  var rxComentStr = ''.obs;
  FollowCommentModel(
      {this.id, this.reviewer, this.reviewedTrader, this.rating = 0, this.sortValue = 0, this.comment, this.ctime, this.mtime});

  FollowCommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewer = json['reviewer'];
    reviewedTrader = json['reviewedTrader'];
    rating = json['rating'] ?? 0;
    sortValue = json['sortValue'] ?? 0;
    comment = json['comment'];
    ctime = json['ctime'];
    // mtime = json['mtime'];
    name = json['name'];
    img = json['img'];
    rxComentStr.value = commentStr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['reviewer'] = reviewer;
    data['reviewedTrader'] = reviewedTrader;
    data['rating'] = rating;
    data['sortValue'] = sortValue;
    data['comment'] = comment;
    data['ctime'] = ctime;
    data['mtime'] = mtime;
    data['name'] = name;
    data['img'] = img;
    return data;
  }

  String get icon => img != null && img!.isNotEmpty ? img! : "default/avatar_default".pngAssets();

  String get userName => name ?? '--';

  String get commentStr => comment?.isNotEmpty == true ? comment! : '${LocaleKeys.follow515.tr}...';

  String get timeStr {
    if (ctime == null) {
      return '';
    } else if (ctime is num) {
      return '${MyTimeUtil.getYMDime(MyTimeUtil.timestampToDate(ctime!.toInt()))} ';
    } else {
      return ctime!.split('T').first;
    }
  }

  // '${MyTimeUtil.getYMDime(MyTimeUtil.timestampToDate(ctime!.toInt()))} ';
}

class FollowKolRateModel {
  num? rato;

  FollowKolRateModel({this.rato});

  FollowKolRateModel.fromJson(Map<String, dynamic> json) {
    rato = json['rato'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rato'] = rato;
    return data;
  }
}

class FollowTraderAccountModel with PagingModel {
  num? amount;

  FollowTraderAccountModel({this.amount});

  FollowTraderAccountModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    return data;
  }

  String? get amountStr => amount != null ? '${getmConvert(amount!)} USDT' : null;
}

class FollowKolSettingModel {
  num? copySetting;
  num? hisSetting;
  num? followSetting;

  FollowKolSettingModel({this.copySetting});

  FollowKolSettingModel.fromJson(Map<String, dynamic> json) {
    copySetting = json['copySetting'];
    hisSetting = json['hisSetting'];
    followSetting = json['followSetting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['copySetting'] = copySetting;
    data['hisSetting'] = hisSetting;
    data['followSetting'] = followSetting;

    return data;
  }
}

class FollowkolIsTraceModel {
  num? status;

  FollowkolIsTraceModel({this.status});

  FollowkolIsTraceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
