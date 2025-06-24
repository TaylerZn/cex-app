import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';

class CommunityMessageNotificationItemModel {
  String? avatar;
  dynamic timeDate;
  String? userName;
  String? messageTitle;
  String? messageContent;
  String? messageUserId;

  /**
   *  账户被@时 =1
      帖子被引用时 =2
      帖子被回复时 =3
      评论被置顶时 = 4
      帖子被点赞时 =5
      投票结束时 =6
   */
  int? messageType;

  CommunityMessageNotificationItemModel({
    this.avatar,
    this.timeDate,
    this.userName,
    this.messageTitle,
    this.messageContent,
    this.messageType,
    this.messageUserId,
  });
  String get timeString {
    return RelativeDateFormat.relativeDateFormat(timeDate);
  }

  String get messageTypeString {
    switch (messageType) {
      case 1:
        return 'mention'; //'账户被@时';
      case 2:
        return 'quote'; //'帖子被引用时';
      case 3:
        return 'reply'; //'帖子被回复时';
      case 4:
        return 'pinned'; //'评论被置顶时';
      case 5:
        return 'like'; //'帖子被点赞时';
      case 6:
        return 'voteEnd'; //'投票结束时';
      default:
        return '';
    }
  }
}
