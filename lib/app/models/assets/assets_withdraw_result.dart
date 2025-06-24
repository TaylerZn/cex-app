// To parse this JSON data, do
//
//     final assetsWithdrawResult = assetsWithdrawResultFromJson(jsonString);

import 'dart:convert';

class AssetsWithdrawResult {
  dynamic applyTime;
  dynamic applyTimeTime;
  dynamic coinSymbol;
  dynamic amount;
  dynamic address;
  dynamic label;

  AssetsWithdrawResult({
    this.applyTime,
    this.applyTimeTime,
    this.coinSymbol,
    this.amount,
    this.address,
    this.label,
  });

  factory AssetsWithdrawResult.fromJson(Map<String, dynamic> json) =>
      AssetsWithdrawResult(
        applyTime: json["applyTime"],
        applyTimeTime: json["applyTimeTime"],
        coinSymbol: json["coinSymbol"],
        amount: json["amount"],
        address: json["address"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "applyTime": applyTime,
        "applyTimeTime": applyTimeTime,
        "coinSymbol": coinSymbol,
        "amount": amount,
        "address": address,
        "label": label,
      };
}
