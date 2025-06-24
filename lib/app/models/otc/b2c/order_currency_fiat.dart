import 'dart:convert';

import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

class B2CCurrencyModel {
  String? currency;
  num maxBuyAmount = 0;
  num minBuyAmount = 0;
  String? symbol;
  String? icon;
  String? code;
  num? precision;
  String? name;
  num rate = 1;

  B2CCurrencyModel({this.currency, this.maxBuyAmount = 0, this.minBuyAmount = 0, this.symbol, this.icon, this.code});

  B2CCurrencyModel.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    maxBuyAmount = num.parse(json['payMax'] ?? '0');
    minBuyAmount = num.parse(json['payMin'] ?? '0');
    symbol = json['symbol'];
    icon = json['icon'];
    code = json['payWayCode'];
    precision = json['precision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currency'] = currency;
    data['payMax'] = maxBuyAmount;
    data['payMin'] = minBuyAmount;
    data['symbol'] = symbol;
    data['icon'] = icon;
    data['payWayCode'] = code;
    data['precision'] = precision;

    return data;
  }

  int get precisionInt => precision == null ? 2 : precision!.toInt();
}

class B2CCryptoModel {
  String? crypto;
  String? network;
  num? buyEnable;
  num? sellEnable;
  num minPurchaseAmount = 0;
  num maxPurchaseAmount = 0;
  String? icon;
  num minSellAmount = 0;
  num maxSellAmount = 0;
  num? precision;

  String? code;

  B2CCryptoModel(
      {this.crypto,
      this.network,
      this.buyEnable,
      this.sellEnable,
      this.minPurchaseAmount = 0,
      this.maxPurchaseAmount = 0,
      this.icon,
      this.minSellAmount = 0,
      this.maxSellAmount = 0,
      this.precision});

  B2CCryptoModel.fromJson(Map<String, dynamic> json) {
    crypto = json['crypto'];
    network = json['network'];
    buyEnable = json['buyEnable'];
    sellEnable = json['sellEnable'];
    minPurchaseAmount = num.parse((json['minPurchaseAmount'] ?? '0'));
    maxPurchaseAmount = num.parse((json['maxPurchaseAmount'] ?? '0'));
    icon = json['icon'];
    minSellAmount = num.parse((json['minSellAmount'] ?? '0'));
    maxSellAmount = num.parse((json['maxSellAmount'] ?? '0'));
    precision = json['precision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['crypto'] = crypto;
    data['network'] = network;
    data['buyEnable'] = buyEnable;
    data['sellEnable'] = sellEnable;
    data['minPurchaseAmount'] = minPurchaseAmount;
    data['maxPurchaseAmount'] = maxPurchaseAmount;
    data['icon'] = icon;
    data['minSellAmount'] = minSellAmount;
    data['maxSellAmount'] = maxSellAmount;
    data['precision'] = precision;
    return data;
  }

  num get minBuyAmount => minSellAmount;
  num get maxBuyAmount => maxSellAmount;

  int get precisionInt => precision == null ? 2 : precision!.toInt();
}

class B2CChannelModel {
  String? channelName;
  String? icon;
  List<PayTypeList>? payTypeList;
  int selectIndex = 0;

  B2CChannelModel({this.channelName, this.icon, this.payTypeList});

  B2CChannelModel.fromJson(Map<String, dynamic> json) {
    channelName = json['channelName'];
    icon = json['icon'];
    if (json['payTypeList'] != null) {
      payTypeList = <PayTypeList>[];
      json['payTypeList'].forEach((v) {
        payTypeList!.add(PayTypeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['channelName'] = channelName;
    data['icon'] = icon;
    if (payTypeList != null) {
      data['payTypeList'] = payTypeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  num get minBuyAmount => payTypeList?.isNotEmpty == true ? payTypeList![selectIndex].minBuyAmount : 10000;
  num get maxBuyAmount => payTypeList?.isNotEmpty == true ? payTypeList![selectIndex].maxBuyAmount : 10000;
}

class PayTypeList {
  String? payWayName;
  num? payWayCode;
  String? icon;
  String? fiatAmount;
  String? fiatCode;

  num rate = 1;

  num minBuyAmount = 0;
  num maxBuyAmount = 0;

  PayTypeList({this.payWayName, this.payWayCode, this.icon, this.fiatAmount});

  PayTypeList.fromJson(Map<String, dynamic> json) {
    payWayName = json['payWayName'];
    payWayCode = json['payWayCode'];
    icon = json['icon'];
    fiatAmount = json['fiatAmount'];
    fiatCode = json['fiatCode'];
    rate = num.parse(json['rate'] ?? '1');
    minBuyAmount = num.parse(json['minPurchaseAmount'] ?? '0');
    maxBuyAmount = num.parse(json['maxPurchaseAmount'] ?? '0');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['payWayName'] = payWayName;
    data['payWayCode'] = payWayCode;
    data['icon'] = icon;
    data['fiatAmount'] = fiatAmount;
    data['fiatCode'] = fiatCode;
    data['rate'] = rate;
    data['minPurchaseAmount'] = minBuyAmount;
    data['maxPurchaseAmount'] = maxBuyAmount;

    return data;
  }

  String get iconUrl {
    if (payWayCode == 10001) {
      return 'otc/b2c/b2c_visa'.svgAssets();
    } else if (payWayCode == 501) {
      return 'otc/b2c/b2c_applePay'.svgAssets();
    } else if (payWayCode == 701) {
      return 'otc/b2c/b2c_googlePay'.svgAssets();
    } else {
      return 'otc/b2c/b2c_bank'.svgAssets();
    }
  }
}
