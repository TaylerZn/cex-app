import 'dart:convert';

class ConvertCurrenciesModel {
  List<CoinModel>? baseList;
  List<CoinModel>? quoteList;

  ConvertCurrenciesModel({
    this.baseList,
    this.quoteList,
  });

  factory ConvertCurrenciesModel.fromRawJson(String str) =>
      ConvertCurrenciesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConvertCurrenciesModel.fromJson(Map<String, dynamic> json) =>
      ConvertCurrenciesModel(
        baseList: json["baseList"] == null
            ? []
            : List<CoinModel>.from(
                json["baseList"]!.map((x) => CoinModel.fromJson(x))),
        quoteList: json["quoteList"] == null
            ? []
            : List<CoinModel>.from(
                json["quoteList"]!.map((x) => CoinModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "baseList": baseList == null
            ? []
            : List<dynamic>.from(baseList!.map((x) => x.toJson())),
        "quoteList": quoteList == null
            ? []
            : List<dynamic>.from(quoteList!.map((x) => x.toJson())),
      };
}

class CoinModel {
  int? id;
  String? symbol;
  String? min;
  String? max;
  int? precision;
  int? type;
  double? threshold;
  String? icon;

  CoinModel({
    this.id,
    this.symbol,
    this.min,
    this.max,
    this.precision,
    this.type,
    this.threshold,
    this.icon,
  });

  factory CoinModel.fromRawJson(String str) =>
      CoinModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
        id: json["id"],
        symbol: json["symbol"],
        min: json["min"],
        max: json["max"],
        precision: json["precision"],
        type: json["type"],
        threshold: json["threshold"]?.toDouble(),
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "min": min,
        "max": max,
        "precision": precision,
        "type": type,
        "threshold": threshold,
        "icon": icon,
      };
}
