import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///筛选项 枚举
enum FollowTakerType {
  overview,
  performance,
  currentSingle,
  historySingle,
  userReview,
  follower,
  likeFavourite;

  String get value => [
        LocaleKeys.follow459.tr,
        LocaleKeys.follow121.tr,
        LocaleKeys.follow122.tr,
        LocaleKeys.follow123.tr,
        LocaleKeys.follow462.tr,
        LocaleKeys.follow124.tr,
        LocaleKeys.community119.tr
      ][index]; //点赞 收藏
}

enum FollowViewType {
  customerToCustomer,
  traderToCustomer,
  mySelfToCustomer,
  traderToTrader,
  mySelfToTrader,
  customerToTrader,
  other;

  List<FollowAction> get followTab => (this == FollowViewType.traderToTrader ||
          this == FollowViewType.mySelfToTrader ||
          this == FollowViewType.traderToTrader ||
          this == FollowViewType.customerToTrader)
      ? [FollowAction.follow, FollowAction.fans]
      : [FollowAction.follow];
  bool get showFollowTab =>
      this == FollowViewType.mySelfToCustomer ||
      this == FollowViewType.traderToTrader ||
      this == FollowViewType.mySelfToTrader ||
      this == FollowViewType.traderToTrader ||
      this == FollowViewType.customerToTrader;
}

enum FollowAction {
  follow,
  none,
  fans;

  String title() {
    switch (this) {
      case follow:
        return LocaleKeys.community111.tr; //'正在关注';
      case none:
        return '';
      case fans:
        return LocaleKeys.community109.tr; //'关注者';
    }
  }

  String key() {
    switch (this) {
      case follow:
        return 'follow';
      case none:
        return 'empty';
      case fans:
        return 'fans';
    }
  }
}

class FollowTransLateModel {
  String? translateContent;
  String? sourceLanguage;

  FollowTransLateModel({this.translateContent, this.sourceLanguage});

  FollowTransLateModel.fromJson(Map<String, dynamic> json) {
    translateContent = json['translateContent'];
    sourceLanguage = json['sourceLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['translateContent'] = translateContent;
    data['sourceLanguage'] = sourceLanguage;
    return data;
  }
}
