// To parse this JSON data, do
//
//     final assetsSpotRecord = assetsSpotRecordFromJson(jsonString);

import 'dart:convert';

AssetsSpotRecord assetsSpotRecordFromJson(String str) =>
    AssetsSpotRecord.fromJson(json.decode(str));

String assetsSpotRecordToJson(AssetsSpotRecord data) =>
    json.encode(data.toJson());

class AssetsSpotRecord {
  List<AssetsSpotRecordItem> orderList;

  AssetsSpotRecord({
    required this.orderList,
  });

  factory AssetsSpotRecord.fromJson(Map<String, dynamic> json) =>
      AssetsSpotRecord(
        orderList: List<AssetsSpotRecordItem>.from(
            json["orderList"].map((x) => AssetsSpotRecordItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderList": List<dynamic>.from(orderList.map((x) => x.toJson())),
      };
}

class AssetsSpotRecordItem {
  dynamic id;
  dynamic side;
  dynamic status;
  dynamic statusText;
  dynamic timeLong;
  dynamic createdAt;
  dynamic price;
  dynamic type;
  dynamic source;
  dynamic volume;
  dynamic totalPrice;
  dynamic remainVolume;
  dynamic dealVolume;
  dynamic dealMoney;
  dynamic avgPrice;
  dynamic baseCoin;
  dynamic countCoin;
  dynamic isCloseCancelOrder;

  AssetsSpotRecordItem({
    this.id,
    this.side,
    this.status,
    this.statusText,
    this.timeLong,
    this.createdAt,
    this.price,
    this.type,
    this.source,
    this.volume,
    this.totalPrice,
    this.remainVolume,
    this.dealVolume,
    this.dealMoney,
    this.avgPrice,
    this.baseCoin,
    this.countCoin,
    this.isCloseCancelOrder,
  });

  factory AssetsSpotRecordItem.fromRawJson(String str) =>
      AssetsSpotRecordItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetsSpotRecordItem.fromJson(Map<String, dynamic> json) =>
      AssetsSpotRecordItem(
        id: json["id"],
        side: json["side"],
        status: json["status"],
        statusText: json["status_text"],
        timeLong: json["time_long"],
        createdAt: json["created_at"],
        price: json["price"],
        type: json["type"],
        source: json["source"],
        volume: json["volume"],
        totalPrice: json["total_price"],
        remainVolume: json["remain_volume"],
        dealVolume: json["deal_volume"],
        dealMoney: json["deal_money"],
        avgPrice: json["avg_price"],
        baseCoin: json["baseCoin"],
        countCoin: json["countCoin"],
        isCloseCancelOrder: json["isCloseCancelOrder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "side": side,
        "status": status,
        "status_text": statusText,
        "time_long": timeLong,
        "created_at": createdAt,
        "price": price,
        "type": type,
        "source": source,
        "volume": volume,
        "total_price": totalPrice,
        "remain_volume": remainVolume,
        "deal_volume": dealVolume,
        "deal_money": dealMoney,
        "avg_price": avgPrice,
        "baseCoin": baseCoin,
        "countCoin": countCoin,
        "isCloseCancelOrder": isCloseCancelOrder,
      };
}
