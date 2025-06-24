// To parse this JSON data, do
//
//     final advertExchangeRate = advertExchangeRateFromJson(jsonString);

import 'dart:convert';

AdvertExchangeRate advertExchangeRateFromJson(String str) => AdvertExchangeRate.fromJson(json.decode(str));

String advertExchangeRateToJson(AdvertExchangeRate data) => json.encode(data.toJson());

class AdvertExchangeRate {
  String? buyValue;
  String? sellValue;

  AdvertExchangeRate({
    this.buyValue,
    this.sellValue,
  });

  factory AdvertExchangeRate.fromJson(Map<String, dynamic> json) => AdvertExchangeRate(
    buyValue: '${json["buyValue"]}',
    sellValue: '${json["sellValue"]}',
  );

  Map<String, dynamic> toJson() => {
    "buyValue": buyValue,
    "sellValue": sellValue,
  };
}
