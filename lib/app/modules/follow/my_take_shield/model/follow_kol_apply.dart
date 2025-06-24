import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';

class FollowkolApplyModel with PagingModel, PagingError {
  num? count;
  List<FollowkolApply>? list;
  var isSelected = false;
  var isSelectedAll = false.obs;

  FollowkolApplyModel({this.count, this.list});

  FollowkolApplyModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <FollowkolApply>[];
      json['list'].forEach((v) {
        list!.add(FollowkolApply.fromJson(v));
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

class FollowkolApply {
  String? name;
  String? imgUrl;
  num? ctime;
  num userId = 0;
  var isSelected = false.obs;
  int? levelType;

  FollowkolApply({this.name, this.imgUrl, this.ctime, this.levelType});

  FollowkolApply.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imgUrl = json['imgUrl'];
    ctime = json['ctime'];
    userId = json['userId'] ?? 0;
    levelType = json['levelType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imgUrl'] = imgUrl;
    data['ctime'] = ctime;
    data['userId'] = userId;
    data['levelType'] = levelType;

    return data;
  }

  String get icon => imgUrl != null && imgUrl!.isNotEmpty ? imgUrl! : "default/avatar_default".pngAssets();
  String get userNmae => name != null ? name! : '--';
  String get createdTime => MyTimeUtil.timestampToStr((ctime ?? 0).toInt());
}
