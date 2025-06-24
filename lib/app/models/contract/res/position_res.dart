// To parse this JSON data, do
//
//     final positionRes = positionResFromJson(jsonString);

import 'dart:convert';

PositionRes positionResFromJson(String str) => PositionRes.fromJson(json.decode(str));

String positionResToJson(PositionRes data) => json.encode(data.toJson());

class PositionRes {
  num marginAmountUsd;
  num accountBalanceUsd;
  num unRealizedAmountUsd;
  List<PositionInfo> positionList;
  List<AccountRes> accountList;
  String? totalBalanceSymbol;
  num? totalBalance;
  String assetUiUrl;

  PositionRes({
    required this.marginAmountUsd,
    required this.accountBalanceUsd,
    required this.unRealizedAmountUsd,
    required this.positionList,
    required this.accountList,
    this.totalBalanceSymbol,
    this.totalBalance,
    required this.assetUiUrl,
  });

  factory PositionRes.fromJson(Map<String, dynamic> json) => PositionRes(
        marginAmountUsd: json["marginAmountUsd"],
        accountBalanceUsd: json["accountBalanceUsd"],
        unRealizedAmountUsd: json["unRealizedAmountUsd"],
        totalBalanceSymbol: json["totalBalanceSymbol"],
        totalBalance: json["totalBalance"],
        positionList: List<PositionInfo>.from(json["positionList"].map((x) => PositionInfo.fromJson(x))),
        accountList: List<AccountRes>.from(json["accountList"].map((x) => AccountRes.fromJson(x))),
        assetUiUrl: json["assetUiUrl"],
      );

  Map<String, dynamic> toJson() => {
        "positionList": List<dynamic>.from(positionList.map((x) => x.toJson())),
        "accountList": List<dynamic>.from(accountList.map((x) => x.toJson())),
        "assetUiUrl": assetUiUrl,
        "marginAmountUsd": marginAmountUsd,
        "accountBalanceUsd": accountBalanceUsd,
        "unRealizedAmountUsd": unRealizedAmountUsd,
        "totalBalanceSymbol": totalBalanceSymbol,
        "totalBalance": totalBalance,
      };
}

class AccountRes {
  String symbol;
  num accountBalance;
  num canUseAmount;
  String? isolateMargin;
  String lockAmount;
  String originalCoin;
  String unRealizedAmount;
  String realizedAmount;
  String? totalMargin;
  String? totalMarginRate;
  String? marginAmount;
  num? trialAmount;

  num canTransferAmount;
  AccountRes({
    required this.symbol,
    required this.accountBalance,
    required this.canUseAmount,
    required this.isolateMargin,
    required this.lockAmount,
    required this.originalCoin,
    required this.unRealizedAmount,
    required this.realizedAmount,
    required this.totalMargin,
    required this.totalMarginRate,
    required this.marginAmount,
    required this.canTransferAmount,
    required this.trialAmount,
  });

  factory AccountRes.fromJson(Map<String, dynamic> json) => AccountRes(
        symbol: json["symbol"],
        accountBalance: json["accountBalance"],
        canUseAmount: json["canUseAmount"],
        isolateMargin: json["isolateMargin"],
        lockAmount: json["lockAmount"],
        originalCoin: json["originalCoin"],
        unRealizedAmount: json["unRealizedAmount"],
        realizedAmount: json["realizedAmount"],
        totalMargin: json["totalMargin"],
        totalMarginRate: json["totalMarginRate"],
        marginAmount: json["marginAmount"],
        canTransferAmount: json["canTransferAmount"] ?? 0,
        trialAmount: json["trialAmount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "accountBalance": accountBalance,
        "canUseAmount": canUseAmount,
        "isolateMargin": isolateMargin,
        "lockAmount": lockAmount,
        "originalCoin": originalCoin,
        "unRealizedAmount": unRealizedAmount,
        "realizedAmount": realizedAmount,
        "totalMargin": totalMargin,
        "totalMarginRate": totalMarginRate,
        "marginAmount": marginAmount,
        "canTransferAmount": canTransferAmount,
        "trialAmount": trialAmount,
      };
}

class PositionInfo {
  num id;
  num contractId;
  String contractName;
  String symbol;
  num positionVolume;
  num canCloseVolume;
  num openAvgPrice;
  num indexPrice;
  num reducePrice;
  num holdAmount;
  num marginRate;
  num realizedAmount;
  num returnRate;
  String orderSide;
  num positionType;
  num canUseAmount;
  num canSubMarginAmount;
  num openRealizedAmount;
  num keepRate;
  num maxFeeRate;
  num unRealizedAmount;
  num leverageLevel;
  num positionBalance;
  String tradeFee;
  String capitalFee;
  String closeProfit;
  String settleProfit;
  String shareAmount;
  String historyRealizedAmount;
  String profitRealizedAmount;
  num openAmount;

