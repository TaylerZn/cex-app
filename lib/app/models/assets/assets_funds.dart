// To parse this JSON data, do
//
//     final AssetsFunds = AssetsFundsFromJson(jsonString);

import 'dart:convert';

class AssetsFunds {
  List<AssetsFundsAllCoinMapModel>? allCoinMap;
  String? totalBalanceSymbol;
  num? totalBalance;
  AssetsFunds({
    required this.allCoinMap,
    this.totalBalanceSymbol,
    this.totalBalance,
  });

  factory AssetsFunds.fromJson(Map<String?, dynamic> json) => AssetsFunds(
        allCoinMap: json["allCoinMap"] == null
            ? []
            : List<AssetsFundsAllCoinMapModel>.from(json["allCoinMap"]!
                .map((x) => AssetsFundsAllCoinMapModel.fromJson(x))),
        totalBalanceSymbol: json["totalBalanceSymbol"],
        totalBalance: json["totalBalance"],
      );

  Map<String?, dynamic> toJson() => {
        "allCoinMap": allCoinMap == null
            ? []
            : List<dynamic>.from(allCoinMap!.map((x) => x.toJson())),
        "totalBalanceSymbol": totalBalanceSymbol,
        "totalBalance": totalBalance,
      };
}

class AssetsFundsAllCoinMapModel {
  String? totalBalance;
  String? normal;
  String? coinSymbol;
  String? exchangeNormal;
  String? lock;
  String? checked;
  String? btcValuation;
  String? showName; // 用于币种全称
  AssetsFundsAllCoinMapModel({
    this.totalBalance,
    this.normal,
    this.coinSymbol,
    this.exchangeNormal,
    this.lock,
    this.checked,
    this.btcValuation,
    this.showName,
  });

  factory AssetsFundsAllCoinMapModel.fromRawJson(String str) =>
      AssetsFundsAllCoinMapModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetsFundsAllCoinMapModel.fromJson(Map<String, dynamic> json) =>
      AssetsFundsAllCoinMapModel(
        totalBalance: json["total_balance"],
        normal: json["normal"],
        coinSymbol: json["coinSymbol"],
        exchangeNormal: json["exchangeNormal"],
        lock: json["lock"],
        checked: json["checked"],
        btcValuation: json["btcValuation"],
        showName: json["showName"],
      );

  Map<String, dynamic> toJson() => {
        "total_balance": totalBalance,
        "normal": normal,
        "coinSymbol": coinSymbol,
        "exchangeNormal": exchangeNormal,
        "lock": lock,
        "checked": checked,
        "btcValuation": btcValuation,
        "showName": showName,
      };
}
