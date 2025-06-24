import 'dart:convert';

class SpotsTradeHistoryModel {
  List<SpotsTradeHistoryListModel>? orderList;
  int? count;
  int? pageSize;

  SpotsTradeHistoryModel({
    this.orderList,
    this.count,
    this.pageSize,
  });

  factory SpotsTradeHistoryModel.fromRawJson(String str) =>
      SpotsTradeHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpotsTradeHistoryModel.fromJson(Map<String, dynamic> json) =>
      SpotsTradeHistoryModel(
        orderList: json["orderList"] == null
            ? []
            : List<SpotsTradeHistoryListModel>.from(json["orderList"]!
                .map((x) => SpotsTradeHistoryListModel.fromJson(x))),
        count: json["count"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "orderList": orderList == null
            ? []
            : List<dynamic>.from(orderList!.map((x) => x.toJson())),
        "count": count,
        "pageSize": pageSize,
      };
}

class SpotsTradeHistoryListModel {
  dynamic price;
  dynamic volume;
  dynamic trendSide;
  dynamic quoteCoin;
  dynamic baseCoin;
  dynamic fee;
  dynamic feeCoin;
  dynamic ctime;
  dynamic role;
  dynamic dealPrice;
  dynamic ctimeFormat;
  dynamic usdtTotal;

  SpotsTradeHistoryListModel({
    this.price,
    this.volume,
    this.trendSide,
    this.quoteCoin,
    this.baseCoin,
    this.fee,
    this.feeCoin,
    this.ctime,
    this.role,
    this.dealPrice,
    this.ctimeFormat,
    this.usdtTotal,
  });

  factory SpotsTradeHistoryListModel.fromRawJson(String str) =>
      SpotsTradeHistoryListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpotsTradeHistoryListModel.fromJson(Map<String, dynamic> json) =>
      SpotsTradeHistoryListModel(
        price: json["price"],
        volume: json["volume"],
        trendSide: json["trendSide"],
        quoteCoin: json["quoteCoin"],
        baseCoin: json["baseCoin"],
        fee: json["fee"],
        feeCoin: json["feeCoin"],
        ctime: json["ctime"],
        role: json["role"],
        dealPrice: json["dealPrice"],
        ctimeFormat: json["ctimeFormat"],
        usdtTotal: json["usdtTotal"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "volume": volume,
        "trendSide": trendSide,
        "quoteCoin": quoteCoin,
        "baseCoin": baseCoin,
        "fee": fee,
        "feeCoin": feeCoin,
        "ctime": ctime,
        "role": role,
        "dealPrice": dealPrice,
        "ctimeFormat": ctimeFormat,
        "usdtTotal": usdtTotal,
      };
}
