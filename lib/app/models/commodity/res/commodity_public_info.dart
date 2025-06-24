// To parse this JSON data, do
//
//     final commodityPublicInfo = commodityPublicInfoFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

CommodityPublicInfo commodityPublicInfoFromJson(String str) => CommodityPublicInfo.fromJson(json.decode(str));

String commodityPublicInfoToJson(CommodityPublicInfo data) => json.encode(data.toJson());

class CommodityPublicInfo {
  String? wsUrl;
  List<String>? marginCoinList;
  int currentTimeMillis;
  List<String>? originalCoinList;
  List<ContractGroupList>? contractGroupList;
  List<LangInfo>? langList;
  String? contractProInfo;

  CommodityPublicInfo({
    this.wsUrl,
    this.marginCoinList,
    required this.currentTimeMillis,
    this.originalCoinList,
    this.contractGroupList,
    this.langList,
    this.contractProInfo,
  });

  factory CommodityPublicInfo.fromJson(Map<String, dynamic> json) => CommodityPublicInfo(
        wsUrl: json["wsUrl"],
        marginCoinList: json["marginCoinList"] == null ? [] : List<String>.from(json["marginCoinList"]!.map((x) => x)),
        currentTimeMillis: json["currentTimeMillis"],
        originalCoinList: json["originalCoinList"] == null ? [] : List<String>.from(json["originalCoinList"]!.map((x) => x)),
        contractGroupList: json["contractGroupList"] == null
            ? []
            : List<ContractGroupList>.from(json["contractGroupList"]!.map((x) => ContractGroupList.fromJson(x))),
        langList: json["langList"] == null ? [] : List<LangInfo>.from(json["langList"]!.map((x) => LangInfo.fromJson(x))),
        contractProInfo: json["contractProInfo"],
      );

  Map<String, dynamic> toJson() => {
        "wsUrl": wsUrl,
        "marginCoinList": marginCoinList == null ? [] : List<dynamic>.from(marginCoinList!.map((x) => x)),
        "currentTimeMillis": currentTimeMillis,
        "originalCoinList": originalCoinList == null ? [] : List<dynamic>.from(originalCoinList!.map((x) => x)),
        "contractGroupList": contractGroupList == null ? [] : List<dynamic>.from(contractGroupList!.map((x) => x.toJson())),
        "langList": langList == null ? [] : List<dynamic>.from(langList!.map((x) => x.toJson())),
        "contractProInfo": contractProInfo,
      };
}

class ContractGroupList {
  List<ContractInfo>? contractList;
  String? kind; // 1 股票 2 ETF 3 外汇 4大宗 5 贵金属
  String? kindName;

  int get kindInt {
    return kind?.replaceAll('B_', '').toInt() ?? 0;
  }

  /// B_0 数字货币，B_1 股票，B_2 指数 ,B_3 外汇,B_4 大宗 B_5. ETF
  String get kindNameStr {
    switch (kind) {
      case 'B_0':
        return LocaleKeys.markets32.tr;
      case 'B_1':
        return LocaleKeys.follow116.tr;
      case 'B_2':
        return LocaleKeys.markets12.tr;
      case 'B_3':
        return LocaleKeys.markets13.tr;
      case 'B_4':
        return LocaleKeys.markets14.tr;
      case 'B_5':
        return 'ETF';
      default:
        return LocaleKeys.public35.tr;
    }
  }

  ContractGroupList({
    this.contractList,
    this.kind,
    this.kindName,
  });

  factory ContractGroupList.fromJson(Map<String, dynamic> json) => ContractGroupList(
        contractList: json["contractList"] == null
            ? []
            : List<ContractInfo>.from(json["contractList"]!.map((x) => ContractInfo.fromJson(x))),
        kind: json["kind"],
        kindName: json["kindName"],
      );

  Map<String, dynamic> toJson() => {
        "contractList": contractList == null ? [] : List<dynamic>.from(contractList!.map((x) => x.toJson())),
        "kind": kind,
        "kindName": kindName,
      };
}
