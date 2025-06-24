import 'dart:ui';

class OfficeMessageRes {
  List<OfficeMessageInfo> data;
  int total;
  int totalPage;
  int pageSize;
  int currentPage;

  OfficeMessageRes({
    required this.data,
    required this.total,
    required this.totalPage,
    required this.pageSize,
    required this.currentPage,
  });

  factory OfficeMessageRes.fromJson(Map<String, dynamic> json) => OfficeMessageRes(
    data: List<OfficeMessageInfo>.from(json["data"].map((x) => OfficeMessageInfo.fromJson(x))),
    total: json["total"],
    totalPage: json["totalPage"],
    pageSize: json["pageSize"],
    currentPage: json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "totalPage": totalPage,
    "pageSize": pageSize,
    "currentPage": currentPage,
  };
}

class OfficeMessageInfo {
  int id;
  String img;
  String title;
  String details;
  String sendTime;
  String? queryTime;

  OfficeMessageInfo({
    required this.id,
    required this.img,
    required this.title,
    required this.details,
    required this.sendTime,
    required this.queryTime,
  });

  factory OfficeMessageInfo.fromJson(Map<String, dynamic> json) => OfficeMessageInfo(
    id: json["id"],
    img: json["img"],
    title: json["title"],
    details: json["details"],
    sendTime: json["sendTime"],
    queryTime: json["queryTime"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "img": img,
    "title": title,
    "details": details,
    "sendTime": sendTime,
    "queryTime": queryTime,
  };
}