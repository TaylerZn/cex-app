
class TradeTimeRes {
  List<TradePeriodInfo> tradePeriodList;

  TradeTimeRes({
    required this.tradePeriodList,
  });

  factory TradeTimeRes.fromJson(Map<String, dynamic> json) => TradeTimeRes(
    tradePeriodList: List<TradePeriodInfo>.from(json["tradePeriodList"].map((x) => TradePeriodInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tradePeriodList": List<dynamic>.from(tradePeriodList.map((x) => x.toJson())),
  };
}

class TradePeriodInfo {
  int day;
  String startTime;
  String endTime;
  bool marketClosed;

  TradePeriodInfo({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.marketClosed,
  });

  bool get isMarketClosed {
    if(marketClosed) {
      return true;
    } else {
      /// 当前时间不在交易时间内 也是闭市
      int currentTime = DateTime.now().microsecondsSinceEpoch ~/ 1000;
      int start = DateTime.parse(startTime).microsecondsSinceEpoch ~/ 1000;
      int end = DateTime.parse(endTime).microsecondsSinceEpoch ~/ 1000;
      if(currentTime < start || currentTime > end) {
        return true;
      } else {
        return false;
      }
    }
  }

  factory TradePeriodInfo.fromJson(Map<String, dynamic> json) => TradePeriodInfo(
    day: json["day"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    marketClosed: json["marketClosed"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "startTime": startTime,
    "endTime": endTime,
    "marketClosed": marketClosed,
  };
}
