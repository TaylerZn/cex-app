import 'dart:convert';

C2CUnreadMessageCount c2CUnreadMessageCountFromJson(String str) =>
    C2CUnreadMessageCount.fromJson(json.decode(str));

String c2CUnreadMessageCountToJson(C2CUnreadMessageCount data) =>
    json.encode(data.toJson());

class C2CUnreadMessageCount {
  final String? userId;
  final String? userName;
  final String? avatar;
  final String? latestNews;
  final int? count;

  C2CUnreadMessageCount({
    this.userId,
    this.userName,
    this.avatar,
    this.latestNews,
    this.count,
  });

  C2CUnreadMessageCount copyWith({
    String? userId,
    String? userName,
    String? avatar,
    String? latestNews,
    int? count,
  }) =>
      C2CUnreadMessageCount(
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        avatar: avatar ?? this.avatar,
        latestNews: latestNews ?? this.latestNews,
        count: count ?? this.count,
      );

  factory C2CUnreadMessageCount.fromJson(Map<String, dynamic> json) =>
      C2CUnreadMessageCount(
        userId: json["userId"],
        userName: json["userName"],
        avatar: json["avatar"],
        latestNews: json["latestNews"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "avatar": avatar,
        "latestNews": latestNews,
        "count": count,
      };
}
