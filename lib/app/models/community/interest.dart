import 'dart:convert';

class InterestPeopleListModel {
  num? uid;
  String? nickName;
  String? pictureUrl;
  String? signatureInfo;
  num? flow;
  num? fanNum;
  num? focusNum;
  int? levelType;
  String? identityDesc;
  int? followStatus;
  String? flagIcon = '';
  String? organizationIcon = '';
  List? tradingStyleLabel;

  String get tradingStyleStr => tradingStyleLabel?.isNotEmpty == true ? tradingStyleLabel!.first : '';

  InterestPeopleListModel({
    this.uid,
    this.nickName,
    this.pictureUrl,
    this.signatureInfo,
    this.flow,
    this.fanNum,
    this.focusNum,
    this.identityDesc,
    this.levelType,
    this.followStatus,
    this.flagIcon,
    this.organizationIcon,
    this.tradingStyleLabel
  });

  factory InterestPeopleListModel.fromRawJson(String str) =>
      InterestPeopleListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InterestPeopleListModel.fromJson(Map<String, dynamic> json) =>
      InterestPeopleListModel(
        identityDesc : json['identityDesc'],
        uid: json["uid"],
        levelType: json['levelType'],
        nickName: json["nickName"],
        pictureUrl: json["pictureUrl"],
        signatureInfo: json["signatureInfo"],
        flow: json["flow"],
        fanNum: json['fanNum'],
        focusNum: json['focusNum'],
        followStatus: json['followStatus'],
        flagIcon: json['flagIcon'],
        organizationIcon: json['organizationIcon'],
        tradingStyleLabel: json["tradingStyleLabel"] == null ? [] : List<String>.from(json["tradingStyleLabel"]!.map((x) => x)),

      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        'levelType' : levelType,
        "nickName": nickName,
        "pictureUrl": pictureUrl,
        "signatureInfo": signatureInfo,
        "flow": flow,
        'followStatus' : followStatus,
        'fanNum' : fanNum,
        'focusNum' : focusNum,
        'flagIcon' : flagIcon,
        'organizationIcon' : organizationIcon,
        'tradingStyleLabel': tradingStyleLabel,
      };
}
