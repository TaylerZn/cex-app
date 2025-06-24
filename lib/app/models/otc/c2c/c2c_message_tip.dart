import 'dart:convert';

List<C2CMessageTip> c2CMessageFromJson(String str) => List<C2CMessageTip>.from(
    json.decode(str).map((x) => C2CMessageTip.fromJson(x)));

String c2CMessageToJson(List<C2CMessageTip> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class C2CMessageTip {
  final int? id;
  final int? chatId;
  final int? orderId;
  final String? fromId;
  final String? fromName;
  final String? toId;
  final String? toName;
  final String? content;
  final int? status;
  final int? ctime;

  C2CMessageTip({
    this.id,
    this.chatId,
    this.orderId,
    this.fromId,
    this.fromName,
    this.toId,
    this.toName,
    this.content,
    this.status,
    this.ctime,
  });

  C2CMessageTip copyWith({
    int? id,
    int? chatId,
    int? orderId,
    String? fromId,
    String? fromName,
    String? toId,
    String? toName,
    String? content,
    int? status,
    int? ctime,
  }) =>
      C2CMessageTip(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        orderId: orderId ?? this.orderId,
        fromId: fromId ?? this.fromId,
        fromName: fromName ?? this.fromName,
        toId: toId ?? this.toId,
        toName: toName ?? this.toName,
        content: content ?? this.content,
        status: status ?? this.status,
        ctime: ctime ?? this.ctime,
      );

  factory C2CMessageTip.fromJson(Map<String, dynamic> json) => C2CMessageTip(
        id: json["id"],
        chatId: json["chatId"],
        orderId: json["orderId"],
        fromId: json["fromId"],
        fromName: json["fromName"],
        toId: json["toId"],
        toName: json["toName"],
        content: json["content"],
        status: json["status"],
        ctime: json["ctime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatId": chatId,
        "orderId": orderId,
        "fromId": fromId,
        "fromName": fromName,
        "toId": toId,
        "toName": toName,
        "content": content,
        "status": status,
        "ctime": ctime,
      };
}
