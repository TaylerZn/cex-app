import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';

class FollowkolRelationListModel with PagingModel, PagingError {
  num? count;
  List<FollowkolRelationList>? list;

  FollowkolRelationListModel({this.count, this.list});

  FollowkolRelationListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <FollowkolRelationList>[];
      json['list'].forEach((v) {
        list!.add(FollowkolRelationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowkolRelationList {
  String? userName;
  num? startNum;
  String? imgUrl;
  num? cTime;
  num userId = 0;
  int? levelType;

  FollowkolRelationList({this.userName, this.startNum, this.imgUrl, this.cTime, this.userId = 0});

  FollowkolRelationList.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    startNum = json['startNum'];
    imgUrl = json['imgUrl'];
    cTime = json['cTime'];
    userId = json['userId'] ?? 0;
    levelType = json['levelType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['startNum'] = startNum;
    data['ImgUrl'] = imgUrl;
    data['cTime'] = cTime;
    data['userId'] = userId;
    data['levelType'] = levelType;

    return data;
  }

  String get icon => imgUrl != null && imgUrl!.isNotEmpty ? imgUrl! : "default/avatar_default".pngAssets();
  String get name => userName ?? '--';
  String get startStr => (startNum ?? 0).toString();
  String get createdTime => MyTimeUtil.timestampToStr((cTime ?? 0).toInt());
}
