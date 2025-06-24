import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';

class CommunityMessageItemModel {
  String? iconSrc;
  String? title;
  String? subtitle;
  String? time;
  int? notificationCount;
  bool isHighlighted;
  dynamic timeData;
  int? msgId;

  CommunityMessageItemModel(
      {this.iconSrc,
      this.title,
      this.subtitle,
      this.time,
      this.notificationCount,
      this.timeData,
      this.msgId,
      this.isHighlighted = false});

  static String relativeDateFormat(dynamic timeData) {
    return RelativeDateFormat.relativeDateFormat(timeData);
  }
}
