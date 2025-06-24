import 'dart:convert';

class ConvertQuickQuoteRate {
  String? buyPrice;
  String? sellPrice;

  ConvertQuickQuoteRate({
    this.buyPrice,
    this.sellPrice,
  });

  factory ConvertQuickQuoteRate.fromRawJson(String str) =>
      ConvertQuickQuoteRate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConvertQuickQuoteRate.fromJson(Map<String, dynamic> json) =>
      ConvertQuickQuoteRate(
        buyPrice: json["buyPrice"],
        sellPrice: json["sellPrice"],
      );

  Map<String, dynamic> toJson() => {
        "buyPrice": buyPrice,
        "sellPrice": sellPrice,
      };
}
