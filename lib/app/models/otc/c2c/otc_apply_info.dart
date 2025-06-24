// To parse this JSON data, do
//
//     final otcApplyInfo = otcApplyInfoFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

OtcApplyInfo otcApplyInfoFromJson(String str) => OtcApplyInfo.fromJson(json.decode(str));

String otcApplyInfoToJson(OtcApplyInfo data) => json.encode(data.toJson());

enum OTCApplyStatus {
  fillForm,
  payDeposit,
  verifying,
  revoking,
  verifySucces;

  const OTCApplyStatus();
  String get title {
    switch (this) {
      case fillForm:
        return LocaleKeys.c2c72.tr;
      case payDeposit:
        return LocaleKeys.c2c80.tr;
      case verifying:
        return LocaleKeys.c2c74.tr;
      case revoking:
        return LocaleKeys.c2c74.tr;
      case verifySucces:
        return LocaleKeys.c2c85.tr;
    }
  }
}

class OtcApplyInfo with PagingModel {
  num? amount;
  String? coinSymbol;
  int? applyStatus;
  int? marginStatus;
  double? balance;

  int? merchantType;
  String? merchantName;

  OtcApplyInfo(
      {this.amount, this.coinSymbol, this.marginStatus, this.applyStatus, this.balance, this.merchantType, this.merchantName});

  factory OtcApplyInfo.fromJson(Map<String, dynamic> json) => OtcApplyInfo(
        amount: json["amount"],
        balance: json['balance'],
        coinSymbol: json["coinSymbol"],
        applyStatus: json["applyStatus"],
        marginStatus: json['marginStatus'],
        merchantType: json['merchantType'],
        merchantName: json['merchantName'],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        'balance': balance,
        "coinSymbol": coinSymbol,
        "applyStatus": applyStatus,
        "marginStatus": marginStatus,
        'merchantType': merchantType,
        'merchantName': merchantName,
      };

  bool get enoughBalance => (balance ?? 0) >= (amount ?? 0);
  bool get formFilled => applyStatus == 1 || applyStatus == 3;
  bool get depositPayed => marginStatus == 1;
  bool get readyPay => formFilled && marginStatus == 0;
  String buttonText() {
    return '待审核';
  }

  String get amountStr => getmConvert(amount, pricePrecision: 0);

  OTCApplyStatus get otcStatus {
    if (applyStatus == 0) {
      return OTCApplyStatus.fillForm;
    }
    if (applyStatus == 1 && marginStatus == 0) {
      return OTCApplyStatus.payDeposit;
    }
    if (applyStatus == 1 && marginStatus == 1) {
      return OTCApplyStatus.verifying;
    }
    if (applyStatus == 3) {
      if (marginStatus == 0) {
        return OTCApplyStatus.revoking;
      }
      return OTCApplyStatus.verifySucces;
    }
    return OTCApplyStatus.fillForm;
  }
}
