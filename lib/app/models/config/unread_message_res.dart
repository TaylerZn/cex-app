import 'package:nt_app_flutter/app/models/config/system_message_res.dart';

class UnReadMessageRes {
  int unReadCount;
  SystemMessageInfo latest;
  String allReadCount;

  UnReadMessageRes({
    required this.unReadCount,
    required this.latest,
    required this.allReadCount,
  });

  factory UnReadMessageRes.fromJson(Map<String, dynamic> json) =>
      UnReadMessageRes(
        unReadCount: json["unReadCount"],
        latest: SystemMessageInfo.fromJson(json["latest"]),
        allReadCount: json["allReadCount"],
      );

  Map<String, dynamic> toJson() => {
        "unReadCount": unReadCount,
        "latest": latest.toJson(),
        "allReadCount": allReadCount,
      };
}
