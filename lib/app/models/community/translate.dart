import 'dart:convert';

class IsTranslateModel {
  bool? isTranslate;
  String? sourceLanguage;

  IsTranslateModel({this.isTranslate, this.sourceLanguage});

  factory IsTranslateModel.fromRawJson(String str) =>
      IsTranslateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IsTranslateModel.fromJson(Map<String, dynamic> json) =>
      IsTranslateModel(
        isTranslate: json["isTranslate"],
        sourceLanguage: json["sourceLanguage"],
      );

  Map<String, dynamic> toJson() => {
        "isTranslate": isTranslate,
        "sourceLanguage": sourceLanguage,
      };
}

class LanguageTranslateModel {
  String? translateTitle;
  String? translateContent;

  LanguageTranslateModel({
    this.translateTitle,
    this.translateContent,
  });

  factory LanguageTranslateModel.fromRawJson(String str) =>
      LanguageTranslateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LanguageTranslateModel.fromJson(Map<String, dynamic> json) =>
      LanguageTranslateModel(
        translateTitle: json["translateTitle"],
        translateContent: json["translateContent"],
      );

  Map<String, dynamic> toJson() => {
        "translateTitle": translateTitle,
        "translateContent": translateContent,
      };
}
