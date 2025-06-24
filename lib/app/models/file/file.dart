import 'dart:convert';

class CommonuploadimgModel {
  String? filename;
  String? filenameStr;
  String? baseImageUrl;

  CommonuploadimgModel({
    this.filename,
    this.filenameStr,
    this.baseImageUrl,
  });

  factory CommonuploadimgModel.fromRawJson(String str) =>
      CommonuploadimgModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommonuploadimgModel.fromJson(Map<String, dynamic> json) =>
      CommonuploadimgModel(
        filename: json["filename"],
        filenameStr: json["filenameStr"],
        baseImageUrl: json["base_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "filenameStr": filenameStr,
        "base_image_url": baseImageUrl,
      };
}
