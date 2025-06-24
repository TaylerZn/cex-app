// To parse this JSON data, do
//
//     final advertModel = advertModelFromJson(jsonString);

import 'dart:convert';

AdvertModel advertModelFromJson(String str) => AdvertModel.fromJson(json.decode(str));

String advertModelToJson(AdvertModel data) => json.encode(data.toJson());

class AdvertModel {
  List<DataList>? dataList;
  int? count;

  AdvertModel({
    this.dataList,
    this.count,
  });

  factory AdvertModel.fromJson(Map<String, dynamic> json) => AdvertModel(
    dataList: json["dataList"] == null ? [] : List<DataList>.from(json["dataList"]!.map((x) => DataList.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "dataList": dataList == null ? [] : List<dynamic>.from(dataList!.map((x) => x.toJson())),
    "count": count,
  };
}

class DataList {
  String? side;
  String? paycoinSymbol;
  String? paycoinTrade;
  String? sideText;
  String? sell;
  List<Payment>? payments;
  String? minTrade;
  String? stock;
  String? advertId;
  String? volume;
  String? condition;
  String? payAmount;
  String? createTime;
  String? price;
  String? maxTrade;
  String? status;
  String? coin;
  String? coinIcon;

  DataList({
    this.side,
    this.paycoinTrade,
    this.sideText,
    this.sell,
    this.payments,
    this.minTrade,
    this.advertId,
    this.volume,
    this.condition,
    this.payAmount,
    this.createTime,
    this.price,
    this.maxTrade,
    this.status,
    this.paycoinSymbol,
    this.coin,
    this.stock,
    this.coinIcon,
  });

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
    side: json["side"],
    paycoinTrade: json["paycoinTrade"],
    sideText: json["side_text"],
    sell: json["sell"],
    coinIcon:json['coinIcon'],
    payments: json["payments"] == null ? [] : List<Payment>.from(json["payments"]!.map((x) => Payment.fromJson(x))),
    minTrade: json["minTrade"],
    advertId: json["advertId"],
    volume: json["volume"],
    stock: json['stock'],
    condition: json["condition"],
    paycoinSymbol: json['paycoinSymbol'],
    payAmount: json["payAmount"],
    createTime: json["createTime"] ,
    price: json["price"],
    maxTrade: json["maxTrade"],
    status: json["status"],
    coin: json["coin"],
  );

  Map<String, dynamic> toJson() => {
    "side": side,
    "paycoinTrade": paycoinTrade,
    "side_text": sideText,
    "sell": sell,
    'coinIcon':coinIcon,
    "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x.toJson())),
    "minTrade": minTrade,
    "advertId": advertId,
    "volume": volume,
    "condition": condition,
    "payAmount": payAmount,
    "createTime": createTime,
    "price": price,
    'configCoinSymbol' : paycoinSymbol,
    "maxTrade": maxTrade,
    "status": status,
    "coin": coin,
  };
  bool get isPurchase => side == 'BUY';
}

class Payment {
  String? payment;
  String? payTitle;

  Payment({
    this.payment,
    this.payTitle,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    payment: json["payment"],
    payTitle: json["payTitle"],
  );

  Map<String, dynamic> toJson() => {
    "payment": payment,
    "payTitle": payTitle,
  };
}
