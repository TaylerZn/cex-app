import 'dart:convert';

class TopicTalkingPointListModel {
  List<HotTopicModel>? talkingPointList;

  TopicTalkingPointListModel({
    this.talkingPointList,
  });

  factory TopicTalkingPointListModel.fromRawJson(String str) =>
      TopicTalkingPointListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopicTalkingPointListModel.fromJson(Map<String, dynamic> json) =>
      TopicTalkingPointListModel(
        talkingPointList: json["talkingPointList"] == null
            ? []
            : List<HotTopicModel>.from(json["talkingPointList"]!
                .map((x) => HotTopicModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "talkingPointList": talkingPointList == null
            ? []
            : List<dynamic>.from(talkingPointList!.map((x) => x.toJson())),
      };
}

class TalkingPointInfoModel {
  HotTopicModel? talkingPointInfo;

  TalkingPointInfoModel({
    this.talkingPointInfo,
  });

  factory TalkingPointInfoModel.fromRawJson(String str) =>
      TalkingPointInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TalkingPointInfoModel.fromJson(Map<String, dynamic> json) =>
      TalkingPointInfoModel(
        talkingPointInfo: json["talkingPointInfo"] == null
            ? null
            : HotTopicModel.fromJson(json["talkingPointInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "talkingPointInfo": talkingPointInfo?.toJson(),
      };
}

class HotTopicModel {
  String? name;
  int? pageViewNum;
  int? quoteNum;
  int? sort;

  HotTopicModel({this.name, this.pageViewNum, this.quoteNum, this.sort});

  factory HotTopicModel.fromRawJson(String str) =>
      HotTopicModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HotTopicModel.fromJson(Map<String, dynamic> json) => HotTopicModel(
        name: json["name"],
        pageViewNum: json["pageViewNum"],
        quoteNum: json["quoteNum"],
        sort: json["sort"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "pageViewNum": pageViewNum,
        "quoteNum": quoteNum,
        "sort": sort,
      };
  String get displayName {
    if((name?.split('#').length ?? 0) <=1){
      return '${name}' ?? '';
    }
    return name?.split('#')[1] ?? '';
  }
}
