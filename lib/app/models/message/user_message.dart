import 'dart:convert';

class UserMessageModel {
  int? count;
  int? pageSize;
  List<UserMessage> userMessageList;

  UserMessageModel({
    this.count,
    this.pageSize,
    required this.userMessageList,
  });

  factory UserMessageModel.fromRawJson(String str) =>
      UserMessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserMessageModel.fromJson(Map<String, dynamic> json) =>
      UserMessageModel(
        count: json["count"],
        pageSize: json["pageSize"],
        userMessageList: json["userMessageList"] == null
            ? []
            : List<UserMessage>.from(
                json["userMessageList"]!.map((x) => UserMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pageSize": pageSize,
        "userMessageList": userMessageList == null
            ? []
            : List<dynamic>.from(userMessageList!.map((x) => x.toJson())),
      };
}
enum UserMessageType{
  system,
  wallet,
  otc,
  announcement,
  activity,
  community,
}
class UserMessage {

  int? id;
  int? messageType;
  String? messageContent;
  int? ctime;
  String? messageTypeName;
  String? extInfo;
  int? timeLong;
  String? httpUrl;
  String? contentText;
  String? title;
  String? lang;
  int? noticeType;
  String? source;

  UserMessage({
    this.id,
    this.messageType,
    this.messageContent,
    this.ctime,
    this.messageTypeName,
    this.extInfo,
    this.timeLong,
    this.httpUrl,
    this.contentText,
    this.title,
    this.lang,
    this.noticeType,
    this.source,
  });

  factory UserMessage.fromJson(Map<String, dynamic> json) => UserMessage(
    id: json["id"],
    messageType: json["messageType"],
    messageContent: json["messageContent"],
    ctime: json["ctime"],
    messageTypeName: json["messageTypeName"],
    extInfo: json["extInfo"],
    timeLong: json["timeLong"],
    httpUrl: json["httpUrl"],
    contentText: json["contentText"],
    title: json["title"],
    lang: json["lang"],
    noticeType: json["noticeType"],
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "messageType": messageType,
    "messageContent": messageContent,
    "ctime": ctime,
    "messageTypeName": messageTypeName,
    "extInfo": extInfo,
    "timeLong": timeLong,
    "httpUrl": httpUrl,
    "contentText": contentText,
    "title": title,
    "lang": lang,
    "noticeType": noticeType,
    "source": source,
  };
}

