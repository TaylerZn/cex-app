// To parse this JSON data, do
//
//     final assetsCurrency = assetsCurrencyFromJson(jsonString);

import 'dart:convert';

Map<String, AssetsCurrency> assetsCurrencyFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, AssetsCurrency>(k, AssetsCurrency.fromJson(v)));

String assetsCurrencyToJson(Map<String, AssetsCurrency> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class AssetsCurrency {
  String addrCombineSymbol;
  int addressLen;
  String btcRateMath;
  String chainAddress;
  String chainTx;
  String coinSymbol;
  String coinTag;
  String contractAddress;
  int contractPrecision;
  int ctime;
  int depositConfirm;
  int depositLockOpen;
  int depositMin;
  int depositOpen;
  String icon;
  int id;
  int isFiat;
  int isOpen;
  int isQuote;
  int isRelease;
  String link;
  String mainChainCoin;
  String mainChainName;
  String mainChainSymbol;
  int mainChainType;
  bool mainchain;
  int miningDepositConfirm;
  int mtime;
  String name;
  int onlyHoldShow;
  int otcOpen;
  String regular;
  int releaseStatus;
  int securityStatus;
  int showPrecision;
  int sort;
  int supportToken;
  int tagType;
  String tokenBase;
  int useRate;
  bool waasCoin;
  String walletSymbol;
  int walletType;
  int withdrawMax;
  int withdrawMaxDay;
  int withdrawMaxDayNoAuth;
  double withdrawMin;
  int withdrawOpen;

  AssetsCurrency({
    required this.addrCombineSymbol,
    required this.addressLen,
    required this.btcRateMath,
    required this.chainAddress,
    required this.chainTx,
    required this.coinSymbol,
    required this.coinTag,
    required this.contractAddress,
    required this.contractPrecision,
    required this.ctime,
    required this.depositConfirm,
    required this.depositLockOpen,
    required this.depositMin,
    required this.depositOpen,
    required this.icon,
    required this.id,
    required this.isFiat,
    required this.isOpen,
    required this.isQuote,
    required this.isRelease,
    required this.link,
    required this.mainChainCoin,
    required this.mainChainName,
    required this.mainChainSymbol,
    required this.mainChainType,
    required this.mainchain,
    required this.miningDepositConfirm,
    required this.mtime,
    required this.name,
    required this.onlyHoldShow,
    required this.otcOpen,
    required this.regular,
    required this.releaseStatus,
    required this.securityStatus,
    required this.showPrecision,
    required this.sort,
    required this.supportToken,
    required this.tagType,
    required this.tokenBase,
    required this.useRate,
    required this.waasCoin,
    required this.walletSymbol,
    required this.walletType,
    required this.withdrawMax,
    required this.withdrawMaxDay,
    required this.withdrawMaxDayNoAuth,
    required this.withdrawMin,
    required this.withdrawOpen,
  });

  factory AssetsCurrency.fromJson(Map<String, dynamic> json) => AssetsCurrency(
        addrCombineSymbol: json["addrCombineSymbol"],
        addressLen: json["addressLen"],
        btcRateMath: json["btcRateMath"],
        chainAddress: json["chainAddress"],
        chainTx: json["chainTx"],
        coinSymbol: json["coinSymbol"],
        coinTag: json["coinTag"],
        contractAddress: json["contractAddress"],
        contractPrecision: json["contractPrecision"],
        ctime: json["ctime"],
        depositConfirm: json["depositConfirm"],
        depositLockOpen: json["depositLockOpen"],
        depositMin: json["depositMin"],
        depositOpen: json["depositOpen"],
        icon: json["icon"],
        id: json["id"],
        isFiat: json["isFiat"],
        isOpen: json["isOpen"],
        isQuote: json["isQuote"],
        isRelease: json["isRelease"],
        link: json["link"],
        mainChainCoin: json["mainChainCoin"],
        mainChainName: json["mainChainName"],
        mainChainSymbol: json["mainChainSymbol"],
        mainChainType: json["mainChainType"],
        mainchain: json["mainchain"],
        miningDepositConfirm: json["miningDepositConfirm"],
        mtime: json["mtime"],
        name: json["name"],
        onlyHoldShow: json["onlyHoldShow"],
        otcOpen: json["otcOpen"],
        regular: json["regular"],
        releaseStatus: json["releaseStatus"],
        securityStatus: json["securityStatus"],
        showPrecision: json["showPrecision"],
        sort: json["sort"],
        supportToken: json["supportToken"],
        tagType: json["tagType"],
        tokenBase: json["tokenBase"],
        useRate: json["useRate"],
        waasCoin: json["waasCoin"],
        walletSymbol: json["walletSymbol"],
        walletType: json["walletType"],
        withdrawMax: json["withdrawMax"],
        withdrawMaxDay: json["withdrawMaxDay"],
        withdrawMaxDayNoAuth: json["withdrawMaxDayNoAuth"],
        withdrawMin: json["withdrawMin"]?.toDouble(),
        withdrawOpen: json["withdrawOpen"],
      );

  Map<String, dynamic> toJson() => {
        "addrCombineSymbol": addrCombineSymbol,
        "addressLen": addressLen,
        "btcRateMath": btcRateMath,
        "chainAddress": chainAddress,
        "chainTx": chainTx,
        "coinSymbol": coinSymbol,
        "coinTag": coinTag,
        "contractAddress": contractAddress,
        "contractPrecision": contractPrecision,
        "ctime": ctime,
        "depositConfirm": depositConfirm,
        "depositLockOpen": depositLockOpen,
        "depositMin": depositMin,
        "depositOpen": depositOpen,
        "icon": icon,
        "id": id,
        "isFiat": isFiat,
        "isOpen": isOpen,
        "isQuote": isQuote,
        "isRelease": isRelease,
        "link": link,
        "mainChainCoin": mainChainCoin,
        "mainChainName": mainChainName,
        "mainChainSymbol": mainChainSymbol,
        "mainChainType": mainChainType,
        "mainchain": mainchain,
        "miningDepositConfirm": miningDepositConfirm,
        "mtime": mtime,
        "name": name,
        "onlyHoldShow": onlyHoldShow,
        "otcOpen": otcOpen,
        "regular": regular,
        "releaseStatus": releaseStatus,
        "securityStatus": securityStatus,
        "showPrecision": showPrecision,
        "sort": sort,
        "supportToken": supportToken,
        "tagType": tagType,
        "tokenBase": tokenBase,
        "useRate": useRate,
        "waasCoin": waasCoin,
        "walletSymbol": walletSymbol,
        "walletType": walletType,
        "withdrawMax": withdrawMax,
        "withdrawMaxDay": withdrawMaxDay,
        "withdrawMaxDayNoAuth": withdrawMaxDayNoAuth,
        "withdrawMin": withdrawMin,
        "withdrawOpen": withdrawOpen,
      };
}
