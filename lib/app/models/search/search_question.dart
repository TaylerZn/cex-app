import 'dart:convert';

class SearchQuestionsModel {
  SearchQuestionsModelQuestions? questions;

  SearchQuestionsModel({
    this.questions,
  });

  factory SearchQuestionsModel.fromRawJson(String str) =>
      SearchQuestionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchQuestionsModel.fromJson(Map<String, dynamic> json) =>
      SearchQuestionsModel(
        questions: json["questions"] == null
            ? null
            : SearchQuestionsModelQuestions.fromJson(json["questions"]),
      );

  Map<String, dynamic> toJson() => {
        "questions": questions?.toJson(),
      };
}

class SearchQuestionsModelQuestions {
  int? count;
  int? pageSize;
  int? page;
  List<SearchQuestionsModelQuestionsList>? list;

  SearchQuestionsModelQuestions({
    this.count,
    this.pageSize,
    this.page,
    this.list,
  });

  factory SearchQuestionsModelQuestions.fromRawJson(String str) =>
      SearchQuestionsModelQuestions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchQuestionsModelQuestions.fromJson(Map<String, dynamic> json) =>
      SearchQuestionsModelQuestions(
        count: json["count"],
        pageSize: json["pageSize"],
        page: json["page"],
        list: json["list"] == null
            ? []
            : List<SearchQuestionsModelQuestionsList>.from(json["list"]!
                .map((x) => SearchQuestionsModelQuestionsList.fromJson(x))),
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

class SearchQuestionsModelQuestionsList {
  int? id;
  int? articleTypeId;
  String? title;
  int? publisherId;
  int? ctime;
  int? mtime;
  String? lang;
  String? fileName;
  int? footerFlag;
  int? sort;
  String? content;
  String? articleTypeName;
  dynamic publisher;

  SearchQuestionsModelQuestionsList({
    this.id,
    this.articleTypeId,
    this.title,
    this.publisherId,
    this.ctime,
    this.mtime,
    this.lang,
    this.fileName,
    this.footerFlag,
    this.sort,
    this.content,
    this.articleTypeName,
    this.publisher,
  });

  factory SearchQuestionsModelQuestionsList.fromRawJson(String str) =>
      SearchQuestionsModelQuestionsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchQuestionsModelQuestionsList.fromJson(
          Map<String, dynamic> json) =>
      SearchQuestionsModelQuestionsList(
        id: json["id"],
        articleTypeId: json["articleTypeId"],
        title: json["title"],
        publisherId: json["publisherId"],
        ctime: json["ctime"],
        mtime: json["mtime"],
        lang: json["lang"],
        fileName: json["fileName"],
        footerFlag: json["footerFlag"],
        sort: json["sort"],
        content: json["content"],
        articleTypeName: json["articleTypeName"],
        publisher: json["publisher"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "articleTypeId": articleTypeId,
        "title": title,
        "publisherId": publisherId,
        "ctime": ctime,
        "mtime": mtime,
        "lang": lang,
        "fileName": fileName,
        "footerFlag": footerFlag,
        "sort": sort,
        "content": content,
        "articleTypeName": articleTypeName,
        "publisher": publisher,
      };
}
