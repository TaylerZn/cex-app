import 'dart:convert';

import 'package:nt_app_flutter/app/models/user/res/user.dart';

class SafeGoModel {
  dynamic type;
  VerificationDataModel? verificatioData;

  SafeGoModel({
    this.type,
    this.verificatioData,
  });

  factory SafeGoModel.fromRawJson(String str) =>
      SafeGoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SafeGoModel.fromJson(Map<String, dynamic> json) => SafeGoModel(
        type: json["type"],
        verificatioData: json["verificatioData"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "verificatioData": verificatioData,
      };
}
