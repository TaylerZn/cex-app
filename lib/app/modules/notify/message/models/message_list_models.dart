import 'dart:convert';

class MessageListModel {
  int id;
  String name;

  MessageListModel({
    required this.id,
    required this.name,
  });

  factory MessageListModel.fromRawJson(String str) =>
      MessageListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageListModel.fromJson(Map<String, dynamic> json) =>
      MessageListModel(
        id: json["id"],
        name: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
