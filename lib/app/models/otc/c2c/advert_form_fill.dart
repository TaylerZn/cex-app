// To parse this JSON data, do
//
//     final advertFormFill = advertFormFillFromJson(jsonString);

import 'dart:convert';

AdvertFormFill advertFormFillFromJson(String str) => AdvertFormFill.fromJson(json.decode(str));

String advertFormFillToJson(AdvertFormFill data) => json.encode(data.toJson());

class AdvertFormFill {
  String? volume;
  String? price;
  String? minTrade;
  String? maxTrade;
  String? paycoin;
  List<int?>? payments;
  List<int>? transUserLimit;
  String? transDescription;
  int? chatAuto = 0;
  String? chatAutoReply = '';

  AdvertFormFill({
    this.volume,
    this.price,
    this.minTrade,
    this.maxTrade,
    this.paycoin,
    this.payments,
    this.transUserLimit,
    this.transDescription,
    this.chatAuto,
    this.chatAutoReply
  });

  factory AdvertFormFill.fromJson(Map<String, dynamic> json) => AdvertFormFill(
    volume: json["volume"],
    price: json["price"],
    minTrade: json["minTrade"],
    maxTrade: json["maxTrade"],
    paycoin: json["paycoin"],
    payments: json["payments"] == null ? [] : List<int?>.from(json["payments"]!.map((x) => x)),
    transUserLimit: json["transUserLimit"] == null ? [] : List<int>.from(json["transUserLimit"]!.map((x) => x)),
    transDescription: json["transDescription"],
    chatAuto: json["chatAuto"] ?? 0,
    chatAutoReply : json['chatAutoReply'] ?? 'test'
  );

  Map<String, dynamic> toJson() => {
    "volume": volume,
    "price": price,
    "minTrade": minTrade,
    "maxTrade": maxTrade,
    "chatAutoReply" : chatAutoReply,
    "paycoin": paycoin,
    "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x)),
    "transUserLimit": transUserLimit == null ? [] : List<dynamic>.from(transUserLimit!.map((x) => x)),
    "transDescription": transDescription,
    "chatAuto": chatAuto,
  };
}
