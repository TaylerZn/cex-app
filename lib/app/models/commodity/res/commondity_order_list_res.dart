
// To parse this JSON data, do
//
//     final commodityOrderListRes = commodityOrderListResFromJson(jsonString);

import 'dart:convert';

CommodityOrderListRes commodityOrderListResFromJson(String str) => CommodityOrderListRes.fromJson(json.decode(str));

String commodityOrderListResToJson(CommodityOrderListRes data) => json.encode(data.toJson());

class CommodityOrderListRes {
  String count;
  CommodityOrderInfo orderList;

  CommodityOrderListRes({
    required this.count,
    required this.orderList,
  });

  factory CommodityOrderListRes.fromJson(Map<String, dynamic> json) => CommodityOrderListRes(
    count: json["count"],
    orderList: CommodityOrderInfo.fromJson(json["orderList"]),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "orderList": orderList.toJson(),
  };
}

class CommodityOrderInfo {
  String contractId;
  String contractName;
  String contractOtherName;
  String id;
  String volume;
  String symbol;
  String price;
  String pricePrecision;
  String positionType;
  String open;
  String avgPrice;
  String side;
  String type;
  String orderType;
  String source;
  String liqPositionMsg;
  String liqPositionMsgTimeStamp;
  String orderBalance;
  String dealVolume;
  String tradeFee;
  String status;
  String ctime;
  String memo;
  String realizedAmount;
  String base;
  String quote;
  OtoOrder otoOrder;

  CommodityOrderInfo({
    required this.contractId,
    required this.contractName,
    required this.contractOtherName,
    required this.id,
    required this.volume,
    required this.symbol,
    required this.price,
    required this.pricePrecision,
    required this.positionType,
    required this.open,
    required this.avgPrice,
    required this.side,
    required this.type,
    required this.orderType,
    required this.source,
    required this.liqPositionMsg,
    required this.liqPositionMsgTimeStamp,
    required this.orderBalance,
    required this.dealVolume,
    required this.tradeFee,
    required this.status,
    required this.ctime,
    required this.memo,
    required this.realizedAmount,
    required this.base,
    required this.quote,
    required this.otoOrder,
  });

  factory CommodityOrderInfo.fromJson(Map<String, dynamic> json) => CommodityOrderInfo(
    contractId: json["contractId"],
    contractName: json["contractName"],
    contractOtherName: json["contractOtherName"],
    id: json["id"],
    volume: json["volume"],
    symbol: json["symbol"],
    price: json["price"],
    pricePrecision: json["pricePrecision"],
    positionType: json["positionType"],
    open: json["open"],
    avgPrice: json["avgPrice"],
    side: json["side"],
    type: json["type"],
    orderType: json["orderType"],
    source: json["source"],
    liqPositionMsg: json["liqPositionMsg"],
    liqPositionMsgTimeStamp: json["liqPositionMsgTimeStamp"],
    orderBalance: json["orderBalance"],
    dealVolume: json["dealVolume"],
    tradeFee: json["tradeFee"],
    status: json["status"],
    ctime: json["ctime"],
    memo: json["memo"],
    realizedAmount: json["realizedAmount"],
    base: json["base"],
    quote: json["quote"],
    otoOrder: OtoOrder.fromJson(json["otoOrder"]),
  );

  Map<String, dynamic> toJson() => {
    "contractId": contractId,
    "contractName": contractName,
    "contractOtherName": contractOtherName,
    "id": id,
    "volume": volume,
    "symbol": symbol,
    "price": price,
    "pricePrecision": pricePrecision,
    "positionType": positionType,
    "open": open,
    "avgPrice": avgPrice,
    "side": side,
    "type": type,
    "orderType": orderType,
    "source": source,
    "liqPositionMsg": liqPositionMsg,
    "liqPositionMsgTimeStamp": liqPositionMsgTimeStamp,
    "orderBalance": orderBalance,
    "dealVolume": dealVolume,
    "tradeFee": tradeFee,
    "status": status,
    "ctime": ctime,
    "memo": memo,
    "realizedAmount": realizedAmount,
    "base": base,
    "quote": quote,
    "otoOrder": otoOrder.toJson(),
  };
}

class OtoOrder {
  bool takerProfitStatus;
  String takerProfitTrigger;
  String takerProfitTriggerId;
  String takerProfitPrice;
  String stopLossTrigger;
  bool stopLossStatus;
  String stopLossPrice;
  String stopLossTriggerId;

  OtoOrder({
    required this.takerProfitStatus,
    required this.takerProfitTrigger,
    required this.takerProfitTriggerId,
    required this.takerProfitPrice,
    required this.stopLossTrigger,
    required this.stopLossStatus,
    required this.stopLossPrice,
    required this.stopLossTriggerId,
  });

  factory OtoOrder.fromJson(Map<String, dynamic> json) => OtoOrder(
    takerProfitStatus: json["takerProfitStatus"],
    takerProfitTrigger: json["takerProfitTrigger"],
    takerProfitTriggerId: json["takerProfitTriggerId"],
    takerProfitPrice: json["takerProfitPrice"],
    stopLossTrigger: json["stopLossTrigger"],
    stopLossStatus: json["stopLossStatus"],
    stopLossPrice: json["stopLossPrice"],
    stopLossTriggerId: json["stopLossTriggerId"],
  );

  Map<String, dynamic> toJson() => {
    "takerProfitStatus": takerProfitStatus,
    "takerProfitTrigger": takerProfitTrigger,
    "takerProfitTriggerId": takerProfitTriggerId,
    "takerProfitPrice": takerProfitPrice,
    "stopLossTrigger": stopLossTrigger,
    "stopLossStatus": stopLossStatus,
    "stopLossPrice": stopLossPrice,
    "stopLossTriggerId": stopLossTriggerId,
  };
}
