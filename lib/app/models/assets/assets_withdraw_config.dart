// To parse this JSON data, do
//
//     final assetsWithdrawConfig = assetsWithdrawConfigFromJson(jsonString);

import 'dart:convert';

AssetsWithdrawConfig assetsWithdrawConfigFromJson(String str) =>
    AssetsWithdrawConfig.fromJson(json.decode(str));

String assetsWithdrawConfigToJson(AssetsWithdrawConfig data) =>
    json.encode(data.toJson());

class AssetsWithdrawConfig {
  String feeMin;
  String feeMax;
  String mainChainNameTip;
  String defaultFee;
  String withdrawMin;
  List<dynamic> userWithdrawAddrList;
  String withdrawMax;
  num? withdrawMaxDay;
  num? withdrawMaxDayBalance;

  AssetsWithdrawConfig({
    required this.feeMin,
    required this.feeMax,
    required this.mainChainNameTip,
    required this.defaultFee,
    required this.withdrawMin,
    required this.userWithdrawAddrList,
    required this.withdrawMax,
    this.withdrawMaxDay,
    this.withdrawMaxDayBalance,
  });

  factory AssetsWithdrawConfig.fromJson(Map<String, dynamic> json) =>
      AssetsWithdrawConfig(
        feeMin: json["feeMin"],
        feeMax: json["feeMax"],
        mainChainNameTip: json["mainChainNameTip"],
        defaultFee: json["defaultFee"],
        withdrawMin: json["withdraw_min"],
        userWithdrawAddrList:
            List<dynamic>.from(json["userWithdrawAddrList"].map((x) => x)),
        withdrawMax: json["withdraw_max"],
        withdrawMaxDay: json["withdraw_max_day"],
        withdrawMaxDayBalance: json["withdraw_max_day_balance"],
      );

  Map<String, dynamic> toJson() => {
        "feeMin": feeMin,
        "feeMax": feeMax,
        "mainChainNameTip": mainChainNameTip,
        "defaultFee": defaultFee,
        "withdraw_min": withdrawMin,
        "userWithdrawAddrList":
            List<dynamic>.from(userWithdrawAddrList.map((x) => x)),
        "withdraw_max": withdrawMax,
        "withdraw_max_day": withdrawMaxDay,
      };
}
