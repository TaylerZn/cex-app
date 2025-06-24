import 'dart:convert';

import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class AgentBonusRecordDetailModel {
  int? count;
  List<AgentBonusRecordDetailMapList>? mapList;

  AgentBonusRecordDetailModel({
    this.count,
    this.mapList,
  });

  factory AgentBonusRecordDetailModel.fromRawJson(String str) =>
      AgentBonusRecordDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgentBonusRecordDetailModel.fromJson(Map<String, dynamic> json) =>
      AgentBonusRecordDetailModel(
        count: json["count"],
        mapList: json["mapList"] == null
            ? []
            : List<AgentBonusRecordDetailMapList>.from(json["mapList"]!
                .map((x) => AgentBonusRecordDetailMapList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "mapList": mapList == null
            ? []
            : List<dynamic>.from(mapList!.map((x) => x.toJson())),
      };
}

class AgentBonusRecordDetailMapList {
  dynamic coin;
  dynamic time;
  dynamic amount;
  dynamic uid;
  dynamic nickName;
  dynamic pictureUrl;

  AgentBonusRecordDetailMapList({
    this.coin,
    this.time,
    this.amount,
    this.uid,
    this.nickName,
    this.pictureUrl,
  });

  factory AgentBonusRecordDetailMapList.fromRawJson(String str) =>
      AgentBonusRecordDetailMapList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgentBonusRecordDetailMapList.fromJson(Map<String, dynamic> json) =>
      AgentBonusRecordDetailMapList(
        coin: json["coin"],
        time: json["time"],
        amount: json["amount"],
        uid: json["uid"],
        nickName: json["nickName"],
        pictureUrl: json["pictureUrl"],
      );

  Map<String, dynamic> toJson() => {
        "coin": coin,
        "time": time,
        "amount": amount,
        "uid": uid,
        "nickName": nickName,
        "pictureUrl": pictureUrl,
      };
}

class AgentFollowProfitRecordModel {
  int? count;
  List<AgentFollowProfitRecordMapList>? mapList;

  AgentFollowProfitRecordModel({
    this.count,
    this.mapList,
  });

  factory AgentFollowProfitRecordModel.fromRawJson(String str) =>
      AgentFollowProfitRecordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgentFollowProfitRecordModel.fromJson(Map<String, dynamic> json) =>
      AgentFollowProfitRecordModel(
        count: json["count"],
        mapList: json["mapList"] == null
            ? []
            : List<AgentFollowProfitRecordMapList>.from(json["mapList"]!
                .map((x) => AgentFollowProfitRecordMapList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "mapList": mapList == null
            ? []
            : List<dynamic>.from(mapList!.map((x) => x.toJson())),
      };
}

class AgentFollowProfitRecordMapList {
  dynamic coin;
  dynamic time;
  dynamic amount;
  dynamic uid;
  dynamic nickName;
  dynamic pictureUrl;

  AgentFollowProfitRecordMapList({
    this.coin,
    this.time,
    this.amount,
    this.uid,
    this.nickName,
    this.pictureUrl,
  });

  factory AgentFollowProfitRecordMapList.fromRawJson(String str) =>
      AgentFollowProfitRecordMapList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgentFollowProfitRecordMapList.fromJson(Map<String, dynamic> json) =>
      AgentFollowProfitRecordMapList(
        coin: json["coin"],
        time: json["time"],
        amount: json["amount"],
        uid: json["uid"],
        nickName: json["nickName"],
        pictureUrl: json["pictureUrl"],
      );

  Map<String, dynamic> toJson() => {
        "coin": coin,
        "time": time,
        "amount": amount,
        "uid": uid,
        "nickName": nickName,
        "pictureUrl": pictureUrl,
      };
}

/// 手续费返佣
class AgentBonusRecordListModel {
  List<AgentBonusRecordItem>? list;
  num? totalAmount; //总收益
  int? count; //总数
  AgentBonusRecordListModel({this.list, this.totalAmount, this.count});

  factory AgentBonusRecordListModel.fromRawJson(String str) =>
      AgentBonusRecordListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgentBonusRecordListModel.fromJson(Map<String, dynamic> json) =>
      AgentBonusRecordListModel(
        list: json["list"] == null
            ? []
            : List<AgentBonusRecordItem>.from(
                json["list"]!.map((x) => AgentBonusRecordItem.fromJson(x))),
        totalAmount: json["totalAmount"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "totalAmount": totalAmount,
        "count": count
      };
}

class AgentBonusRecordItem {
  String? nickName; //昵称
  num? amount; //收益
  String? coin; //币种
  int? returnType; //佣金类型：1=手续费返佣（直推）、2=手续费返佣（间推）、3=跟单返佣（间推）、4=跟单返佣（直推）
  dynamic uid; //用户id string或者 int 都可能
  String? pictureUrl; //头像url
  int? itemDate; //日期时间戳

  AgentBonusRecordItem({
    this.nickName,
    this.amount,
    this.coin,
    this.returnType,
    this.uid,
    this.pictureUrl,
    this.itemDate,
  });

  factory AgentBonusRecordItem.fromRawJson(String str) =>
      AgentBonusRecordItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgentBonusRecordItem.fromJson(Map<String, dynamic> json) =>
      AgentBonusRecordItem(
        nickName: json["nickName"],
        amount: json["amount"],
        coin: json["coin"],
        returnType: json["type"],
        uid: json["uid"],
        pictureUrl: json["pictureUrl"],
        itemDate: json["itemDate"],
      );

  Map<String, dynamic> toJson() => {
        "nickName": nickName,
        "amount": amount,
        "coin": coin,
        "type": returnType,
        "uid": uid,
        "pictureUrl": pictureUrl,
        "itemDate": itemDate,
      };

  // Add this method to return the type as a string
  // 佣金类型： 0.合约手续费（直推），1.合约手续费（间推），2.现货手续费（直推），3.现货手续（间推），4.跟单返佣（直推），5.跟单返佣（间推）
  String get returnTypeStr {
    switch (returnType) {
      case 0:
        return LocaleKeys.user313.tr; // 0.合约手续费（直推)
      case 1:
        return LocaleKeys.user314.tr; //1.合约手续费（间推）;
      case 2:
        return LocaleKeys.user315.tr; //2.现货手续费（直推）;
      case 3:
        return LocaleKeys.user316.tr; //3.现货手续（间推）;
      case 4:
        return LocaleKeys.user277.tr; //4.跟单返佣（直推）;
      case 5:
        return LocaleKeys.user278.tr; //5.跟单返佣（间推）
      default:
        return LocaleKeys.user53.tr; //手续费返佣
    }
  }
}

//邀请用户列表 InviteUserListModel

class InviteUserListModel {
  List<InviteUserItem>? list;
  num? count;

  InviteUserListModel({
    this.list,
    this.count,
  });

  factory InviteUserListModel.fromRawJson(String str) =>
      InviteUserListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InviteUserListModel.fromJson(Map<String, dynamic> json) =>
      InviteUserListModel(
        list: json["list"] == null
            ? []
            : List<InviteUserItem>.from(
                json["list"]!.map((x) => InviteUserItem.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "count": count,
      };
}

class InviteUserItem {
  num? uid; //用户id
  String? nickName; //用户昵称
  dynamic bonusAmount; //收益贡献
  dynamic iniviteDate; //邀请注册时间
  String? coin; //币种
  String? pictureUrl; //用户头像

  InviteUserItem({
    this.uid,
    this.nickName,
    this.bonusAmount,
    this.iniviteDate,
    this.coin,
    this.pictureUrl,
  });

  factory InviteUserItem.fromRawJson(String str) =>
      InviteUserItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InviteUserItem.fromJson(Map<String, dynamic> json) => InviteUserItem(
        uid: json["uid"],
        nickName: json["nickName"],
        bonusAmount: json["bonusAmount"],
        iniviteDate: json["iniviteDate"],
        coin: json["coin"],
        pictureUrl: json["pictureUrl"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "nickName": nickName,
        "bonusAmount": bonusAmount,
        "iniviteDate": iniviteDate,
        "coin": coin,
        "pictureUrl": pictureUrl,
      };
}

class AgentUserTypeStatModel {
  int? directUserCount;
  int? indirectUserCount;
  List<AgentUserTypeParticipates>? participates;

  AgentUserTypeStatModel({
    this.directUserCount,
    this.indirectUserCount,
    this.participates,
  });

  factory AgentUserTypeStatModel.fromRawJson(String str) =>
      AgentUserTypeStatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgentUserTypeStatModel.fromJson(Map<String, dynamic> json) =>
      AgentUserTypeStatModel(
        directUserCount: json["directUserCount"],
        indirectUserCount: json["indirectUserCount"],
        participates: json["participates"] == null
            ? []
            : List<AgentUserTypeParticipates>.from(json["participates"]!
                .map((x) => AgentUserTypeParticipates.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "directUserCount": directUserCount,
        "indirectUserCount": indirectUserCount,
        "participates": participates == null
            ? []
            : List<dynamic>.from(participates!.map((x) => x.toJson())),
      };
}

class AgentUserTypeParticipates {
  String? type; //功能类型
  String? typeTxt; //功能名称
  int? count; // 人数
  String? percent; // 百分比%

  AgentUserTypeParticipates({
    this.type,
    this.typeTxt,
    this.count,
    this.percent,
  });

  factory AgentUserTypeParticipates.fromRawJson(String str) =>
      AgentUserTypeParticipates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgentUserTypeParticipates.fromJson(Map<String, dynamic> json) =>
      AgentUserTypeParticipates(
        type: json["type"],
        typeTxt: json["typeTxt"],
        count: json["count"],
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "typeTxt": typeTxt,
        "count": count,
        "percent": percent,
      };
}
