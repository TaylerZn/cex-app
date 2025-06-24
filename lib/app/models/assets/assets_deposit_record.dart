// To parse this JSON data, do
//
//     final assetsDepositRecord = assetsDepositRecordFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_utils/get_utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AssetsHistoryRecord {
  List<AssetsHistoryRecordItem>? financeList;
  int? count;
  int? pageSize;

  AssetsHistoryRecord({
    this.financeList,
    this.count,
    this.pageSize,
  });

  factory AssetsHistoryRecord.fromRawJson(String str) => AssetsHistoryRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetsHistoryRecord.fromJson(Map<String, dynamic> json) => AssetsHistoryRecord(
        financeList: json["financeList"] == null
            ? []
            : List<AssetsHistoryRecordItem>.from(json["financeList"]!.map((x) => AssetsHistoryRecordItem.fromJson(x))),
        count: json["count"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "financeList": financeList == null ? [] : List<dynamic>.from(financeList!.map((x) => x.toJson())),
        "count": count,
        "pageSize": pageSize,
      };
}

class AssetsHistoryRecordItem {
  dynamic amount;
  dynamic fee;
  dynamic icon;
  dynamic txid;
  dynamic updateTime;
  dynamic label;
  dynamic mainnet;
  dynamic addressTo;
  dynamic walletTime;
  dynamic coinSymbol;
  String? createTime;
  dynamic updateAtTime;
  dynamic createdAtTime;
  dynamic id;
  String? statusText;
  String? transferType;
  dynamic account;
  dynamic status;
  String? scene;
  String? sceneText;

  String? type;
  num? accountType;

  AssetsHistoryRecordItem(
      {this.amount,
      this.fee,
      this.icon,
      this.txid,
      this.updateTime,
      this.label,
      this.mainnet,
      this.addressTo,
      this.walletTime,
      this.coinSymbol,
      this.createTime,
      this.updateAtTime,
      this.createdAtTime,
      this.id,
      this.statusText,
      this.transferType,
      this.account,
      this.status,
      this.scene,
      this.sceneText,
      this.type,
      this.accountType});

  AssetsHistoryRecordItem.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    fee = json['fee'];
    icon = json['icon'];
    txid = json['txid'];
    updateTime = json['updateTime'];
    label = json['label'];
    mainnet = json['mainnet'];
    addressTo = json['addressTo'];
    walletTime = json['walletTime'];
    coinSymbol = json['coinSymbol'];
    createTime = json['createTime'];
    updateAtTime = json['updateAtTime'];
    createdAtTime = json['createdAtTime'];
    id = json['id'];
    statusText = json['status_text'];
    transferType = json['transferType'];

    account = json['account'];
    status = json['status'];
    scene = json['scene'];
    sceneText = json['sceneText'];
    type = json['type'];
    accountType = json['accountType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = amount;
    data['fee'] = fee;
    data['icon'] = icon;
    data['txid'] = txid;
    data['updateTime'] = updateTime;
    data['label'] = label;
    data['mainnet'] = mainnet;
    data['addressTo'] = addressTo;
    data['walletTime'] = walletTime;
    data['coinSymbol'] = coinSymbol;
    data['createTime'] = createTime;
    data['updateAtTime'] = updateAtTime;
    data['createdAtTime'] = createdAtTime;
    data['id'] = id;
    data['status_text'] = statusText;
    data['transferType'] = transferType;
    data['account'] = account;
    data['status'] = status;
    data['scene'] = scene;
    data['sceneText'] = sceneText;
    data['type'] = type;
    data['accountType'] = accountType;

    return data;
  }

  //TODO: 待后台的统一
  String get statusTextMapping {
    if (accountType != null) {
      switch (accountType) {
        case 0:
          return LocaleKeys.assets137.tr; //'永续合约账户'or '永续合约账户';
        case 1:
          return LocaleKeys.assets75.tr; //'标准合约账户';
        case 2:
          return LocaleKeys.follow72.tr; //'跟单账户';
        default:
          return '';
      }
    } else {
      switch (statusText) {
        case 'wallet':
          return LocaleKeys.assets58.tr; //资金账户
        case 'contract':
          return LocaleKeys.assets137.tr; //'永续合约账户'or '永续合约账户';
        case 'follow':
          return LocaleKeys.follow72.tr; //'跟单账户';
        case 'standard':
          return LocaleKeys.assets75.tr; //'标准合约账户';
        default:
          return statusText ?? '';
      }
    }
  }

  String get bonusType {
    if (type != null) {
      switch (type) {
        case 0:
          return '赠金发放'.tr;
        case 1:
          return '体验金发放'.tr;
        case 2:
          return '体验金回收'.tr;
        default:
          return '';
      }
    } else {
      return '';
    }
  }
}
