import 'dart:ui';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';

class FollowMyManageListModel with PagingModel, PagingError {
  num? count;
  List<FollowMyManageList>? list;
  var isSelected = false;
  var isSelectedAll = false.obs;

  FollowMyManageListModel({this.count, this.list});

  FollowMyManageListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <FollowMyManageList>[];
      json['list'].forEach((v) {
        list!.add(FollowMyManageList.fromJson(v));
      });
    }
    isSelected = json['isSelected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    data['isSelected'] = isSelected;
    return data;
  }
}

class FollowMyManageList with PagingModel {
  num? uid;
  num? total;
  num? followTime;
  num? followType;
  num followProfit = 0;
  num? totalPNL;
  num? positionRate;

  String? username;
  String? imgUrl;
  num? isBlacklistedUsers;
  num? isDisableUsers;
  var isSelected = false.obs;
  FollowMyManageList(
      {this.uid,
      this.total,
      this.followTime,
      this.followType,
      this.followProfit = 0,
      this.username,
      this.imgUrl,
      this.isBlacklistedUsers,
      this.isDisableUsers});

  FollowMyManageList.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    total = json['total'];
    followTime = json['followTime'];
    followType = json['followType'];
    followProfit = json['followProfit'] ?? 0;
    username = json['username'];
    imgUrl = json['imgUrl'];
    isBlacklistedUsers = json['isBlacklistedUsers'];
    isDisableUsers = json['isDisableUsers'];
    totalPNL = json['totalPNL'];
    positionRate = json['positionRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['total'] = total;
    data['followTime'] = followTime;
    data['followType'] = followType;
    data['followProfit'] = followProfit;
    data['username'] = username;
    data['imgUrl'] = imgUrl;
    data['isBlacklistedUsers'] = isBlacklistedUsers;
    data['isDisableUsers'] = isDisableUsers;
    data['totalPNL'] = totalPNL;
    data['positionRate'] = positionRate;
    return data;
  }

  String get icon => imgUrl != null && imgUrl!.isNotEmpty ? imgUrl! : "default/avatar_default".pngAssets();
  String get name => username != null ? username! : '--';
  String get followProfitStr => getmConvert(followProfit);
  Color get followProfitColor => getmColor(followProfit);
  String get followTimeStr => MyTimeUtil.timestampToStr((followTime ?? 0).toInt());
  String get positionRateStr => '${positionRate ?? 0}%';
  String get totalPNLStr => getmConvert(totalPNL);
  Color get totalPNLColor => getmColor(totalPNL);

  String get positionRateEditStr => '${positionRate ?? 0}';
}
