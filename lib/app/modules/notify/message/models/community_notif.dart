// To parse this JSON data, do
//
//     final communityNotif = communityNotifFromJson(jsonString);

import 'dart:convert';

CommunityNotif communityNotifFromJson(String str) => CommunityNotif.fromJson(json.decode(str));

String communityNotifToJson(CommunityNotif data) => json.encode(data.toJson());

class CommunityNotif {
  bool? hasVideo;
  int? topicId;
  int? code;
  String? quotedTitle;
  int? fromUserId;
  String? subject;
  String? pictureUrl;
  String? topicNo;
  String? label;
  String? replyContent;
  String? title;

  CommunityNotif({
    this.hasVideo,
    this.topicId,
    this.code,
    this.quotedTitle,
    this.fromUserId,
    this.subject,
    this.pictureUrl,
    this.topicNo,
    this.label,
    this.replyContent,
    this.title,
  });

  factory CommunityNotif.fromJson(Map<String, dynamic> json) => CommunityNotif(
    hasVideo: json["hasVideo"],
    topicId: json["topicId"],
    code: json["code"],
    quotedTitle: json["quotedTitle"],
    fromUserId: json["fromUserId"],
    subject: json["subject"],
    pictureUrl: json["pictureUrl"],
    topicNo: json["topicNo"],
    label: json["label"],
    replyContent: json["replyContent"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "hasVideo": hasVideo,
    "topicId": topicId,
    "code": code,
    "quotedTitle": quotedTitle,
    "fromUserId": fromUserId,
    "subject": subject,
    "pictureUrl": pictureUrl,
    "topicNo": topicNo,
    "label": label,
    "replyContent": replyContent,
    "title": title,
  };
}
