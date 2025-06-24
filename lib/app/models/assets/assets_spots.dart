// To parse this JSON data, do
//
//     final assetsSpots = assetsSpotsFromJson(jsonString);

import 'dart:convert';

class AssetsSpots {
  String? platformCoin;
  Map<String, AssetSpotsAllCoinMapModel> allCoinMap;
  String? totalBalanceSymbol;
  String? totalBalance;
  String? pnlRate;
  String? pnlAmount;

  AssetsSpots({
    this.platformCoin,
    required this.allCoinMap,
    this.totalBalanceSymbol,
    this.totalBalance,
    this.pnlRate,
    this.pnlAmount,
  });

  factory AssetsSpots.fromJson(Map<String?, dynamic> json) =>
      AssetsSpots(
        platformCoin: json["platformCoin"],
        pnlRate: json["pnlRate"],
        pnlAmount: json["pnlAmount"],
        allCoinMap: Map.from(json["allCoinMap"])
            .map((k, v) => MapEntry<String, AssetSpotsAllCoinMapModel>(k, AssetSpotsAllCoinMapModel.fromJson(v))),
        totalBalanceSymbol: json["totalBalanceSymbol"],
        totalBalance: json["totalBalance"],
      );

  Map<String?, dynamic> toJson() =>
      {
        "platformCoin": platformCoin,
        "pnlRate": pnlRate,
        "pnlAmount": pnlAmount,
        "allCoinMap": Map.from(allCoinMap).map((k, v) => MapEntry<String?, dynamic>(k, v.toJson())),
        "totalBalanceSymbol": totalBalanceSymbol,
        "totalBalance": totalBalance,
      };
}

class AssetSpotsAllCoinMapModel {
  int? walletTransactionOpen;
  int? innerTransferFee;
  String? allBalance;
  String? exchangeSymbol;
  String? presentCoinBalance;
  String? lockPositionBalance;
  int? innerTransferOpen;
  int? depositOpen;
  int? otcOpen;
  double? depositMin; //最小投资额
  String? checked;
  String? allBtcValuatin;
  String? lockPositionV2Amount;
  double? withdrawMax;
  int? withdrawOpen;
  List<dynamic>? withdrawAddressMap;
  int? feeMin;
  String? lockIncrementAmount;
  int? isFiat;
  String? normalBalance;
  String? usdtValuatin;
  int? sort;
  double? withdrawMin;
  String? lockGrantDividedBalance;
  String? totalBalance;
  String? ncLockBalance;
  int? feeMax;
  int? defaultFee;
  String? coinName;
  String? lockBalance;
  String? overchargeBalance;
  dynamic icon;
  dynamic showPrecision; //补充一个精度
  //v2
  String? showName;
  String? name; //币种全称 接口字段更新

  AssetSpotsAllCoinMapModel({this.walletTransactionOpen,
    this.innerTransferFee,
    this.allBalance,
    this.exchangeSymbol,
    this.presentCoinBalance,
    this.lockPositionBalance,
    this.innerTransferOpen,
    this.depositOpen,
    this.otcOpen,
    this.depositMin,
    this.checked,
    this.allBtcValuatin,
    this.lockPositionV2Amount,
    this.withdrawMax,
    this.withdrawOpen,
    this.withdrawAddressMap,
    this.feeMin,
    this.lockIncrementAmount,
    this.isFiat,
    this.normalBalance,
    this.usdtValuatin,
    this.sort,
    this.withdrawMin,
    this.lockGrantDividedBalance,
    this.totalBalance,
    this.ncLockBalance,
    this.feeMax,
    this.defaultFee,
    this.coinName,
    this.lockBalance,
    this.overchargeBalance,
    this.icon,
    this.showPrecision,
    this.showName,
    this.name,
  });

  factory AssetSpotsAllCoinMapModel.fromRawJson(String str) => AssetSpotsAllCoinMapModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetSpotsAllCoinMapModel.fromJson(Map<String, dynamic> json) =>
      AssetSpotsAllCoinMapModel(
        walletTransactionOpen: json["walletTransactionOpen"],
        innerTransferFee: json["innerTransferFee"],
        allBalance: json["allBalance"],
        exchangeSymbol: json["exchange_symbol"],
        presentCoinBalance: json["present_coin_balance"],
        lockPositionBalance: json["lock_position_balance"],
        innerTransferOpen: json["innerTransferOpen"],
        depositOpen: json["depositOpen"],
        otcOpen: json["otcOpen"],
        depositMin: json["depositMin"],
        checked: json["checked"],
        allBtcValuatin: json["allBtcValuatin"],
        lockPositionV2Amount: json["lock_position_v2_amount"],
        withdrawMax: json["withdraw_max"],
        withdrawOpen: json["withdrawOpen"],
        withdrawAddressMap:
        json["withdrawAddressMap"] == null ? [] : List<dynamic>.from(json["withdrawAddressMap"]!.map((x) => x)),
        feeMin: json["feeMin"],
        lockIncrementAmount: json["lock_increment_amount"],
        isFiat: json["isFiat"],
        normalBalance: json["normal_balance"],
        usdtValuatin: json["usdtValuatin"],
        sort: json["sort"],
        withdrawMin: json["withdraw_min"],
        lockGrantDividedBalance: json["lock_grant_divided_balance"],
        totalBalance: json["total_balance"],
        ncLockBalance: json["nc_lock_balance"],
        feeMax: json["feeMax"],
        defaultFee: json["defaultFee"],
        coinName: json["coinName"],
        lockBalance: json["lock_balance"],
        overchargeBalance: json["overcharge_balance"],
        icon: json["icon"],
        showPrecision: json["showPrecision"],
        showName: json["showName"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "walletTransactionOpen": walletTransactionOpen,
        "innerTransferFee": innerTransferFee,
        "allBalance": allBalance,
        "exchange_symbol": exchangeSymbol,
        "present_coin_balance": presentCoinBalance,
        "lock_position_balance": lockPositionBalance,
        "innerTransferOpen": innerTransferOpen,
        "depositOpen": depositOpen,
        "otcOpen": otcOpen,
        "depositMin": depositMin,
        "checked": checked,
        "allBtcValuatin": allBtcValuatin,
        "lock_position_v2_amount": lockPositionV2Amount,
        "withdraw_max": withdrawMax,
        "withdrawOpen": withdrawOpen,
        "withdrawAddressMap": withdrawAddressMap == null ? [] : List<dynamic>.from(withdrawAddressMap!.map((x) => x)),
        "feeMin": feeMin,
        "lock_increment_amount": lockIncrementAmount,
        "isFiat": isFiat,
        "normal_balance": normalBalance,
        "usdtValuatin": usdtValuatin,
        "sort": sort,
        "withdraw_min": withdrawMin,
        "lock_grant_divided_balance": lockGrantDividedBalance,
        "total_balance": totalBalance,
        "nc_lock_balance": ncLockBalance,
        "feeMax": feeMax,
        "defaultFee": defaultFee,
        "coinName": coinName,
        "lock_balance": lockBalance,
        "overcharge_balance": overchargeBalance,
        "icon": icon,
        "showPrecision": showPrecision,
        "showName": showName,
        "name": name,
      };
}
