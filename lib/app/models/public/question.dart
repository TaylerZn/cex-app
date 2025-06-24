import 'dart:convert';

class QuestionProblemTipListModel {
  List<QuestionProblemTipList>? rqTypeList;

  QuestionProblemTipListModel({
    this.rqTypeList,
  });

  factory QuestionProblemTipListModel.fromRawJson(String str) =>
      QuestionProblemTipListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionProblemTipListModel.fromJson(Map<String, dynamic> json) =>
      QuestionProblemTipListModel(
        rqTypeList: json["rqTypeList"] == null
            ? []
            : List<QuestionProblemTipList>.from(json["rqTypeList"]!
                .map((x) => QuestionProblemTipList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rqTypeList": rqTypeList == null
            ? []
            : List<dynamic>.from(rqTypeList!.map((x) => x.toJson())),
      };
}

class QuestionProblemTipList {
  int code;
  String? value;
  bool? select;
  QuestionProblemTipList(
      {required this.code, required this.value, this.select = false});

  factory QuestionProblemTipList.fromRawJson(String str) =>
      QuestionProblemTipList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionProblemTipList.fromJson(Map<String, dynamic> json) =>
      QuestionProblemTipList(
        code: json["code"],
        value: json["value"],
        select: json["select"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "value": value,
        "select": select,
      };
}
