import 'dart:convert';

class DefaultPicturesModel {
  List<String>? url;

  DefaultPicturesModel({
    this.url,
  });

  factory DefaultPicturesModel.fromRawJson(String str) =>
      DefaultPicturesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DefaultPicturesModel.fromJson(Map<String, dynamic> json) =>
      DefaultPicturesModel(
        url: json["url"] == null
            ? []
            : List<String>.from(json["url"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? [] : List<dynamic>.from(url!.map((x) => x)),
      };
}
