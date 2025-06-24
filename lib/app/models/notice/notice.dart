import 'dart:convert';

class NoticeModel {
  int count;
  List<NoticeInfo> noticeInfoList;
  int pageSize;

  NoticeModel({
    required this.count,
    required this.noticeInfoList,
    required this.pageSize,
  });

  factory NoticeModel.fromRawJson(String str) =>
      NoticeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
        count: json["count"],
        noticeInfoList: List<NoticeInfo>.from(
            json["noticeInfoList"].map((x) => NoticeInfo.fromJson(x))),
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "noticeInfoList":
            List<dynamic>.from(noticeInfoList.map((x) => x.toJson())),
        "pageSize": pageSize,
      };
}

class NoticeInfo {
  num? id;
  String? title;
  String? httpUrl;
  num? timeLong;
  String? content;
  String? contentText;
  num? type;

  NoticeInfo(
      {this.id,
      this.title,
      this.httpUrl,
      this.timeLong,
      this.content,
      this.contentText,
      this.type});

  factory NoticeInfo.fromRawJson(String str) =>
      NoticeInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NoticeInfo.fromJson(Map<String, dynamic> json) => NoticeInfo(
        id: json["id"],
        title: json["title"],
        httpUrl: json["httpUrl"],
        timeLong: json["timeLong"],
        content: json["content"],
        contentText: json["contentText"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "httpUrl": httpUrl,
        "timeLong": timeLong,
        "content": content,
        "contentText": contentText,
        "type": type,
      };
}


// class NoticeInfo {
//   int id;
//   String title;
//   String lang;
//   int timeLong;
//   String content;
//    String contentText;
//   int type;
//   String? httpUrl;

//   NoticeInfo({
//     required this.id,
//     required this.title,
//     required this.lang,
//     required this.timeLong,
//     required this.content,
//     required this.type,
//     this.httpUrl,
//   });

//   factory NoticeInfo.fromRawJson(String str) =>
//       NoticeInfo.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory NoticeInfo.fromJson(Map<String, dynamic> json) => NoticeInfo(
//         id: json["id"],
//         title: json["title"],
//         lang: json["lang"],
//         timeLong: json["timeLong"],
//         content: json["content"],
//         type: json["type"],
//         httpUrl: json["httpUrl"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "lang": lang,
//         "timeLong": timeLong,
//         "content": content,
//         "type": type,
//         "httpUrl": httpUrl,
//       };
// }
