import 'dart:convert';

import 'package:nt_app_flutter/app/enums/otc/b2c.dart';

class B2COrderTransctionListModel {
  int? count;
  List<B2cOrderHistoryListModel>? dataList;

  B2COrderTransctionListModel({
    this.count,
    this.dataList,
  });

  factory B2COrderTransctionListModel.fromRawJson(String str) => B2COrderTransctionListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory B2COrderTransctionListModel.fromJson(Map<String, dynamic> json) => B2COrderTransctionListModel(
        count: json["count"],
        dataList: json["dataList"] == null
            ? []
            : List<B2cOrderHistoryListModel>.from(json["dataList"]!.map((x) => B2cOrderHistoryListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "dataList": dataList == null ? [] : List<dynamic>.from(dataList!.map((x) => x.toJson())),
      };
}

class B2cOrderHistoryListModel {
  num? id;
  String? orderId;
  num? uid;
  String? transferType;
  String? coinSymbol;
  String? fiatCoin;
  int? createTime;
  num? updateTime;
  num? transactionAmount;
  num? price;
  num? amount;
  num? fee;
  String? thirdUpdateTime;
  int? status;
  B2cOrderHistoryListTypeEnumn statusType;
  String? statusText;
  String? orderSide;
  String? cardType;
  String? cardNo;
  String? thirdTransHash;
  String? flow;
  String? priceUnit;
  String? feeUnit;

  B2cOrderHistoryListModel({
    this.id,
    this.orderId,
    this.uid,
    this.transferType,
    this.coinSymbol,
    this.fiatCoin,
    this.createTime,
    this.updateTime,
    this.transactionAmount,
    this.price,
    this.amount,
    this.fee,
    this.thirdUpdateTime,
    this.status,
    this.statusType = B2cOrderHistoryListTypeEnumn.unknown,
    this.statusText,
    this.orderSide,
    this.cardType,
    this.cardNo,
    this.thirdTransHash,
    this.flow,
    this.priceUnit,
    this.feeUnit,
  });

  factory B2cOrderHistoryListModel.fromRawJson(String str) => B2cOrderHistoryListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory B2cOrderHistoryListModel.fromJson(Map<String, dynamic> json) => B2cOrderHistoryListModel(
        id: json["id"],
        orderId: json["orderId"],
        uid: json["uid"],
        transferType: json["transferType"],
        coinSymbol: json["coinSymbol"],
        fiatCoin: json["fiatCoin"],
        createTime: json["createTime"],
        updateTime: json["updateTime"],
        transactionAmount: json["transactionAmount"],
        price: json["price"],
        amount: json["amount"],
        fee: json["fee"],
        thirdUpdateTime: json["thirdUpdateTime"],
        status: json["status"],
        statusType: json["status"] != null ? getEnumFromValue(json["status"]) : B2cOrderHistoryListTypeEnumn.unknown,
        statusText: json["statusText"],
        orderSide: json["orderSide"],
        cardType: json["cardType"],
        cardNo: json["cardNo"],
        thirdTransHash: json["thirdTransHash"],
        flow: json["flow"],
        priceUnit: json["priceUnit"],
        feeUnit: json["feeUnit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "uid": uid,
        "transferType": transferType,
        "coinSymbol": coinSymbol,
        "fiatCoin": fiatCoin,
        "createTime": createTime,
        "updateTime": updateTime,
        "transactionAmount": transactionAmount,
        "price": price,
        "amount": amount,
        "fee": fee,
        "thirdUpdateTime": thirdUpdateTime,
        "status": status,
        "statusType": statusType.value,
        "statusText": statusText,
        "orderSide": orderSide,
        "cardType": cardType,
        "cardNo": cardNo,
        "thirdTransHash": thirdTransHash,
        "flow": flow,
        "priceUnit": priceUnit,
        "feeUnit": feeUnit,
      };
}

// class B2cOrderHistoryListModel with transactionMixin {
//   String? side;
//   B2cOrderHistoryListTypeEnumn? type;

//   B2cOrderHistoryListModel({this.side, this.type});

//   factory B2cOrderHistoryListModel.fromJson(Map<String, dynamic> json) =>
//       B2cOrderHistoryListModel(
//         side: json["side"],
//         type: json["type"],
//       );

//   Map<String, dynamic> toJson() => {
//         "side": side,
//         "type": type,
//       };
// }
