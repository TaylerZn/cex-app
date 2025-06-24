// To parse this JSON data, do
//
//     final spotOrderRes = spotOrderResFromJson(jsonString);

import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

import '../../modules/transation/entrust/model/transaction_model.dart';

class SpotOrderRes {
  List<SpotOrderInfo>? orderList;
  int? pricePrecision;
  String? symbol;
  String? price;
  String? countCoinBalance;
  String? minVolume;
  String? minPrice;
  int? count;
  String? baseCoinBalance;
  int? volumePrecision;

  SpotOrderRes({
    this.pricePrecision,
    this.symbol,
    this.price,
    this.countCoinBalance,
    this.minVolume,
    this.minPrice,
    this.count,
    this.orderList,
    this.baseCoinBalance,
    this.volumePrecision,
  });

  factory SpotOrderRes.fromJson(Map<String, dynamic> json) => SpotOrderRes(
        count: json["count"],
        orderList: List<SpotOrderInfo>.from(
          json["orderList"].map(
            (x) => SpotOrderInfo.fromJson(x),
          ),
        ),
        pricePrecision: json["pricePrecision"],
        symbol: json["symbol"],
        price: json["price"],
        countCoinBalance: json["countCoinBalance"],
        minVolume: json["minVolume"],
        minPrice: json["minPrice"],
        baseCoinBalance: json["baseCoinBalance"],
        volumePrecision: json["volumePrecision"],
      );
}

class SpotOrderInfo with transactionMixin {
  String side;
  String totalPrice;
  int timeLong;
  DateTime createdAt;
  String avgPrice;
  String countCoin;
  String source;
  int type;
  String volume;
  String price;
  String dealVolume;
  String id;
  String statusText;
  String remainVolume;
  String dealMoney;
  String baseCoin;
  int status;
  int isCloseCancelOrder;
  String symbol;

  double get percent =>
      dealVolume.toNum() / (dealVolume.toNum() + remainVolume.toNum());

  SpotOrderInfo({
    required this.side,
    required this.totalPrice,
    required this.timeLong,
    required this.createdAt,
    required this.avgPrice,
    required this.countCoin,
    required this.source,
    required this.type,
    required this.volume,
    required this.price,
    required this.dealVolume,
    required this.id,
    required this.statusText,
    required this.remainVolume,
    required this.dealMoney,
    required this.baseCoin,
    required this.status,
    required this.isCloseCancelOrder,
    required this.symbol,
  });

  factory SpotOrderInfo.fromJson(Map<String, dynamic> json) => SpotOrderInfo(
        side: json["side"],
        totalPrice: json["total_price"],
        timeLong: json["time_long"],
        createdAt: DateTime.parse(json["created_at"]),
        avgPrice: json["avg_price"],
        countCoin: json["countCoin"],
        source: json["source"],
        type: json["type"],
        volume: json["volume"],
        price: json["price"],
        dealVolume: json["deal_volume"],
        id: json["id"],
        statusText: json["status_text"],
        remainVolume: json["remain_volume"],
        dealMoney: json["deal_money"],
        baseCoin: json["baseCoin"],
        status: json["status"],
        isCloseCancelOrder: json["isCloseCancelOrder"],
        symbol: json["symbol"] ?? "${json["baseCoin"]}/${json["countCoin"]}",
      );

  Map<String, dynamic> toJson() => {
        "side": side,
        "total_price": totalPrice,
        "time_long": timeLong,
        "created_at": createdAt.toIso8601String(),
        "avg_price": avgPrice,
        "countCoin": countCoin,
        "source": source,
        "type": type,
        "volume": volume,
        "price": price,
        "deal_volume": dealVolume,
        "id": id,
        "status_text": statusText,
        "remain_volume": remainVolume,
        "deal_money": dealMoney,
        "baseCoin": baseCoin,
        "status": status,
        "isCloseCancelOrder": isCloseCancelOrder,
        "symbol": symbol,
      };
}
