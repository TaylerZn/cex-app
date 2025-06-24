import 'dart:convert';

class FollowTradePreferenceModel {
  List<FlowTradeItem>? list;

  FollowTradePreferenceModel({
    this.list,
  });

  factory FollowTradePreferenceModel.fromRawJson(String str) => FollowTradePreferenceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowTradePreferenceModel.fromJson(Map<String, dynamic> json) => FollowTradePreferenceModel(
    list: json["list"] == null ? [] : List<FlowTradeItem>.from(json["list"]!.map((x) => FlowTradeItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class FlowTradeItem {
  String? userName;
  String? coinSymbol;
  int? winRateWeek;
  double? profitRate;
  double? profitAmount;
  int? singleMinAmount;
  int? singleMaxAmount;
  int? orderNumber;
  int? uid;
  int? sort;
  int? totalNumber;
  int? maxNumber;
  int? currentNumber;
  int? switchFollowerNumber;
  int? followStatus;
  int? lastTradeTime;
  String? label;
  List<double>? profitRateList;
  List<String>? symbolList;
  int? copyAmount;
  String? imgUrl;
  int? winRate;
  int? monthProfitRate;
  String? monthProfitAmount;
  String? monthDeficitAmount;
  int? copySetting;
  int? copySwitch;
  int? applyFollowStatus;
  int? isBlacklistedUsers;
  int? isDisableUsers;
  int? isFollowStart;
  int? topicId;
  String? topicTitle;
  int? copyMode;
  String? topicType;
  String? topicNo;
  String? flagIcon;
  List<String>? tradingStyleLabel;
  List<String>? tradingPairType;
  String? userRating;
  String? riskRating;
  String? organizationIcon;

  FlowTradeItem({
    this.userName,
    this.coinSymbol,
    this.winRateWeek,
    this.profitRate,
    this.profitAmount,
    this.singleMinAmount,
    this.singleMaxAmount,
    this.orderNumber,
    this.uid,
    this.sort,
    this.totalNumber,
    this.maxNumber,
    this.currentNumber,
    this.switchFollowerNumber,
    this.followStatus,
    this.lastTradeTime,
    this.label,
    this.profitRateList,
    this.symbolList,
    this.copyAmount,
    this.imgUrl,
    this.winRate,
    this.monthProfitRate,
    this.monthProfitAmount,
    this.monthDeficitAmount,
    this.copySetting,
    this.copySwitch,
    this.applyFollowStatus,
    this.isBlacklistedUsers,
    this.isDisableUsers,
    this.isFollowStart,
    this.topicId,
    this.topicTitle,
    this.copyMode,
    this.topicType,
    this.topicNo,
    this.flagIcon,
    this.tradingStyleLabel,
    this.tradingPairType,
    this.userRating,
    this.riskRating,
    this.organizationIcon,
  });

  factory FlowTradeItem.fromRawJson(String str) => FlowTradeItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlowTradeItem.fromJson(Map<String, dynamic> json) => FlowTradeItem(
    userName: json["user_name"],
    coinSymbol: json["coin_symbol"],
    winRateWeek: json["win_rate_week"],
    profitRate: json["profit_rate"]?.toDouble(),
    profitAmount: json["profit_amount"]?.toDouble(),
    singleMinAmount: json["single_min_amount"],
    singleMaxAmount: json["single_max_amount"],
    orderNumber: json["order_number"],
    uid: json["uid"],
    sort: json["sort"],
    totalNumber: json["total_number"],
    maxNumber: json["maxNumber"],
    currentNumber: json["current_number"],
    switchFollowerNumber: json["switchFollowerNumber"],
    followStatus: json["follow_status"],
    lastTradeTime: json["last_trade_time"],
    label: json["label"],
    profitRateList: json["profitRateList"] == null ? [] : List<double>.from(json["profitRateList"]!.map((x) => x?.toDouble())),
    symbolList: json["symbolList"] == null ? [] : List<String>.from(json["symbolList"]!.map((x) => x)),
    copyAmount: json["copyAmount"],
    imgUrl: json["imgUrl"],
    winRate: json["winRate"],
    monthProfitRate: json["monthProfitRate"],
    monthProfitAmount: json["monthProfitAmount"],
    monthDeficitAmount: json["monthDeficitAmount"],
    copySetting: json["copySetting"],
    copySwitch: json["copySwitch"],
    applyFollowStatus: json["applyFollowStatus"],
    isBlacklistedUsers: json["isBlacklistedUsers"],
    isDisableUsers: json["isDisableUsers"],
    isFollowStart: json["isFollowStart"],
    topicId: json["topicId"],
    topicTitle: json["topicTitle"],
    copyMode: json["copyMode"],
    topicType: json["topicType"],
    topicNo: json["topicNo"],
    flagIcon: json["flagIcon"],
    tradingStyleLabel: json["tradingStyleLabel"] == null ? [] : List<String>.from(json["tradingStyleLabel"]!.map((x) => x)),
    tradingPairType: json["tradingPairType"] == null ? [] : List<String>.from(json["tradingPairType"]!.map((x) => x)),
    userRating: json["userRating"],
    riskRating: json["riskRating"],
    organizationIcon: json["organizationIcon"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "coin_symbol": coinSymbol,
    "win_rate_week": winRateWeek,
    "profit_rate": profitRate,
    "profit_amount": profitAmount,
    "single_min_amount": singleMinAmount,
    "single_max_amount": singleMaxAmount,
    "order_number": orderNumber,
    "uid": uid,
    "sort": sort,
    "total_number": totalNumber,
    "maxNumber": maxNumber,
    "current_number": currentNumber,
    "switchFollowerNumber": switchFollowerNumber,
    "follow_status": followStatus,
    "last_trade_time": lastTradeTime,
    "label": label,
    "profitRateList": profitRateList == null ? [] : List<dynamic>.from(profitRateList!.map((x) => x)),
    "symbolList": symbolList == null ? [] : List<dynamic>.from(symbolList!.map((x) => x)),
    "copyAmount": copyAmount,
    "imgUrl": imgUrl,
    "winRate": winRate,
    "monthProfitRate": monthProfitRate,
    "monthProfitAmount": monthProfitAmount,
    "monthDeficitAmount": monthDeficitAmount,
    "copySetting": copySetting,
    "copySwitch": copySwitch,
    "applyFollowStatus": applyFollowStatus,
    "isBlacklistedUsers": isBlacklistedUsers,
    "isDisableUsers": isDisableUsers,
    "isFollowStart": isFollowStart,
    "topicId": topicId,
    "topicTitle": topicTitle,
    "copyMode": copyMode,
    "topicType": topicType,
    "topicNo": topicNo,
    "flagIcon": flagIcon,
    "tradingStyleLabel": tradingStyleLabel == null ? [] : List<dynamic>.from(tradingStyleLabel!.map((x) => x)),
    "tradingPairType": tradingPairType == null ? [] : List<dynamic>.from(tradingPairType!.map((x) => x)),
    "userRating": userRating,
    "riskRating": riskRating,
    "organizationIcon": organizationIcon,
  };
}
