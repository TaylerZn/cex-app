import 'dart:convert';

class MessageUnreadModel {
    int noReadMsgCount;

    MessageUnreadModel({
        required this.noReadMsgCount,
    });

    factory MessageUnreadModel.fromRawJson(String str) =>
     MessageUnreadModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessageUnreadModel.fromJson(Map<String, dynamic> json) => MessageUnreadModel(
        noReadMsgCount: json["noReadMsgCount"],
    );

    Map<String, dynamic> toJson() => {
        "noReadMsgCount": noReadMsgCount,
    };
}
