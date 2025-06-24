import 'dart:convert';

class PopularTagsModel {
    List<String> hot;

    PopularTagsModel({
        required this.hot,
    });

    factory PopularTagsModel.fromRawJson(String str) =>
     PopularTagsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PopularTagsModel.fromJson(Map<String, dynamic> json) => PopularTagsModel(
        hot: List<String>.from(json["hot"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "hot": List<dynamic>.from(hot.map((x) => x)),
    };
}
