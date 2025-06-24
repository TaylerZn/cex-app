import 'dart:convert';

class AssetsBonusRecord {
  List<AssetsBonusRecordItem>? financeList;
  int? pageSize;
  int? count;

  AssetsBonusRecord({
    this.financeList,
    this.pageSize,
    this.count,
  });

  factory AssetsBonusRecord.fromRawJson(String str) =>
      AssetsBonusRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetsBonusRecord.fromJson(Map<String, dynamic> json) =>
      AssetsBonusRecord(
        financeList: json["financeList"] == null
            ? []
            : List<AssetsBonusRecordItem>.from(json["financeList"]!
                .map((x) => AssetsBonusRecordItem.fromJson(x))),
        pageSize: json["pageSize"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "financeList": financeList == null
            ? []
            : List<dynamic>.from(financeList!.map((x) => x.toJson())),
        "pageSize": pageSize,
        "count": count,
      };
}

class AssetsBonusRecordItem {
  String? memo;
  dynamic status;
  String? statusText;
  dynamic createdAtTime;
  String? createTime;
  String? coinSymbol;
  dynamic amount;
  String? type;

  AssetsBonusRecordItem({
    this.memo,
    this.status,
    this.statusText,
    this.createdAtTime,
    this.createTime,
    this.coinSymbol,
    this.amount,
    this.type,
  });

  factory AssetsBonusRecordItem.fromRawJson(String str) =>
      AssetsBonusRecordItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetsBonusRecordItem.fromJson(Map<String, dynamic> json) =>
      AssetsBonusRecordItem(
        memo: json["memo"],
        status: json["status"],
        statusText: json["status_text"],
        createdAtTime: json["createdAtTime"],
        createTime: json["createTime"],
        coinSymbol: json["coinSymbol"],
        amount: json["amount"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "memo": memo,
        "status": status,
        "status_text": statusText,
        "createdAtTime": createdAtTime,
        "createTime": createTime,
        "coinSymbol": coinSymbol,
        "amount": amount,
        "type": type,
      };
}
