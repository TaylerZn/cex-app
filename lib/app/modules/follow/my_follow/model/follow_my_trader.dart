import 'dart:ui';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowMyTraderModel with PagingModel, PagingError {
  num? count;
  List<FollowMyTrader>? list;

  FollowMyTraderModel({this.count, this.list});

  FollowMyTraderModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <FollowMyTrader>[];
      json['list'].forEach((v) {
        list!.add(FollowMyTrader.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowMyTrader with PagingModel {
  num? followAmount;
  num? orderAmount;
  String? kolName;
  num? kolUid;
  num? profitAmount;
  String? coin;
  num? status;
  num? followTime;
  String? kolImg;
  num? followProfit;
  num? todayProfit;
  num? currentAmount;
  num? flotProfit;
  num rate = 0;

  num monthProfitRate = 0;
  num winRate = 0;
  String? label;
  String? labelDesc;

//01
  num? maxFollowAmount;
  num? avgHoldAmount;
  num? followType;
  num? singleTotal;
  num? followCount;
  num? isDisableUsers;
  num? isBlacklistedUsers;
  num? copyMode;

  bool isText = true;
  int? levelType;

//02
  num? followStatus;
  FollowMyTrader(
      {this.followAmount,
      this.orderAmount,
      this.kolName,
      this.kolUid,
      this.profitAmount,
      this.coin,
      this.status,
      this.followTime,
      this.kolImg,
      this.followProfit,
      this.todayProfit,
      this.currentAmount,
      this.flotProfit,
      this.rate = 0,
      this.maxFollowAmount,
      this.avgHoldAmount,
      this.followType,
      this.singleTotal,
      this.followCount,
      this.copyMode,
      this.levelType});

  FollowMyTrader.fromJson(Map<String, dynamic> json) {
    followAmount = json['follow_amount'];
    orderAmount = json['order_amount'];
    kolName = json['kol_name'];
    kolUid = json['kol_uid'];
    profitAmount = json['profit_amount'];
    coin = json['coin'];
    status = json['status'];
    followTime = json['followTime'];
    kolImg = json['kolImg'];
    followProfit = json['followProfit'];
    todayProfit = json['todayProfit'];
    currentAmount = json['currentAmount'];
    flotProfit = json['flotProfit'];
    rate = json['rate'] ?? 0;
    monthProfitRate = json['monthProfitRate'] ?? 0;
    winRate = json['winRate'] ?? 0;
    label = json['label'];
    labelDesc = json['labelDesc'];
    maxFollowAmount = json['maxFollowAmount'];
    avgHoldAmount = json['avgHoldAmount'];
    followType = json['followType'];
    singleTotal = json['singleTotal'];
    followCount = json['followCount'];
    isDisableUsers = json['isDisableUsers'];
    isBlacklistedUsers = json['isBlacklistedUsers'];
    copyMode = json['copyMode'];
    followStatus = json['followStatus'];
    levelType = json['levelType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['follow_amount'] = followAmount;
    data['order_amount'] = orderAmount;
    data['kol_name'] = kolName;
    data['kol_uid'] = kolUid;
    data['profit_amount'] = profitAmount;
    data['coin'] = coin;
    data['status'] = status;
    data['followTime'] = followTime;
    data['kolImg'] = kolImg;
    data['followProfit'] = followProfit;
    data['todayProfit'] = todayProfit;
    data['currentAmount'] = currentAmount;
    data['flotProfit'] = flotProfit;
    data['rate'] = rate;
    data['monthProfitRate'] = monthProfitRate;
    data['winRate'] = winRate;
    data['label'] = label;
    data['labelDesc'] = labelDesc;
    data['maxFollowAmount'] = maxFollowAmount;
    data['avgHoldAmount'] = avgHoldAmount;
    data['followType'] = followType;
    data['singleTotal'] = singleTotal;
    data['followCount'] = followCount;
    data['copyMode'] = copyMode;
    data['followStatus'] = followStatus;
    data['levelType'] = levelType;

    return data;
  }

  String get icon => kolImg != null && kolImg!.isNotEmpty ? kolImg! : "default/avatar_default".pngAssets();
  String get name => kolName ?? '--';
  String get followTimeStr => '${LocaleKeys.follow69.tr}: ${MyTimeUtil.timestampToStr((followTime ?? 0).toInt())}';
  String get followProfitStr => getmConvert(followProfit, isText: isText);
  String get currentAmountStr => getmConvert(currentAmount, isText: isText);
  String get todayProfitStr => getmConvert(todayProfit, isText: isText);
  String get flotProfitStr => getmConvert(flotProfit, isText: isText);
  String get rateStr => getmRateConvert(rate, isText: isText);

  String get winRateStr => '${winRate > 0 ? '+' : ''}$winRate%';
  Color get winRateColor => getmColor(winRate);
  String get monthProfitRateStr => '${monthProfitRate > 0 ? '+' : ''}$monthProfitRate%';
  Color get monthProfitRateColor => getmColor(monthProfitRate);
  String get labelStr => label != null && label!.isNotEmpty ? label! : '';

  String get followHistroyTimeStr => '${LocaleKeys.trade89.tr}: ${MyTimeUtil.timestampToStr((followTime ?? 0).toInt())}';

  String get avgHoldAmountStr => getmConvert(avgHoldAmount, isText: isText);
  String get followCountStr => getmConvert(followCount, isText: isText);

  String get followTypeStr => isText ? (followType == 1 ? LocaleKeys.follow61.tr : LocaleKeys.follow62.tr) : '******';
  String get singleTotalStr => (singleTotal == null || singleTotal == 0) ? '--' : getmConvert(singleTotal, isText: isText);
  String get maxFollowAmountStr => getmConvert(maxFollowAmount, isText: isText);

  bool get isSmart => copyMode == 2 ? true : false;
}
