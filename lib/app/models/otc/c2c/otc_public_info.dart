// To parse this JSON data, do
//
//     final otcPublicInfo = otcPublicInfoFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_apply_info.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

OtcPublicInfo otcPublicInfoFromJson(String str) => OtcPublicInfo.fromJson(json.decode(str));

String otcPublicInfoToJson(OtcPublicInfo data) => json.encode(data.toJson());

class OtcPublicInfo {
  String? rateUrl;
  String? otcOrderCancelMaxNum;
  List<CountryNumberInfo>? payments;
  List<CountryNumberInfo>? countryNumberInfo;
  List<FeeOtcList>? feeOtcList;
  String? otcDefaultPaycoin;
  List<CountryNumberInfo>? paycoins;
  String? otcChatWs;
  String? defaultCoin;
  String? defaultSeach;
  String? windControlSwitch;
  bool? otcSwitch;
  List<ApplyMerchantModel>? applyMerchantTypeConfig;

  OtcPublicInfo(
      {this.rateUrl,
      this.otcOrderCancelMaxNum,
      this.payments,
      this.countryNumberInfo,
      this.feeOtcList,
      this.otcDefaultPaycoin,
      this.paycoins,
      this.otcChatWs,
      this.defaultCoin,
      this.defaultSeach,
      this.windControlSwitch,
      this.otcSwitch,
      this.applyMerchantTypeConfig});

  factory OtcPublicInfo.fromJson(Map<String, dynamic> json) => OtcPublicInfo(
        rateUrl: json["rateUrl"],
        otcOrderCancelMaxNum: json["otc_order_cancel_max_num"],
        payments: json["payments"] == null
            ? []
            : List<CountryNumberInfo>.from(json["payments"]!.map((x) => CountryNumberInfo.fromJson(x))),
        countryNumberInfo: json["countryNumberInfo"] == null
            ? []
            : List<CountryNumberInfo>.from(json["countryNumberInfo"]!.map((x) => CountryNumberInfo.fromJson(x))),
        feeOtcList:
            json["feeOtcList"] == null ? [] : List<FeeOtcList>.from(json["feeOtcList"]!.map((x) => FeeOtcList.fromJson(x))),
        otcDefaultPaycoin: json["otcDefaultPaycoin"],
        paycoins: json["paycoins"] == null
            ? []
            : List<CountryNumberInfo>.from(json["paycoins"]!.map((x) => CountryNumberInfo.fromJson(x))),
        otcChatWs: json["otcChatWS"],
        defaultCoin: json["defaultCoin"],
        defaultSeach: json["defaultSeach"],
        windControlSwitch: json["wind_control_switch"],
        otcSwitch: json["otcSwitch"],

        applyMerchantTypeConfig: json["applyMerchantTypeConfig"] == null
            ? []
            : List<ApplyMerchantModel>.from(json["applyMerchantTypeConfig"]!.map((x) => ApplyMerchantModel.fromJson(x))),
        //         if (json['applyMerchantTypeConfig'] != null) {
        //   applyMerchantTypeConfig = <ApplyMerchantTypeConfig>[];
        //   json['applyMerchantTypeConfig'].forEach((v) {
        //     applyMerchantTypeConfig!.add(new ApplyMerchantTypeConfig.fromJson(v));
        //   });
        // }
      );

  Map<String, dynamic> toJson() => {
        "rateUrl": rateUrl,
        "otc_order_cancel_max_num": otcOrderCancelMaxNum,
        "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x.toJson())),
        "countryNumberInfo": countryNumberInfo == null ? [] : List<dynamic>.from(countryNumberInfo!.map((x) => x.toJson())),
        "feeOtcList": feeOtcList == null ? [] : List<dynamic>.from(feeOtcList!.map((x) => x.toJson())),
        "otcDefaultPaycoin": otcDefaultPaycoin,
        "paycoins": paycoins == null ? [] : List<dynamic>.from(paycoins!.map((x) => x.toJson())),
        "otcChatWS": otcChatWs,
        "defaultCoin": defaultCoin,
        "defaultSeach": defaultSeach,
        "wind_control_switch": windControlSwitch,
        "otcSwitch": otcSwitch,
        "applyMerchantTypeConfig":
            applyMerchantTypeConfig == null ? [] : List<dynamic>.from(applyMerchantTypeConfig!.map((x) => x.toJson())),
      };

