import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../utils/utilities/number_util.dart';

class TransactionHistoryEntrust extends TransactionBaseModel {
  TransactionHistoryEntrust();
  TransactionHistoryEntrust.fromJson(Map<String, dynamic> json) {
    orderList = <TransactionHistoryEntrustModel>[];
    count = json['count'];
    if (json['orderList'] != null) {
      json['orderList'].forEach((v) {
        orderList!.add(TransactionHistoryEntrustModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['orderList'] = orderList != null ? orderList!.map((v) => v.toJson()).toList() : [];
    return data;
  }
}

class TransactionHistoryEntrustModel with transactionMixin {
  String symbol = '';
  num orderType = 1;
  num type = 1;

  String contractOtherName = '';
  num? positionType;
  num avgPrice = 0;
  num pricePrecision = 0;

  num? tradeFee;
  num? realizedAmount;
  num? memo;
  num? source;
  String? quote;
  String? liqPositionMsg;
  num? dealVolume;
  num? price;
  num ctime = 0;
  num? contractName;
  String? id;
  String side = '';
  num? volume;
  num? contractId;
  num? orderBalance;
  String open = '';
  num status = 0;
  String? base;

  String getmConvert(String str) {
    return NumberUtil.mConvert(str);
  }

  Color getmColor(num number) {
    return number > 0 ? AppColor.upColor : AppColor.downColor;
  }

  TransactionHistoryEntrustModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'] ?? '';
    orderType = json['orderType'] ?? 1;
    type = json['type'] ?? 1;
    contractOtherName = json['contractOtherName'] ?? '';
    positionType = json['positionType'];
    avgPrice = json['avgPrice'] ?? 0;
    pricePrecision = json['pricePrecision'] ?? 0;

    tradeFee = json['tradeFee'];
    realizedAmount = json['realizedAmount'];
    memo = json['memo'];
    source = json['source'];
    quote = json['quote'];
    liqPositionMsg = json['liqPositionMsg'];
    dealVolume = json['dealVolume'];
    price = json['price'];
    ctime = json['ctime'] ?? 0;
    contractName = json['contractName'];
    id = json['id'];
    side = json['side'] ?? '';
    volume = json['volume'];
    contractId = json['contractId'];
    orderBalance = json['orderBalance'];
    open = json['open'] ?? '';
    status = json['status'] ?? 0;
    base = json['base'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['orderType'] = orderType;
    data['contractOtherName'] = contractOtherName;
    data['positionType'] = positionType;
    data['avgPrice'] = avgPrice;
    data['tradeFee'] = tradeFee;
    data['realizedAmount'] = realizedAmount;
    data['memo'] = memo;
    data['source'] = source;
    data['type'] = type;
    data['quote'] = quote;
    data['liqPositionMsg'] = liqPositionMsg;
    data['dealVolume'] = dealVolume;
    data['price'] = price;
    data['ctime'] = ctime;
    data['contractName'] = contractName;
    data['id'] = id;
    data['pricePrecision'] = pricePrecision;
    data['side'] = side;
    data['volume'] = volume;
    data['contractId'] = contractId;
    data['orderBalance'] = orderBalance;
    data['open'] = open;
    data['status'] = status;
    data['base'] = base;
    return data;
  }

  Color get sideColor => side == 'SELL' ? AppColor.colorDanger : AppColor.colorSuccess;

  String get name => '$contractOtherName ${LocaleKeys.trade7.tr}';
  String get time => DateUtil.formatDateMs(ctime.toInt());
  String get priceStr => avgPrice.toStringAsFixed(pricePrecision.toInt());
  List<String> get tagArray => [getOrderType(orderType), getOpenSide(open, side)];
  String get statusStr => getStatusStr(status);
}
