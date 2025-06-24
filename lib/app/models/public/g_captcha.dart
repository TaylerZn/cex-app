import 'dart:convert';

class GetReCaptchaIdModel {
  String reCaptchaId;
  String reCaptchaIdV2;

  GetReCaptchaIdModel({required this.reCaptchaId, required this.reCaptchaIdV2});

  factory GetReCaptchaIdModel.fromRawJson(String str) =>
      GetReCaptchaIdModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetReCaptchaIdModel.fromJson(Map<String, dynamic> json) =>
      GetReCaptchaIdModel(
        reCaptchaId: json["reCaptchaId"],
        reCaptchaIdV2: json["reCaptchaIdV2"],
      );

  Map<String, dynamic> toJson() => {
        "reCaptchaId": reCaptchaId,
        "reCaptchaIdV2": reCaptchaIdV2,
      };
}
