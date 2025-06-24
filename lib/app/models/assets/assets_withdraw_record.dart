// To parse this JSON data, do
//
//     final assetsWithdrawRecord = assetsWithdrawRecordFromJson(jsonString);

import 'dart:convert';

AssetsWithdrawRecord assetsWithdrawRecordFromJson(String str) =>
    AssetsWithdrawRecord.fromJson(json.decode(str));

String assetsWithdrawRecordToJson(AssetsWithdrawRecord data) =>
    json.encode(data.toJson());

class AssetsWithdrawRecord {
  List<AssetsWithdrawRecordItem> financeList;

  AssetsWithdrawRecord({
    required this.financeList,
  });

  factory AssetsWithdrawRecord.fromJson(Map<String, dynamic> json) =>
      AssetsWithdrawRecord(
        financeList: List<AssetsWithdrawRecordItem>.from(json["financeList"]
            .map((x) => AssetsWithdrawRecordItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "financeList": List<dynamic>.from(financeList.map((x) => x.toJson())),
      };
}

class AssetsWithdrawRecordItem {
  String symbol;
  String amount;
  double fee;
  DateTime updateAt;
  String txid;
  String label;
  String addressTo;
  DateTime createdAt;
  String walletTime;
  int updateAtTime;
  int createdAtTime;
  int id;
  String statusText;
  int status;

  AssetsWithdrawRecordItem({
    required this.symbol,
    required this.amount,
    required this.fee,
    required this.updateAt,
    required this.txid,
    required this.label,
    required this.addressTo,
    required this.createdAt,
    required this.walletTime,
    required this.updateAtTime,
    required this.createdAtTime,
    required this.id,
    required this.statusText,
    required this.status,
  });

  factory AssetsWithdrawRecordItem.fromJson(Map<String, dynamic> json) =>
      AssetsWithdrawRecordItem(
        symbol: json["symbol"],
        amount: json["amount"],
        fee: json["fee"]?.toDouble(),
        updateAt: DateTime.parse(json["updateAt"]),
        txid: json["txid"],
        label: json["label"],
        addressTo: json["addressTo"],
        createdAt: DateTime.parse(json["createdAt"]),
        walletTime: json["walletTime"],
        updateAtTime: json["updateAtTime"],
        createdAtTime: json["createdAtTime"],
        id: json["id"],
        statusText: json["status_text"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "amount": amount,
        "fee": fee,
        "updateAt": updateAt.toIso8601String(),
        "txid": txid,
        "label": label,
        "addressTo": addressTo,
        "createdAt": createdAt.toIso8601String(),
        "walletTime": walletTime,
        "updateAtTime": updateAtTime,
        "createdAtTime": createdAtTime,
        "id": id,
        "status_text": statusText,
        "status": status,
      };
}
