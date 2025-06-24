// To parse this JSON data, do
//
//     final assetsContract = assetsContractFromJson(jsonString);

import 'dart:convert';

AssetsContract assetsContractFromJson(String str) =>
    AssetsContract.fromJson(json.decode(str));

String assetsContractToJson(AssetsContract data) => json.encode(data.toJson());

class AssetsContract {
  List<PositionList>? positionList;
  List<AccountList>? accountList;
  num? accountBalanceUsd;
  num? unRealizedAmountUsd;
  num? marginAmountUsd;
  num? totalBalance;
  String? totalBalanceSymbol;
  String? assetUiUrl;
  String? pnlAmount;
  String? pnlRate;
  num? marginRate;

  AssetsContract({
    this.positionList,
    this.accountList,
    this.accountBalanceUsd,
    this.unRealizedAmountUsd,
    this.marginAmountUsd,
    this.totalBalance,
    this.totalBalanceSymbol,
    this.assetUiUrl,
    this.pnlAmount,
    this.pnlRate,
    this.marginRate,
  });

  factory AssetsContract.fromJson(Map<String, dynamic> json) => AssetsContract(
        positionList: json["positionList"] == null
            ? []
            : List<PositionList>.from(
                json["positionList"].map((x) => PositionList.fromJson(x))),
        accountList: json["accountList"] == null
            ? []
            : List<AccountList>.from(
                json["accountList"].map((x) => AccountList.fromJson(x))),
        accountBalanceUsd: json["accountBalanceUsd"],
        unRealizedAmountUsd: json["unRealizedAmountUsd"],
        marginAmountUsd: json["marginAmountUsd"],
        totalBalance: json["totalBalance"],
        totalBalanceSymbol: json["totalBalanceSymbol"],
        assetUiUrl: json["assetUiUrl"],
        pnlAmount: json["pnlAmount"],
        pnlRate: json["pnlRate"],
        marginRate: json["marginRate"],
      );

  Map<String, dynamic> toJson() => {
        "positionList": positionList == null ? [] : List<dynamic>.from(positionList!.map((x) => x.toJson())),
        "accountList": accountList == null ? [] : List<dynamic>.from(accountList!.map((x) => x.toJson())),
        "accountBalanceUsd": accountBalanceUsd,
        "unRealizedAmountUsd": unRealizedAmountUsd,
        "marginAmountUsd": marginAmountUsd,
        "totalBalance": totalBalance,
        "assetUiUrl": assetUiUrl,
        "pnlAmount": pnlAmount,
        "pnlRate": pnlRate,
        "marginRate": marginRate,
      };
}

class AccountList {
  String symbol;
  num accountBalance;
  num canUseAmount;
  String? isolateMargin;
  String lockAmount;
  String originalCoin;
  String unRealizedAmount;
  String realizedAmount;
  String marginAmount;
  num? trialAmount;
  num canTransferAmount;
  // String totalMarginRate;

  AccountList({
    required this.symbol,
    required this.accountBalance,
    required this.canUseAmount,
    required this.isolateMargin,
    required this.lockAmount,
    required this.originalCoin,
    required this.unRealizedAmount,
    required this.realizedAmount,
    required this.marginAmount,
    required this.trialAmount,
    required this.canTransferAmount,
    // required this.totalMarginRate,
  });

  factory AccountList.fromJson(Map<String, dynamic> json) => AccountList(
        symbol: json["symbol"],
        accountBalance: json["accountBalance"],
        canUseAmount: json["canUseAmount"]?.toDouble(),
        isolateMargin: json["isolateMargin"],
        lockAmount: json["lockAmount"],
        originalCoin: json["originalCoin"],
        unRealizedAmount: json["unRealizedAmount"],
        realizedAmount: json["realizedAmount"],
        marginAmount: json["marginAmount"],
        trialAmount: json["trialAmount"],
        canTransferAmount: json["canTransferAmount"] ?? 0,
        // totalMarginRate: json["totalMarginRate"],
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
        "marginAmount": marginAmount,
        "trialAmount": trialAmount,
        "canTransferAmount": canTransferAmount,
        // "totalMarginRate": totalMarginRate,
      };
}

class PositionList {
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

  PositionList({
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

  factory PositionList.fromJson(Map<String, dynamic> json) => PositionList(
        id: json["id"],
        contractId: json["contractId"],
        contractName: json["contractName"],
        symbol: json["symbol"],
        positionVolume: json["positionVolume"],
        canCloseVolume: json["canCloseVolume"],
        openAvgPrice: json["openAvgPrice"]?.toDouble(),
        indexPrice: json["indexPrice"]?.toDouble(),
        reducePrice: json["reducePrice"]?.toDouble(),
        holdAmount: json["holdAmount"]?.toDouble(),
        marginRate: json["marginRate"]?.toDouble(),
        realizedAmount: json["realizedAmount"],
        returnRate: json["returnRate"]?.toDouble(),
        orderSide: json["orderSide"],
        positionType: json["positionType"],
        canUseAmount: json["canUseAmount"]?.toDouble(),
        canSubMarginAmount: json["canSubMarginAmount"],
        openRealizedAmount: json["openRealizedAmount"]?.toDouble(),
        keepRate: json["keepRate"]?.toDouble(),
        maxFeeRate: json["maxFeeRate"]?.toDouble(),
        unRealizedAmount: json["unRealizedAmount"]?.toDouble(),
        leverageLevel: json["leverageLevel"],
        positionBalance: json["positionBalance"]?.toDouble(),
        tradeFee: json["tradeFee"],
        capitalFee: json["capitalFee"],
        closeProfit: json["closeProfit"],
        settleProfit: json["settleProfit"],
        shareAmount: json["shareAmount"],
        historyRealizedAmount: json["historyRealizedAmount"],
        profitRealizedAmount: json["profitRealizedAmount"],
        openAmount: json["openAmount"]?.toDouble(),
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
