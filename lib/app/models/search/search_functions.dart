import 'dart:convert';

import 'package:nt_app_flutter/app/models/community/community.dart';

//搜索帖子
class SearchFunctionsModel {
  SearchFunctionsModelTopics? functions;

  SearchFunctionsModel({
    this.functions,
  });

  factory SearchFunctionsModel.fromRawJson(String str) =>
      SearchFunctionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFunctionsModel.fromJson(Map<String, dynamic> json) =>
      SearchFunctionsModel(
        functions: json["functions"] == null
            ? null
            : SearchFunctionsModelTopics.fromJson(json["functions"]),
      );

  Map<String, dynamic> toJson() => {
        "functions": functions?.toJson(),
      };
}

class SearchFunctionsModelTopics {
  int? count;
  int? pageSize;
  int? page;
  List<FunctionsPageListModel>? list;

  SearchFunctionsModelTopics({
    this.count,
    this.pageSize,
    this.page,
    this.list,
  });

  factory SearchFunctionsModelTopics.fromRawJson(String str) =>
      SearchFunctionsModelTopics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFunctionsModelTopics.fromJson(Map<String, dynamic> json) =>
      SearchFunctionsModelTopics(
        count: json["count"],
        pageSize: json["pageSize"],
        page: json["page"],
        list: json["list"] == null
            ? []
            : List<FunctionsPageListModel>.from(
                json["list"]!.map((x) => FunctionsPageListModel.fromJson(x))),
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

class FunctionsPageListModel {
  String? title;
  String? nativeUrl;
  String? httpUrl;
  String? imageUrl;

  FunctionsPageListModel({
    this.title,
    this.nativeUrl,
    this.httpUrl,
    this.imageUrl,
  });

  factory FunctionsPageListModel.fromRawJson(String str) =>
      FunctionsPageListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FunctionsPageListModel.fromJson(Map<String, dynamic> json) =>
      FunctionsPageListModel(
        title: json["title"],
        nativeUrl: json["nativeUrl"],
        httpUrl: json["httpUrl"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "nativeUrl": nativeUrl,
        "httpUrl": httpUrl,
        "imageUrl": imageUrl,
      };
}
