import 'dart:ui';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowkolSetListModel with PagingModel, PagingError {
  num? count;
  List<FollowkolSetList>? list;

  FollowkolSetListModel({this.count, this.list});

  FollowkolSetListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <FollowkolSetList>[];
      json['list'].forEach((v) {
        list!.add(FollowkolSetList.fromJson(v));
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

class FollowkolSetList with PagingModel {
  String? name;
  String? imgUrl;
  num sumAmount = 0;
  num sumShareProfit = 0;
  num? followTime;

  FollowkolSetList({this.name, this.imgUrl, this.sumAmount = 0, this.sumShareProfit = 0, this.followTime});

  FollowkolSetList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imgUrl = json['imgUrl'];
    sumAmount = json['sumAmount'] ?? 0;
    sumShareProfit = json['sumShareProfit'] ?? 0;
    followTime = json['followTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imgUrl'] = imgUrl;
    data['sumAmount'] = sumAmount;
    data['sumShareProfit'] = sumShareProfit;
    data['followTime'] = followTime;
    return data;
  }

  String get icon => imgUrl != null && imgUrl!.isNotEmpty ? imgUrl! : "default/avatar_default".pngAssets();

  String get userName => name ?? '--';
  String get followTimeStr => '${LocaleKeys.follow69.tr}: ${MyTimeUtil.timestampToStr((followTime ?? 0).toInt())}';

  String get sumAmountStr => getmConvert(sumAmount);
  Color get sumAmountColor => getmColor(sumAmount);

  String get sumShareProfitStr => getmConvert(sumShareProfit);
  Color get sumShareProfitColor => getmColor(sumShareProfit);
}