  bool get haveC2C => otcSwitch == true ? true : false;
}

class CountryNumberInfo {
  String? key;
  String? title;
  String? icon;
  dynamic account;
  bool? used;
  String? numberCode;
  bool? open;
  int? scaleLength;

  CountryNumberInfo({
    this.key,
    this.title,
    this.icon,
    this.account,
    this.used,
    this.numberCode,
    this.open,
    this.scaleLength,
  });

  factory CountryNumberInfo.fromJson(Map<String, dynamic> json) => CountryNumberInfo(
      key: json["key"],
      title: json["title"],
      icon: json["icon"],
      account: json["account"],
      used: json["used"],
      numberCode: json["numberCode"],
      open: json["open"],
      scaleLength: json['scaleLength']);

  Map<String, dynamic> toJson() => {
        "key": key,
        "title": title,
        "icon": icon,
        "account": account,
        "used": used,
        "scaleLength": scaleLength,
        "numberCode": numberCode,
        "open": open,
      };
}

class FeeOtcList {
  String? symbol;
  double? rate;

  FeeOtcList({
    this.symbol,
    this.rate,
  });

  factory FeeOtcList.fromJson(Map<String, dynamic> json) => FeeOtcList(
        symbol: json["symbol"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "rate": rate,
      };
}

class ApplyMerchantModel with PagingModel {
  String merchantName = '';
  num merchantMarginAmount = 0;
  num merchantType = 0;
  num orderCount = 0;
  num orderLimit = 0;

  String title = '';
  String des = '';
  List<MerchantModel> desList = [];
  String buttonTitle = '';
  String tipTitle = '';
  String imageStr = '';
  String rowTitle = '';
  String amountStr = '';

  ApplyMerchantModel(
      {this.merchantMarginAmount = 0, this.merchantType = 0, this.merchantName = '', this.orderCount = 0, this.orderLimit = 0});

  ApplyMerchantModel.fromJson(Map<String, dynamic> json) {
    merchantMarginAmount = num.parse(json['merchantMarginAmount'] ?? '0');
    merchantName = json['merchantName'] ?? '';
    merchantType = json['merchantType'] ?? 0;
    orderCount = json['orderCount'] ?? 0;
    orderLimit = json['orderLimit'] ?? 0;
    setData();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['merchantMarginAmount'] = merchantMarginAmount;
    data['merchantType'] = merchantType;
    data['merchantName'] = merchantName;
    data['orderCount'] = orderCount;
    data['orderLimit'] = orderLimit;

    return data;
  }

