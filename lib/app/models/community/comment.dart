import 'dart:convert';

class CommunityCommentPageListModel {
  List<CommunityCommentItem>? data;
  int total;
  int totalPage;
  int pageSize;
  int currentPage;

  CommunityCommentPageListModel({
    this.data,
    required this.total,
    required this.totalPage,
    required this.pageSize,
    required this.currentPage,
  });

  factory CommunityCommentPageListModel.fromRawJson(String str) =>
      CommunityCommentPageListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommunityCommentPageListModel.fromJson(Map<String, dynamic> json) =>
      CommunityCommentPageListModel(
        data: json["data"] == null
            ? []
            : List<CommunityCommentItem>.from(
                json["data"]!.map((x) => CommunityCommentItem.fromJson(x))),
        total: json["total"],
        totalPage: json["totalPage"],
        pageSize: json["pageSize"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
        "totalPage": totalPage,
        "pageSize": pageSize,
        "currentPage": currentPage,
      };
}

class CommunityCommentItem {
  String? commentContent;
  String? preMemberType;
  String? memberType;
  String? createBy;
  String? createTime;
  int? createTimeTime;
  String? preMemberEmail;
  String? preMemberName;
  int? id;
  String? commentNo;
  String? preMemberHeadUrl;
  String? topicNo;
  num memberId;
  String? memberName;
  String? memberEmail;
  dynamic memberHeadUrl;
  String? preCommentNo;
  int? preMemberId;
  int? commentLevel;
  int? levelType;
  // 评论闪烁效果
  bool shouldFlash;
  num? praiseNum;
  bool? praiseFlag;
  bool? isTranslate;
  bool? topFlag;
  CommunityCommentPageListModel? childComments;

  CommunityCommentItem({
    this.commentContent,
    this.preMemberType,
    this.memberType,
    this.isTranslate,
    this.createBy,
    this.createTime,
    this.preMemberEmail,
    this.preMemberName,
    this.id,
    this.praiseFlag,
    this.commentNo,
    this.preMemberHeadUrl,
    this.topicNo,
    this.praiseNum,
    required this.memberId,
    this.memberName,
    this.memberEmail,
    this.memberHeadUrl,
    this.preCommentNo,
    this.preMemberId,
    this.commentLevel,
    this.levelType,
    this.topFlag,
    this.createTimeTime,
    this.shouldFlash = false,
    this.childComments,
  });

  factory CommunityCommentItem.fromRawJson(String str) =>
      CommunityCommentItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommunityCommentItem.fromJson(Map<String, dynamic> json) =>
      CommunityCommentItem(

        commentContent: json["commentContent"],
        preMemberType: json["preMemberType"],
        memberType: json["memberType"],
        praiseNum: json['praiseNum'],
        createBy: json["createBy"],
        isTranslate : json['isTranslate'] ?? true,
        topFlag: json['topFlag'] ?? false,
        praiseFlag: json['praiseFlag'] ?? false,
        createTime: json["createTime"],
        createTimeTime : json['createTimeTime'],
        preMemberEmail: json["preMemberEmail"],
        preMemberName: json["preMemberName"],
        id: json["id"],
        commentNo: json["commentNo"],
        preMemberHeadUrl: json["preMemberHeadUrl"],
        topicNo: json["topicNo"],
        memberId: json["memberId"] ?? 0,
        memberName: json["memberName"],
        memberEmail: json["memberEmail"],
        memberHeadUrl: json["memberHeadUrl"],
        preCommentNo: json["preCommentNo"],
        preMemberId: json["preMemberId"],
        commentLevel: json["commentLevel"],
        levelType: json["levelType"],
        shouldFlash: json["shouldFlash"] ?? false,
        childComments: json["childComments"] == null
            ? null
            : CommunityCommentPageListModel.fromJson(json["childComments"]),
      );

  Map<String, dynamic> toJson() => {
        "commentContent": commentContent,
        "preMemberType": preMemberType,
        "memberType": memberType,
        "createBy": createBy,
        "createTime": createTime,
        'isTranslate' : isTranslate,
        "preMemberEmail": preMemberEmail,
        "preMemberName": preMemberName,
        "id": id,
        "commentNo": commentNo,
        "preMemberHeadUrl": preMemberHeadUrl,
        "topicNo": topicNo,
        "memberId": memberId,
        "memberName": memberName,
        "memberEmail": memberEmail,
        'praiseNum': praiseNum,
        "memberHeadUrl": memberHeadUrl,
        "preCommentNo": preCommentNo,
        "preMemberId": preMemberId,
        "commentLevel": commentLevel,
        "levelType": levelType,
        "shouldFlash": shouldFlash,
        "childComments": childComments?.toJson(),
      };
}
