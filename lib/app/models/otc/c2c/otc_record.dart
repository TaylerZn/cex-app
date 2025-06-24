// To parse this JSON data, do
//
//     final otcRecord = otcRecordFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

enum RecordTabType {
  present('ing'),
  finish('ed');
  const RecordTabType(this.key);
  final String key;

}

enum OTCOrderType {
  all(null,null),
  notPay(1,''),
  paid(2,''),
  completed(3,''),
  canceled(4,''),
  complain(5,'');

  const OTCOrderType(this.key,this.page);
  final int? key;
  final String? page;


  String  title () {

    switch(this){
      case OTCOrderType.all:
        return LocaleKeys.c2c147.tr;
        // TODO: Handle this case.
      case OTCOrderType.notPay:
        return LocaleKeys.c2c146.tr;
        // TODO: Handle this case.
      case OTCOrderType.paid:
        return LocaleKeys.c2c148.tr;
        // TODO: Handle this case.
      case OTCOrderType.completed:
        return LocaleKeys.c2c150.tr;
        // TODO: Handle this case.
      case OTCOrderType.canceled:
        return LocaleKeys.c2c151.tr;
        // TODO: Handle this case.
      case OTCOrderType.complain:
        return LocaleKeys.c2c149.tr;
        // TODO: Handle this case.
    }
  }
}

OtcRecord otcRecordFromJson(String str) => OtcRecord.fromJson(json.decode(str));

String otcRecordToJson(OtcRecord data) => json.encode(data.toJson());

class OtcRecord {
  int? total;
  List<Record>? records;
  bool? isComplaining;
  OtcRecord({
    this.total,
    this.records,
    this.isComplaining
  });

  factory OtcRecord.fromJson(Map<String, dynamic> json) => OtcRecord(
    total: json["total"],
   isComplaining : json['isComplaining'],
    records: json["records"] == null ? [] : List<Record>.from(json["records"]!.map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "records": records == null ? [] : List<dynamic>.from(records!.map((x) => x.toJson())),
  };
}

class Record {
  int? id;
  String? sequence;
  int? adsId;
  int? adsOwner;
  int? sellerId;
  int? buyerId;
  double? volume;
  double? totalPrice;
  int? status;
  String? terms;
  String? description;
  int? limitTime;
  int? creator;
  int? trustScore;
  int? responseScore;
  int? releaseSource;
  String? advise;
  int? ctime;
  String? buyerComment;
  String? sellerComment;
  dynamic buyerCommentGrade;
  dynamic sellerCommnetGrade;
  int? mtime;
  int? complainId;
  dynamic complainCommand;
  double? price;
  int? isBlockTrade;
  int? cancelStatus;
  String? orderId;
  String? advertId;
  String? merchantId;
  String? merchantName;
  String? fromUserName;
  String? side;
  String? paycoin;
  String? coin;
  dynamic sellerName;
  dynamic buyerName;
  int? unreadCount;
  String? statusName;

  Record({
    this.id,
    this.sequence,
    this.adsId,
    this.adsOwner,
    this.sellerId,
    this.buyerId,
    this.volume,
    this.fromUserName,
    this.totalPrice,
    this.status,
    this.terms,
    this.description,
    this.limitTime,
    this.creator,
    this.trustScore,
    this.responseScore,
    this.releaseSource,
    this.advise,
    this.ctime,
    this.buyerComment,
    this.sellerComment,
    this.buyerCommentGrade,
    this.sellerCommnetGrade,
    this.mtime,
    this.complainId,
    this.complainCommand,
    this.price,
    this.isBlockTrade,
    this.cancelStatus,
    this.orderId,
    this.advertId,
    this.merchantId,
    this.merchantName,
    this.side,
    this.paycoin,
    this.coin,
    this.sellerName,
    this.buyerName,
    this.unreadCount,
    this.statusName,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    sequence: json["sequence"],
    adsId: json["adsId"],
    adsOwner: json["adsOwner"],
    sellerId: json["sellerId"],
    buyerId: json["buyerId"],
    volume: json["volume"],
    totalPrice: json["totalPrice"],
    status: json["status"],
    fromUserName: json['fromUserName'],
    terms: json["terms"],
    description: json["description"],
    limitTime: json["limitTime"],
    creator: json["creator"],
    trustScore: json["trustScore"],
    responseScore: json["responseScore"],
    releaseSource: json["releaseSource"],
    advise: json["advise"],
    ctime: json["ctime"],
    buyerComment: json["buyerComment"],
    sellerComment: json["sellerComment"],
    buyerCommentGrade: json["buyerCommentGrade"],
    sellerCommnetGrade: json["sellerCommnetGrade"],
    mtime: json["mtime"],
    complainId: json["complainId"],
    complainCommand: json["complainCommand"],
    price: json["price"],
    isBlockTrade: json["isBlockTrade"],
    cancelStatus: json["cancelStatus"],
    orderId: json["orderId"],
    advertId: json["advertId"],
    merchantId: json["merchantId"],
    merchantName: json["merchantName"],
    side: json["side"],
    paycoin: json["paycoin"],
    coin: json["coin"],
    sellerName: json["sellerName"],
    buyerName: json["buyerName"],
    unreadCount: json["unreadCount"],
    statusName: json["statusName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sequence": sequence,
    "adsId": adsId,
    "adsOwner": adsOwner,
    "sellerId": sellerId,
    "buyerId": buyerId,
    "volume": volume,
    "totalPrice": totalPrice,
    "status": status,
    'fromUserName':fromUserName,
    "terms": terms,
    "description": description,
    "limitTime": limitTime,
    "creator": creator,
    "trustScore": trustScore,
    "responseScore": responseScore,
    "releaseSource": releaseSource,
    "advise": advise,
    "ctime": ctime,
    "buyerComment": buyerComment,
    "sellerComment": sellerComment,
    "buyerCommentGrade": buyerCommentGrade,
    "sellerCommnetGrade": sellerCommnetGrade,
    "mtime": mtime,
    "complainId": complainId,
    "complainCommand": complainCommand,
    "price": price,
    "isBlockTrade": isBlockTrade,
    "cancelStatus": cancelStatus,
    "orderId": orderId,
    "advertId": advertId,
    "merchantId": merchantId,
    "merchantName": merchantName,
    "side": side,
    "paycoin": paycoin,
    "coin": coin,
    "sellerName": sellerName,
    "buyerName": buyerName,
    "unreadCount": unreadCount,
    "statusName": statusName,
  };

  bool get isSell => side == 'SELL';

  bool get isBuy {
    int? uid = UserGetx.to.uid;
    bool seller = merchantId == uid.toString();
    bool isBuy = false;
    if (seller) {
      isBuy = side == 'BUY';
    } else {
      isBuy = side == 'SELL';
    }
    return isBuy;
  }
}
