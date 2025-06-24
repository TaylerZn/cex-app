import 'dart:convert';

class CommunityStationMessage {
  List<Record>? records;

  CommunityStationMessage({
    this.records,
  });

  factory CommunityStationMessage.fromRawJson(String str) =>
      CommunityStationMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommunityStationMessage.fromJson(Map<String, dynamic> json) =>
      CommunityStationMessage(
        records: json["records"] == null
            ? []
            : List<Record>.from(
                json["records"]!.map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "records": records == null
            ? []
            : List<dynamic>.from(records!.map((x) => x.toJson())),
      };
}

class Record {
  int? tid;
  String? title;
  String? news;
  int? ctime;
  int? unreadCount;

  Record({
    this.tid,
    this.title,
    this.news,
    this.ctime,
    this.unreadCount,
  });

  factory Record.fromRawJson(String str) => Record.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        tid: json["tid"],
        title: json["title"],
        news: json["news"],
        ctime: json["ctime"],
        unreadCount: json["unreadCount"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "title": title,
        "news": news,
        "ctime": ctime,
        "unreadCount": unreadCount,
      };
}
