import 'dart:ui';

import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';

class FollowkolProfitListModel with PagingModel, PagingError {
  num? count;
  List<FollowkolProfitList>? list;

  FollowkolProfitListModel({this.count, this.list});

  FollowkolProfitListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <FollowkolProfitList>[];
      json['list'].forEach((v) {
        list!.add(FollowkolProfitList.fromJson(v));
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

class FollowkolProfitList with PagingModel {
  String? name;
  String? imgUrl;
  num todayProfit = 0;
  num expectedProfit = 0;
  num? followTime;

  FollowkolProfitList({this.name, this.imgUrl, this.todayProfit = 0, this.expectedProfit = 0, this.followTime});

  FollowkolProfitList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imgUrl = json['imgUrl'];
    todayProfit = json['todayProfit'] ?? 0;
    expectedProfit = json['expectedProfit'] ?? 0;
    followTime = json['followTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imgUrl'] = imgUrl;
    data['todayProfit|1'] = todayProfit;
    data['expectedProfit|1'] = expectedProfit;
    data['followTime'] = followTime;
    return data;
  }

  String get icon => imgUrl != null && imgUrl!.isNotEmpty ? imgUrl! : "default/avatar_default".pngAssets();

  String get userName => name ?? '--';
  String get followTimeStr => '跟单时间: ${MyTimeUtil.timestampToStr((followTime ?? 0).toInt())}';

  String get todayProfitStr => getmConvert(todayProfit);
  Color get todayProfitColor => getmColor(todayProfit);

  String get expectedProfitStr => getmConvert(expectedProfit);
  Color get expectedProfitColor => getmColor(expectedProfit);
}

class FollowkoSwitchModel {
  num? copySwitch;

  FollowkoSwitchModel({this.copySwitch});

  FollowkoSwitchModel.fromJson(Map<String, dynamic> json) {
    copySwitch = json['copySwitch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['copySwitch'] = copySwitch;
    return data;
  }
}
