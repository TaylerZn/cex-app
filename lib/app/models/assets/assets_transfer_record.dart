// To parse this JSON data, do
//
//     final assetsTransferRecord = assetsTransferRecordFromJson(jsonString);

import 'dart:convert';

AssetsTransferRecord assetsTransferRecordFromJson(String str) =>
    AssetsTransferRecord.fromJson(json.decode(str));

String assetsTransferRecordToJson(AssetsTransferRecord data) =>
    json.encode(data.toJson());

class AssetsTransferRecord {
  List<AssetsTransferRecordItem> financeList;

  AssetsTransferRecord({
    required this.financeList,
  });

  factory AssetsTransferRecord.fromJson(Map<String, dynamic> json) =>
      AssetsTransferRecord(
        financeList: List<AssetsTransferRecordItem>.from(json["financeList"]
            .map((x) => AssetsTransferRecordItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "financeList": List<dynamic>.from(financeList.map((x) => x.toJson())),
      };
}

class AssetsTransferRecordItem {
  int transactionType;
  num amount;
  String coinSymbol;
  DateTime createTime;
  String transactionTypeText;
  int createdAtTime;

  AssetsTransferRecordItem({
    required this.transactionType,
    required this.amount,
    required this.coinSymbol,
    required this.createTime,
    required this.transactionTypeText,
    required this.createdAtTime,
  });

  factory AssetsTransferRecordItem.fromJson(Map<String, dynamic> json) =>
      AssetsTransferRecordItem(
        transactionType: json["transactionType"],
        amount: json["amount"],
        coinSymbol: json["coinSymbol"],
        createTime: DateTime.parse(json["createTime"]),
        transactionTypeText: json["transactionType_text"],
        createdAtTime: json["createdAtTime"],
      );

  Map<String, dynamic> toJson() => {
        "transactionType": transactionType,
        "amount": amount,
        "coinSymbol": coinSymbol,
        "createTime": createTime.toIso8601String(),
        "transactionType_text": transactionTypeText,
        "createdAtTime": createdAtTime,
      };
}
