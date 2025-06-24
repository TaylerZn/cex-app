// To parse this JSON data, do
//
//     final orderRes = orderResFromJson(jsonString);

import 'dart:math';

import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_model.dart';

class OrderRes with PagingModel, PagingError {
  num current;
  num total;
  List<OrderInfo> data;
  num size;

  OrderRes({
    required this.current,
    required this.total,
    required this.data,
    required this.size,
  });

  factory OrderRes.fromJson(Map<String, dynamic> json) => OrderRes(
        current: json["current"],
        total: json["total"],
        data: List<OrderInfo>.from(json["data"].map((x) => OrderInfo.fromJson(x))),
        size: json["size"],
      );
}

class OrderInfo with transactionMixin, PagingModel {
  String symbol;
  num pricePrecision;
  String contractOtherName;
  String side; // BUY/SELL
  num positionType; // 1:全仓 2:逐仓
  num avgPrice;
  num tradeFee;
  num memo;
  num type; // 1 止损 2 止盈
  dynamic mtime;
  num volume;
  String liqPositionMsg;
  num dealVolume;
  num price;
  num contractId;
  num ctime;
  String contractName;
  String id;
  String open; // OPEN/CLOSE
  // 0 初始化订单
  // 1 新建订单，进入撮合
  // 2 完全成交
  // 3 部分成交
  // 4 已撤单
  // 5 待撤单
  // 6 异常订单
  // 查询历史订单[2,4,6]
  // 查询当前委托[0,1,3,5]
  num status;
  num orderType; // 1 limit 2 market
  double? triggerPrice; // 触发价格
  int expireTime; // 过期时间
  int triggerType; // 条件单类型 1 stop loss 2 take profit 3 open buy 4 open sell
  int timeInForce; // 1 limit 2 market 3 ioc 4 fok 5 post only
  bool gt;

  // 止盈触发价格
  num? tpTriggerPrice;

  // 止损触发价格
  num? slTriggerPrice;

  double get percent => (dealVolume / max(1, volume)).toDouble();

  OrderInfo({
    required this.symbol,
    required this.pricePrecision,
    required this.contractOtherName,
    required this.side,
    required this.positionType,
    required this.avgPrice,
    required this.tradeFee,
    required this.memo,
    required this.type,
    required this.mtime,
    required this.volume,
    required this.liqPositionMsg,
    required this.dealVolume,
    required this.price,
    required this.contractId,
    required this.ctime,
    required this.contractName,
    required this.id,
    required this.open,
    required this.status,
    required this.orderType,
    required this.triggerPrice,
    required this.expireTime,
    required this.triggerType,
    required this.timeInForce,
    required this.gt,
    this.tpTriggerPrice,
    this.slTriggerPrice,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        symbol: json["symbol"] ?? "",
        pricePrecision: json["pricePrecision"] ?? 0,
        contractOtherName: json["contractOtherName"] ?? "",
        side: json["side"] ?? "",
        positionType: json["positionType"] ?? 0,
        avgPrice: json["avgPrice"] ?? 0,
        tradeFee: json["tradeFee"] ?? 0,
        memo: json["memo"] ?? 0,
        type: json["type"] ?? 0,
        mtime: json["mtime"],
        volume: json["volume"] ?? 0,
        liqPositionMsg: json["liqPositionMsg"] ?? "",
        dealVolume: json["dealVolume"] ?? 0,
        price: json["price"] ?? 0,
        contractId: json["contractId"] ?? 0,
        ctime: json["ctime"] ?? 0,
        contractName: json["contractName"] ?? "",
        id: json["id"] ?? "",
        open: json["open"] ?? "",
        status: json["status"] ?? 0,
        orderType: json["orderType"] ?? 0,
        triggerPrice: json["triggerPrice"] ?? 0,
        expireTime: 0,
        triggerType: json["triggerType"] ?? 0,
        timeInForce: json["timeInForce"] ?? 0,
        gt: json["gt"] ?? false,
        tpTriggerPrice: json["tpTriggerPrice"],
        slTriggerPrice: json["slTriggerPrice"],
      );
}
