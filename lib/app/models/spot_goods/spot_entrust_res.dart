
// To parse this JSON data, do
//
//     final spotEntrustRes = spotEntrustResFromJson(jsonString);

import 'dart:convert';

SpotEntrustRes spotEntrustResFromJson(String str) => SpotEntrustRes.fromJson(json.decode(str));

String spotEntrustResToJson(SpotEntrustRes data) => json.encode(data.toJson());

class SpotEntrustRes {
  List<SpotEntrustInfo> orderList;
  int count;

  SpotEntrustRes({
    required this.orderList,
    required this.count,
  });

  factory SpotEntrustRes.fromJson(Map<String, dynamic> json) => SpotEntrustRes(
    orderList: List<SpotEntrustInfo>.from(json["orderList"].map((x) => SpotEntrustInfo.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "orderList": List<dynamic>.from(orderList.map((x) => x.toJson())),
    "count": count,
  };
}

class SpotEntrustInfo {
  String id;
  String side;
  String status;
  String statusText;
  String timeLong;
  String createdAt;
  String price;
  String type;
  String source;
  String volume;
  String totalPrice;
  String remainVolume;
  String dealVolume;
  String dealMoney;
  String avgPrice;
  String baseCoin;
  String countCoin;
  String isCloseCancelOrder;

  SpotEntrustInfo({
    required this.id,
    required this.side,
    required this.status,
    required this.statusText,
    required this.timeLong,
    required this.createdAt,
    required this.price,
    required this.type,
    required this.source,
    required this.volume,
    required this.totalPrice,
    required this.remainVolume,
    required this.dealVolume,
    required this.dealMoney,
    required this.avgPrice,
    required this.baseCoin,
    required this.countCoin,
    required this.isCloseCancelOrder,
  });

  factory SpotEntrustInfo.fromJson(Map<String, dynamic> json) => SpotEntrustInfo(
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
