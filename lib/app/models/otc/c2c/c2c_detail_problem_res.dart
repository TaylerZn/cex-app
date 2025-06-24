import 'dart:convert';

C2CDetailProblemRes c2CDetailProblemResFromJson(String str) =>
    C2CDetailProblemRes.fromJson(json.decode(str));

String c2CDetailProblemResToJson(C2CDetailProblemRes data) =>
    json.encode(data.toJson());

class C2CDetailProblemRes {
  final RqInfo? rqInfo;
  final List<RqReplyList>? rqReplyList;

  C2CDetailProblemRes({
    this.rqInfo,
    this.rqReplyList,
  });

  C2CDetailProblemRes copyWith({
    RqInfo? rqInfo,
    List<RqReplyList>? rqReplyList,
  }) =>
      C2CDetailProblemRes(
        rqInfo: rqInfo ?? this.rqInfo,
        rqReplyList: rqReplyList ?? this.rqReplyList,
      );

  factory C2CDetailProblemRes.fromJson(Map<String, dynamic> json) =>
      C2CDetailProblemRes(
        rqInfo: json["rqInfo"] == null ? null : RqInfo.fromJson(json["rqInfo"]),
        rqReplyList: json["rqReplyList"] == null
            ? []
            : List<RqReplyList>.from(
                json["rqReplyList"]!.map((x) => RqReplyList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rqInfo": rqInfo?.toJson(),
        "rqReplyList": rqReplyList == null
            ? []
            : List<dynamic>.from(rqReplyList!.map((x) => x.toJson())),
      };
}

class RqInfo {
  final int? id;
  final int? userId;
  final String? rqDescribe;
  final int? rqType;
  final int? rqStatus;
  final int? ctime;
  final int? mtime;
  final String? rqTypeName;
  final String? rqStatusName;
  final dynamic imageData;
  final dynamic imageDataStr;
  final int? opUid;

  RqInfo({
    this.id,
    this.userId,
    this.rqDescribe,
    this.rqType,
    this.rqStatus,
    this.ctime,
    this.mtime,
    this.rqTypeName,
    this.rqStatusName,
    this.imageData,
    this.imageDataStr,
    this.opUid,
  });

  RqInfo copyWith({
    int? id,
    int? userId,
    String? rqDescribe,
    int? rqType,
    int? rqStatus,
    int? ctime,
    int? mtime,
    String? rqTypeName,
    String? rqStatusName,
    dynamic imageData,
    dynamic imageDataStr,
    int? opUid,
  }) =>
      RqInfo(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        rqDescribe: rqDescribe ?? this.rqDescribe,
        rqType: rqType ?? this.rqType,
        rqStatus: rqStatus ?? this.rqStatus,
        ctime: ctime ?? this.ctime,
        mtime: mtime ?? this.mtime,
        rqTypeName: rqTypeName ?? this.rqTypeName,
        rqStatusName: rqStatusName ?? this.rqStatusName,
        imageData: imageData ?? this.imageData,
        imageDataStr: imageDataStr ?? this.imageDataStr,
        opUid: opUid ?? this.opUid,
      );

  factory RqInfo.fromJson(Map<String, dynamic> json) => RqInfo(
        id: json["id"],
        userId: json["userId"],
        rqDescribe: json["rqDescribe"],
        rqType: json["rqType"],
        rqStatus: json["rqStatus"],
        ctime: json["ctime"],
        mtime: json["mtime"],
        rqTypeName: json["rqTypeName"],
        rqStatusName: json["rqStatusName"],
        imageData: json["imageData"],
        imageDataStr: json["imageDataStr"],
        opUid: json["opUid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "rqDescribe": rqDescribe,
        "rqType": rqType,
        "rqStatus": rqStatus,
        "ctime": ctime,
        "mtime": mtime,
        "rqTypeName": rqTypeName,
        "rqStatusName": rqStatusName,
        "imageData": imageData,
        "imageDataStr": imageDataStr,
        "opUid": opUid,
      };
}

class RqReplyList {
  final int? id;
  final int? rqId;
  final int? userType;
  final int? userId;
  final String? replayContent;
  final int? contentType;
  final int? ctime;
  final dynamic imageData;
  String timeStr = '';

  RqReplyList({
    this.id,
    this.rqId,
    this.userType,
    this.userId,
    this.replayContent,
    this.contentType,
    this.ctime,
    this.imageData,
  });

  RqReplyList copyWith({
    int? id,
    int? rqId,
    int? userType,
    int? userId,
    String? replayContent,
    int? contentType,
    int? ctime,
    dynamic imageData,
  }) =>
      RqReplyList(
        id: id ?? this.id,
        rqId: rqId ?? this.rqId,
        userType: userType ?? this.userType,
        userId: userId ?? this.userId,
        replayContent: replayContent ?? this.replayContent,
        contentType: contentType ?? this.contentType,
        ctime: ctime ?? this.ctime,
        imageData: imageData ?? this.imageData,
      );

  factory RqReplyList.fromJson(Map<String, dynamic> json) => RqReplyList(
        id: json["id"],
        rqId: json["rqId"],
        userType: json["userType"],
        userId: json["userId"],
        replayContent: json["replayContent"],
        contentType: json["contentType"],
        ctime: json["ctime"],
        imageData: json["imageData"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rqId": rqId,
        "userType": userType,
        "userId": userId,
        "replayContent": replayContent,
        "contentType": contentType,
        "ctime": ctime,
        "imageData": imageData,
      };
}
