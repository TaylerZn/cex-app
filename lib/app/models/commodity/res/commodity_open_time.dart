import 'dart:convert';

class CommodityOpenTime {
  List<OpenTimeTradePeriod>? tradePeriods;
  bool? fullTime;
  String? timeZone;

  CommodityOpenTime({
    this.tradePeriods,
    this.fullTime,
    this.timeZone,
  });

  factory CommodityOpenTime.fromRawJson(String str) =>
      CommodityOpenTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommodityOpenTime.fromJson(Map<String, dynamic> json) =>
      CommodityOpenTime(
        tradePeriods: json["tradePeriods"] == null
            ? []
            : List<OpenTimeTradePeriod>.from(json["tradePeriods"]!
                .map((x) => OpenTimeTradePeriod.fromJson(x))),
        fullTime: json["fullTime"],
        timeZone: json["timeZone"],
      );

  Map<String, dynamic> toJson() => {
        "tradePeriods": tradePeriods == null
            ? []
            : List<dynamic>.from(tradePeriods!.map((x) => x.toJson())),
        "fullTime": fullTime,
        "timeZone": timeZone,
      };
}

class OpenTimeTradePeriod {
  int? dayOfWeek;
  String? state;
  int? startTime;
  int? endTime;
  int? startTime2;
  int? endTime2;
  String? value;

  OpenTimeTradePeriod({
    this.dayOfWeek,
    this.state,
    this.startTime,
    this.endTime,
    this.startTime2,
    this.endTime2,
    this.value,
  });

  factory OpenTimeTradePeriod.fromRawJson(String str) =>
      OpenTimeTradePeriod.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OpenTimeTradePeriod.fromJson(Map<String, dynamic> json) =>
      OpenTimeTradePeriod(
        dayOfWeek: json["dayOfWeek"],
        state: json["state"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        startTime2: json["startTime2"],
        endTime2: json["endTime2"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "dayOfWeek": dayOfWeek,
        "state": state,
        "startTime": startTime,
        "endTime": endTime,
        "startTime2": startTime2,
        "endTime2": endTime2,
        "value": value,
      };
}
