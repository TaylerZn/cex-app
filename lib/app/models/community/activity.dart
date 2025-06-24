import 'dart:convert';

class CmsAdvertModel {
  List<CmsAdvertListModel>? list;

  CmsAdvertModel({
    this.list,
  });

  factory CmsAdvertModel.fromRawJson(String str) =>
      CmsAdvertModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CmsAdvertModel.fromJson(Map<String, dynamic> json) => CmsAdvertModel(
        list: json["list"] == null
            ? []
            : List<CmsAdvertListModel>.from(
                json["list"]!.map((x) => CmsAdvertListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class CmsAdvertListModel {
  int? id;
  String? title;
  String? lang;
  String? clientType;
  int? urlType;
  String? url;
  int? position;
  int? sort;
  String? imgUrl;

  CmsAdvertListModel({
    this.id,
    this.title,
    this.lang,
    this.clientType,
    this.urlType,
    this.url,
    this.position,
    this.sort,
    this.imgUrl,
  });

  factory CmsAdvertListModel.fromRawJson(String str) =>
      CmsAdvertListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CmsAdvertListModel.fromJson(Map<String, dynamic> json) =>
      CmsAdvertListModel(
        id: json["id"],
        title: json["title"],
        lang: json["lang"],
        clientType: json["clientType"],
        urlType: json["urlType"],
        url: json["url"],
        position: json["position"],
        sort: json["sort"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "lang": lang,
        "clientType": clientType,
        "urlType": urlType,
        "url": url,
        "position": position,
        "sort": sort,
        "imgUrl": imgUrl,
      };
}
