
// To parse this JSON data, do
//
//     final spotTradeRes = spotTradeResFromJson(jsonString);

import 'dart:convert';

import '../assets/assets_spot_trade_history.dart';

SpotTradeRes spotTradeResFromJson(String str) => SpotTradeRes.fromJson(json.decode(str));

String spotTradeResToJson(SpotTradeRes data) => json.encode(data.toJson());

class SpotTradeRes {
  List<SpotTradeInfo> orderList;
  int count;

  SpotTradeRes({
    required this.orderList,
    required this.count,
  });

  factory SpotTradeRes.fromJson(Map<String, dynamic> json) => SpotTradeRes(
    orderList: List<SpotTradeInfo>.from(json["orderList"].map((x) => SpotTradeInfo.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "orderList": List<dynamic>.from(orderList.map((x) => x.toJson())),
    "count": count,
  };
}

class SpotTradeInfo {
  num price;
  num volume;
  String trendSide;
  String quoteCoin;
  String baseCoin;
  num? buyFee;
  num? sellFee;
  String? buyFeeCoin;
  String? sellFeeCoin;
  String dealPrice;
  String usdtTotal;
  String fee;
  String feeCoin;
  String role;
  DateTime ctimeFormat;
  int ctime;

  SpotTradeInfo({
    required this.price,
    required this.volume,
    required this.trendSide,
    required this.quoteCoin,
    required this.baseCoin,
    required this.buyFee,
    required this.sellFee,
    required this.buyFeeCoin,
    required this.sellFeeCoin,
    required this.dealPrice,
    required this.usdtTotal,
    required this.fee,
    required this.feeCoin,
    required this.role,
    required this.ctimeFormat,
    required this.ctime,
  });

  factory SpotTradeInfo.fromJson(Map<String, dynamic> json) => SpotTradeInfo(
    price: json["price"],
    volume: json["volume"],
    trendSide: json["trendSide"],
    quoteCoin: json["quoteCoin"],
    baseCoin: json["baseCoin"],
    buyFee: json["buyFee"],
    sellFee: json["sellFee"],
    buyFeeCoin: json["buyFeeCoin"],
    sellFeeCoin: json["sellFeeCoin"],
    dealPrice: json["dealPrice"],
    usdtTotal: json["usdtTotal"],
    fee: json["fee"],
    feeCoin: json["feeCoin"],
    role: json["role"],
    ctimeFormat: DateTime.parse(json["ctimeFormat"]),
    ctime: json["ctime"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "volume": volume,
    "trendSide": trendSide,
    "quoteCoin": quoteCoin,
    "baseCoin": baseCoin,
    "buyFee": buyFee,
    "sellFee": sellFee,
    "buyFeeCoin": buyFeeCoin,
    "sellFeeCoin": sellFeeCoin,
    "dealPrice": dealPrice,
    "usdtTotal": usdtTotal,
    "fee": fee,
    "feeCoin": feeCoin,
    "role": role,
    "ctimeFormat": ctimeFormat.toIso8601String(),
    "ctime": ctime,
  };
}