  PositionInfo({
    required this.id,
    required this.contractId,
    required this.contractName,
    required this.symbol,
    required this.positionVolume,
    required this.canCloseVolume,
    required this.openAvgPrice,
    required this.indexPrice,
    required this.reducePrice,
    required this.holdAmount,
    required this.marginRate,
    required this.realizedAmount,
    required this.returnRate,
    required this.orderSide,
    required this.positionType,
    required this.canUseAmount,
    required this.canSubMarginAmount,
    required this.openRealizedAmount,
    required this.keepRate,
    required this.maxFeeRate,
    required this.unRealizedAmount,
    required this.leverageLevel,
    required this.positionBalance,
    required this.tradeFee,
    required this.capitalFee,
    required this.closeProfit,
    required this.settleProfit,
    required this.shareAmount,
    required this.historyRealizedAmount,
    required this.profitRealizedAmount,
    required this.openAmount,
  });

  factory PositionInfo.fromJson(Map<String, dynamic> json) => PositionInfo(
        id: json["id"],
        contractId: json["contractId"],
        contractName: json["contractName"],
        symbol: json["symbol"],
        positionVolume: json["positionVolume"],
        canCloseVolume: json["canCloseVolume"],
        openAvgPrice: json["openAvgPrice"],
        indexPrice: json["indexPrice"],
        reducePrice: json["reducePrice"],
        holdAmount: json["holdAmount"],
        marginRate: json["marginRate"],
        realizedAmount: json["realizedAmount"],
        returnRate: json["returnRate"],
        orderSide: json["orderSide"],
        positionType: json["positionType"],
        canUseAmount: json["canUseAmount"],
        canSubMarginAmount: json["canSubMarginAmount"],
        openRealizedAmount: json["openRealizedAmount"],
        keepRate: json["keepRate"],
        maxFeeRate: json["maxFeeRate"],
        unRealizedAmount: json["unRealizedAmount"],
        leverageLevel: json["leverageLevel"],
        positionBalance: json["positionBalance"],
        tradeFee: json["tradeFee"],
        capitalFee: json["capitalFee"],
        closeProfit: json["closeProfit"],
        settleProfit: json["settleProfit"],
        shareAmount: json["shareAmount"],
        historyRealizedAmount: json["historyRealizedAmount"],
        profitRealizedAmount: json["profitRealizedAmount"],
        openAmount: json["openAmount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contractId": contractId,
        "contractName": contractName,
        "symbol": symbol,
        "positionVolume": positionVolume,
        "canCloseVolume": canCloseVolume,
        "openAvgPrice": openAvgPrice,
        "indexPrice": indexPrice,
        "reducePrice": reducePrice,
        "holdAmount": holdAmount,
        "marginRate": marginRate,
        "realizedAmount": realizedAmount,
        "returnRate": returnRate,
        "orderSide": orderSide,
        "positionType": positionType,
        "canUseAmount": canUseAmount,
        "canSubMarginAmount": canSubMarginAmount,
        "openRealizedAmount": openRealizedAmount,
        "keepRate": keepRate,
        "maxFeeRate": maxFeeRate,
        "unRealizedAmount": unRealizedAmount,
        "leverageLevel": leverageLevel,
        "positionBalance": positionBalance,
        "tradeFee": tradeFee,
        "capitalFee": capitalFee,
        "closeProfit": closeProfit,
        "settleProfit": settleProfit,
        "shareAmount": shareAmount,
        "historyRealizedAmount": historyRealizedAmount,
        "profitRealizedAmount": profitRealizedAmount,
        "openAmount": openAmount,
      };
}
