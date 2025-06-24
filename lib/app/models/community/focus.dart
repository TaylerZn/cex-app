import 'dart:convert';

class TopicFocusListModel {
  String? nickName;
  num? uid;
  String? pictureUrl;
  String? signatureInfo;
  String? focusNum;
  bool? focusOn;
  int? levelType;
  int? followStatus;
  int? isKol;

  TopicFocusListModel({
    this.uid,
    this.nickName,
    this.pictureUrl,
    this.signatureInfo,
    this.isKol,
    this.focusNum,
    this.levelType,
    this.followStatus,
  });

  factory TopicFocusListModel.fromRawJson(String str) =>
      TopicFocusListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopicFocusListModel.fromJson(Map<String, dynamic> json) =>
      TopicFocusListModel(
        uid: json["uid"],
        nickName: json["nickName"],
        pictureUrl: json["pictureUrl"],
        isKol:json['isKol'],
        followStatus: json['followStatus'],
        signatureInfo: json["signatureInfo"],
        levelType: json["levelType"],
        focusNum: json["focusNum"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "nickName": nickName,
        "pictureUrl": pictureUrl,
        "signatureInfo": signatureInfo,
        "followStatus": followStatus,
        "levelType": levelType,
        'isKol':isKol,
        "focusNum": focusNum,
      };
}
