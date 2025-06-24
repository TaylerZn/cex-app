
// To parse this JSON data, do
//
//     final commodityOpenStatus = commodityOpenStatusFromJson(jsonString);

import 'dart:convert';

CommodityOpenStatus commodityOpenStatusFromJson(String str) => CommodityOpenStatus.fromJson(json.decode(str));

String commodityOpenStatusToJson(CommodityOpenStatus data) => json.encode(data.toJson());

class CommodityOpenStatus {
  bool? tradeOpen;
  bool? isStop;
  int? nextOpenTimeIntervalMills;

  CommodityOpenStatus({
    this.tradeOpen,
    this.isStop,
    this.nextOpenTimeIntervalMills,
  });

  factory CommodityOpenStatus.fromJson(Map<String, dynamic> json) => CommodityOpenStatus(
    tradeOpen: json["tradeOpen"],
    isStop: json['isStop'],
    nextOpenTimeIntervalMills: json["nextOpenTimeIntervalMills"],
  );

  Map<String, dynamic> toJson() => {
    "tradeOpen": tradeOpen,
    "isStop": isStop,
    "nextOpenTimeIntervalMills": nextOpenTimeIntervalMills,
  };
}
