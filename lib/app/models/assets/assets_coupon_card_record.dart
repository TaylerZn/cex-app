import 'dart:convert';

class AssetsCouponCardRecord {
  List<CardItem>? cardList;

  AssetsCouponCardRecord({
    this.cardList,
  });

  factory AssetsCouponCardRecord.fromRawJson(String str) =>
      AssetsCouponCardRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetsCouponCardRecord.fromJson(Map<String, dynamic> json) =>
      AssetsCouponCardRecord(
        cardList: json["cardList"] == null
            ? []
            : List<CardItem>.from(
                json["cardList"]!.map((x) => CardItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cardList": cardList == null
            ? []
            : List<dynamic>.from(cardList!.map((x) => x.toJson())),
      };
}

class CardItem {
  String? expire; //到期时间
  String? tokenNum; //赠金券金额
  String? contractName; //可用币对，为空则全部使用
  int? maxLeverage; //最大杠杆
  int? cardType; //赠金券类型0永续合约赠金券1标准合约赠金券
  String? conditionNum; //发放条件
  int? status; //0已领取 1已失效 2已使用
  String? coinSymbol; //币种

  CardItem({
    this.expire,
    this.tokenNum,
    this.contractName,
    this.maxLeverage,
    this.cardType,
    this.conditionNum,
    this.status,
    this.coinSymbol,
  });

  factory CardItem.fromRawJson(String str) =>
      CardItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardItem.fromJson(Map<String, dynamic> json) => CardItem(
        expire: json["expire"],
        tokenNum: json["tokenNum"],
        contractName: json["contractName"],
        maxLeverage: json["maxLeverage"],
        cardType: json["cardType"],
        conditionNum: json["conditionNum"],
        status: json["status"],
        coinSymbol: json["coinSymbol"],
      );

  Map<String, dynamic> toJson() => {
        "expire": expire,
        "tokenNum": tokenNum,
        "contractName": contractName,
        "maxLeverage": maxLeverage,
        "cardType": cardType,
        "conditionNum": conditionNum,
        "status": status,
        "coinSymbol": coinSymbol,
      };
}
