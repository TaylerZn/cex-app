import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class TransactionHistoricalTrans extends TransactionBaseModel {
  TransactionHistoricalTrans();
  TransactionHistoricalTrans.fromJson(Map<String, dynamic> json) {
    orderList = <TransactionHistoricalTransModel>[];
    count = json['count'];
    if (json['tradeHisList'] != null) {
      json['tradeHisList'].forEach((v) {
        orderList!.add(TransactionHistoricalTransModel.fromJson(v));
      });
      orderList!.sort((a, b) => b.ctime.compareTo(a.ctime));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['tradeHisList'] = orderList != null ? orderList!.map((v) => v.toJson()).toList() : [];
    return data;
  }
}

class TransactionHistoricalTransModel with transactionMixin, PagingModel {
  String symbol = '';
  num pricePrecision = 0;
  String? contractOtherName;
  String side = '';
  String role = '';
  num fee = 0;
  num feeCoinPrecision = 0;
  num realizedAmount = 0;
  num? volume;
  String? feeCoin;
  String? quote;
  num price = 0;
  num? contractId;
  num ctime = 0;
  String? contractName;
  String? id;
  String open = '';
  String? base;

  TransactionHistoricalTransModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'] ?? '';
    pricePrecision = json['pricePrecision'] ?? 0;
    contractOtherName = json['contractOtherName'];
    side = json['side'] ?? '';
    role = json['role'] ?? '';
    fee = json['fee'] ?? 0;
    feeCoinPrecision = json['feeCoinPrecision'] ?? 0;
    volume = json['volume'];
    feeCoin = json['feeCoin'];
    quote = json['quote'];
    price = json['price'] ?? 0;
    contractId = json['contractId'];
    ctime = json['ctime'] ?? 0;
    contractName = json['contractName'];
    id = json['id'];
    open = json['open'] ?? '';
    base = json['base'];
    realizedAmount = json['realizedAmount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['pricePrecision'] = pricePrecision;
    data['contractOtherName'] = contractOtherName;
    data['side'] = side;
    data['role'] = role;
    data['fee'] = fee;
    data['feeCoinPrecision'] = feeCoinPrecision;
    data['volume'] = volume;
    data['feeCoin'] = feeCoin;
    data['quote'] = quote;
    data['price'] = price;
    data['contractId'] = contractId;
    data['ctime'] = ctime;
    data['contractName'] = contractName;
    data['id'] = id;
    data['open'] = open;
    data['base'] = base;
    data['realizedAmount'] = realizedAmount;
    return data;
  }

  String get openSide => getOpenSide(open, side);
  Color get sideColor => getmColor((side == 'SELL' ? -1 : 0));

  String get name => '$contractOtherName ${LocaleKeys.trade7.tr}';
  String get time => DateUtil.formatDateMs(ctime.toInt());
  String get priceStr => getmConvert(price, pricePrecision: pricePrecision.toInt());
  String get feeStr => fee.toStringAsFixed(feeCoinPrecision.toInt());
  String get volumeStr => volume != null ? volume!.toString() : '--';
  String get realizedAmountStr => realizedAmount.toString();
  Color get realizedAmountColor => getmColor(realizedAmount);
  String get type => symbol.contains('-') == true ? symbol.split('-').first : '';
}