  setData() {
    switch (merchantType) {
      case 0:
        title = getMerchantType(merchantType);
        des = '${LocaleKeys.c2c332.tr}$title${LocaleKeys.c2c333.tr}';
        rowTitle = title;
        amountStr = '1,000 USDT';
        desList = [
          MerchantModel(first: LocaleKeys.c2c334.tr),
          MerchantModel(first: LocaleKeys.c2c335.tr, last: '${getmConvert(orderLimit, pricePrecision: 0)} USDT'),
          MerchantModel(first: LocaleKeys.c2c336.tr, last: '$orderCount ${LocaleKeys.c2c337.tr}'),
          MerchantModel(first: LocaleKeys.c2c338.tr),
        ];
        break;
      case 1:
        title = getMerchantType(merchantType);
        des = '${LocaleKeys.c2c332.tr}$title${LocaleKeys.c2c333.tr}';

        rowTitle = LocaleKeys.c2c327.tr;

        amountStr = '6,000 USDT';

        desList = [
          MerchantModel(first: LocaleKeys.c2c334.tr),
          MerchantModel(first: LocaleKeys.c2c335.tr, last: '${getmConvert(orderLimit, pricePrecision: 0)} USDT'),
          MerchantModel(first: LocaleKeys.c2c336.tr, last: '$orderCount ${LocaleKeys.c2c337.tr}'),
          MerchantModel(first: LocaleKeys.c2c338.tr),
          MerchantModel(first: LocaleKeys.c2c339.tr)
        ];
        break;
      case 2:
        title = getMerchantType(merchantType);
        des = '${LocaleKeys.c2c332.tr}$title${LocaleKeys.c2c333.tr}';

        rowTitle = LocaleKeys.c2c328.tr;

        amountStr = '24,000 USDT';

        desList = [
          MerchantModel(first: LocaleKeys.c2c334.tr),
          MerchantModel(first: LocaleKeys.c2c335.tr, last: '${getmConvert(orderLimit, pricePrecision: 0)} USDT'),
          MerchantModel(first: LocaleKeys.c2c336.tr, last: '$orderCount ${LocaleKeys.c2c337.tr}'),
          MerchantModel(first: LocaleKeys.c2c338.tr),
          MerchantModel(first: LocaleKeys.c2c339.tr)
        ];
        break;
      case 3:
        title = getMerchantType(merchantType);
        des = '${LocaleKeys.c2c332.tr}$title${LocaleKeys.c2c333.tr}';

        rowTitle = LocaleKeys.c2c329.tr;

        amountStr = '65,000 USDT';

        desList = [
          MerchantModel(first: LocaleKeys.c2c334.tr),
          MerchantModel(first: LocaleKeys.c2c335.tr, last: '${getmConvert(orderLimit, pricePrecision: 0)} USDT'),
          MerchantModel(first: LocaleKeys.c2c336.tr, last: '$orderCount ${LocaleKeys.c2c337.tr}'),
          MerchantModel(first: LocaleKeys.c2c338.tr),
          MerchantModel(first: LocaleKeys.c2c339.tr)
        ];
        break;
      case 4:
        title = getMerchantType(merchantType);
        des = '${LocaleKeys.c2c332.tr}$title${LocaleKeys.c2c333.tr}';

        rowTitle = LocaleKeys.c2c330.tr;
        amountStr = '130,000 USDT';

        desList = [
          MerchantModel(first: LocaleKeys.c2c334.tr),
          MerchantModel(first: LocaleKeys.c2c335.tr, last: '${getmConvert(orderLimit, pricePrecision: 0)} USDT'),
          MerchantModel(first: LocaleKeys.c2c336.tr, last: '$orderCount ${LocaleKeys.c2c337.tr}'),
          MerchantModel(first: LocaleKeys.c2c338.tr),
          MerchantModel(first: LocaleKeys.c2c339.tr)
        ];
        break;
      default:
    }
  }

  getButtonState(OTCApplyStatus? state, {String? amount, int? merchantType}) {
    if (state != null) {
      switch (state) {
        case OTCApplyStatus.fillForm:
          buttonTitle = '${LocaleKeys.c2c360.tr}$title';
          tipTitle = getmConvert(merchantMarginAmount, pricePrecision: 0);
          break;

        case OTCApplyStatus.payDeposit:
          buttonTitle = LocaleKeys.c2c366.tr;
          tipTitle = amount ?? '0';
          break;

        case OTCApplyStatus.verifying:
          buttonTitle = LocaleKeys.c2c362.tr;
          tipTitle = LocaleKeys.c2c361.tr;
          break;

        case OTCApplyStatus.revoking:
          buttonTitle = LocaleKeys.c2c362.tr;
          tipTitle = LocaleKeys.c2c378.tr;
          break;

        case OTCApplyStatus.verifySucces:
          buttonTitle = LocaleKeys.c2c365.tr;
          tipTitle = LocaleKeys.c2c363.tr + getMerchantType(merchantType ?? 0);
          imageStr = 'otc/c2c/c2c_merchant_star_${merchantType ?? 0}';
          break;
        default:
      }
    }
  }

  String getMerchantType(num type) {
    switch (type) {
      case 0:
        return '${LocaleKeys.c2c326.tr}${LocaleKeys.c2c331.tr}';

      case 1:
        return '${LocaleKeys.c2c327.tr}${LocaleKeys.c2c331.tr}';

      case 2:
        return '${LocaleKeys.c2c328.tr}${LocaleKeys.c2c331.tr}';

      case 3:
        return '${LocaleKeys.c2c329.tr}${LocaleKeys.c2c331.tr}';

      case 4:
        return '${LocaleKeys.c2c330.tr}${LocaleKeys.c2c331.tr}';

      default:
        return '';
    }
  }
}

class MerchantModel {
  String first = '';
  String last = '';
  MerchantModel({this.first = '', this.last = ''});
}
