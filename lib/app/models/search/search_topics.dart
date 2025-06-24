import 'dart:convert';

import 'package:nt_app_flutter/app/models/community/community.dart';

//搜索帖子
class SearchTopicsModel {
  SearchTopicsModelTopics? topics;

  SearchTopicsModel({
    this.topics,
  });

  factory SearchTopicsModel.fromRawJson(String str) =>
      SearchTopicsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchTopicsModel.fromJson(Map<String, dynamic> json) =>
      SearchTopicsModel(
        topics: json["topics"] == null
            ? null
            : SearchTopicsModelTopics.fromJson(json["topics"]),
      );

  Map<String, dynamic> toJson() => {
        "topics": topics?.toJson(),
      };
}

class SearchTopicsModelTopics {
  int? count;
  int? pageSize;
  int? page;
  List<TopicdetailModel>? list;

  SearchTopicsModelTopics({
    this.count,
    this.pageSize,
    this.page,
    this.list,
  });

  factory SearchTopicsModelTopics.fromRawJson(String str) =>
      SearchTopicsModelTopics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchTopicsModelTopics.fromJson(Map<String, dynamic> json) =>
      SearchTopicsModelTopics(
        count: json["count"],
        pageSize: json["pageSize"],
        page: json["page"],
        list: json["list"] == null
            ? []
            : List<TopicdetailModel>.from(
                json["list"]!.map((x) => TopicdetailModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pageSize": pageSize,
        "page": page,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}
