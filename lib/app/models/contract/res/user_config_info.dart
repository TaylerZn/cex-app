// To parse this JSON data, do
//
//     final userConfigInfo = userConfigInfoFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

UserConfigInfo userConfigInfoFromJson(String str) =>
    UserConfigInfo.fromJson(json.decode(str));

String userConfigInfoToJson(UserConfigInfo data) => json.encode(data.toJson());

class UserConfigInfo {
  int? marginModel;
  int? marginModelCanSwitch;
  int? nowLevel;
  int? minLevel;
  int? maxLevel;
  int? userMaxLevel;
  Map<String,num>? leverCeiling;
  Map<String,num>? leverOriginCeiling;
  int? levelCanSwitch;
  int? positionModel;
  int? positionModelCanSwitch;
  int? pcSecondConfirm;
  int? coUnit;
  int? openContract;
  String? multiplierCoin;
  int? currentTimeMillis;
  int? uid;
  int? orginUid;
  int? transStatus;
  int? expireTime;
  int? couponTag;
  int? futuresLocalLimit;
  int? authLevel;
  int? priceBasis;
  int? nextCapitalTime;

  int? getNowLevel() {
    return min(nowLevel ?? 20, maxLevel ?? 20);
  }

  UserConfigInfo({
    this.marginModel,
    this.marginModelCanSwitch,
    this.nowLevel,
    this.minLevel,
    this.maxLevel,
    this.userMaxLevel,
    this.leverCeiling,
    this.leverOriginCeiling,
    this.levelCanSwitch,
    this.positionModel,
    this.positionModelCanSwitch,
    this.pcSecondConfirm,
    this.coUnit,
    this.openContract,
    this.multiplierCoin,
    this.currentTimeMillis,
    this.uid,
    this.orginUid,
    this.transStatus,
    this.expireTime,
    this.couponTag,
    this.futuresLocalLimit,
    this.authLevel,
    this.priceBasis,
    this.nextCapitalTime,
  });

  factory UserConfigInfo.fromJson(Map<String, dynamic> json) => UserConfigInfo(
        marginModel: json["marginModel"],
        marginModelCanSwitch: json["marginModelCanSwitch"],
        nowLevel: json["nowLevel"],
        minLevel: json["minLevel"],
        maxLevel: json["maxLevel"],
        userMaxLevel: json["userMaxLevel"],
        leverCeiling: json['leverCeiling'] == null ? null : Map.from(json["leverCeiling"]).map((k, v) => MapEntry<String, num>(k, v),),
        leverOriginCeiling: json["leverOriginCeiling"] == null ? null : Map.from(json["leverOriginCeiling"]).map((k, v) => MapEntry<String, num>(k, v),),
        levelCanSwitch: json["levelCanSwitch"],
        positionModel: json["positionModel"],
        positionModelCanSwitch: json["positionModelCanSwitch"],
        pcSecondConfirm: json["pcSecondConfirm"],
        coUnit: json["coUnit"],
        openContract: json["openContract"],
        multiplierCoin: json["multiplierCoin"],
        currentTimeMillis: json["currentTimeMillis"],
        uid: json["uid"],
        orginUid: json["orginUid"],
        transStatus: json["transStatus"],
        expireTime: json["expireTime"],
        couponTag: json["couponTag"],
        futuresLocalLimit: json["futuresLocalLimit"],
        authLevel: json["authLevel"],
        priceBasis: json["priceBasis"],
        nextCapitalTime: json["nextCapitalTime"],
      );

  Map<String, dynamic> toJson() => {
        "marginModel": marginModel,
        "marginModelCanSwitch": marginModelCanSwitch,
        "nowLevel": nowLevel,
        "minLevel": minLevel,
        "maxLevel": maxLevel,
        "userMaxLevel": userMaxLevel,
        "leverCeiling": leverCeiling,
        "leverOriginCeiling": leverOriginCeiling,
        "levelCanSwitch": levelCanSwitch,
        "positionModel": positionModel,
        "positionModelCanSwitch": positionModelCanSwitch,
        "pcSecondConfirm": pcSecondConfirm,
        "coUnit": coUnit,
        "openContract": openContract,
        "multiplierCoin": multiplierCoin,
        "currentTimeMillis": currentTimeMillis,
        "uid": uid,
        "orginUid": orginUid,
        "transStatus": transStatus,
        "expireTime": expireTime,
        "couponTag": couponTag,
        "futuresLocalLimit": futuresLocalLimit,
        "authLevel": authLevel,
        "priceBasis": priceBasis,
        "nextCapitalTime": nextCapitalTime,
      };
}
