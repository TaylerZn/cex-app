// To parse this JSON data, do
//
//     final assetsOverView = assetsOverViewFromJson(jsonString);

import 'dart:convert';

class AssetsOverView {
  /// 总资产
  String? totalBalance;

  /// 现货账户余额
  String? balance;

  /// c2c账户余额
  String? c2cBalance;

  /// 合约账户余额
  String? futuresTotalBalance;

  /// 杠杆账户余额
  String? leverBalance;

  /// 跟单账户余额
  String? followBalance;

  /// 标准合约账户余额
  String? standardFuturesBalance;

  /// 今日盈亏率
  String? pnlRate;

  /// 今日盈亏额
  String? pnlAmount;

  ///
  String? totalBalanceSymbol;

  AssetsOverView({
    this.totalBalance,
    this.balance,
    this.c2cBalance,
    this.futuresTotalBalance,
    this.leverBalance,
    this.followBalance,
    this.standardFuturesBalance,
    this.pnlRate,
    this.pnlAmount,
    this.totalBalanceSymbol,
  });

  factory AssetsOverView.fromJson(Map<String, dynamic> json) => AssetsOverView(
        totalBalance: json["totalBalance"],
        balance: json["balance"],
        c2cBalance: json["c2cBalance"],
        futuresTotalBalance: json["futuresTotalBalance"],
        leverBalance: json["leverBalance"],
        followBalance: json["followBalance"],
        standardFuturesBalance: json["standardFuturesBalance"],
        pnlRate: json["pnlRate"],
        pnlAmount: json["pnlAmount"],
        totalBalanceSymbol: json["totalBalanceSymbol"],
      );

  Map<String, dynamic> toJson() => {
        "totalbalance": totalBalance,
        "balance": balance,
        "c2cBalance": c2cBalance,
        "futuresTotalBalance": futuresTotalBalance,
        "leverBalance": leverBalance,
        "followBalance": followBalance,
        "standardFuturesBalance": standardFuturesBalance,
        "pnlRate": pnlRate,
        "pnlAmount": pnlAmount,
        "totalBalanceSymbol": totalBalanceSymbol,
      };
}
