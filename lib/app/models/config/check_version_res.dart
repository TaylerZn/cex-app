import 'dart:convert';

class CheckVersionV1Model {
  int? id;
  int? build;
  String? version;
  String? remark;
  int? forceUpdate;
  int? systemType;
  int? status;
  String? downloadUrl;
  String? title;
  String? content;

  CheckVersionV1Model({
    this.id,
    this.build,
    this.version,
    this.remark,
    this.forceUpdate,
    this.systemType,
    this.status,
    this.downloadUrl,
    this.title,
    this.content,
  });

  factory CheckVersionV1Model.fromRawJson(String str) =>
      CheckVersionV1Model.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckVersionV1Model.fromJson(Map<String, dynamic> json) =>
      CheckVersionV1Model(
        id: json["id"],
        build: json["build"],
        version: json["version"],
        remark: json["remark"],
        forceUpdate: json["forceUpdate"],
        systemType: json["systemType"],
        status: json["status"],
        downloadUrl: json["downloadUrl"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "build": build,
        "version": version,
        "remark": remark,
        "forceUpdate": forceUpdate,
        "systemType": systemType,
        "status": status,
        "downloadUrl": downloadUrl,
        "title": title,
        "content": content,
      };
}
