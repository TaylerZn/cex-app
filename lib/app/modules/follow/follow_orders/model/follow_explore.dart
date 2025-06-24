import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';

class FollowExploreGridModel with PagingError, PagingModel {
  List<FollowKolInfo>? popularTrader;
  List<FollowKolInfo>? steadyTrader;
  List<FollowKolInfo>? timesTrader;

  //v2
  List<FollowKolInfo>? follow; //粉丝数量做多关注
  List<FollowKolInfo>? comprehensiveRating; //新增综合评分最高
  List<FollowKolInfo>? orderNumber; //最大交易次数

  //v3
  List<FollowKolInfo>? list; //开仓偏好

  //v4
  List<FollowKolInfo>? favorableCommentTraderList1; //好评交易员1
  List<FollowKolInfo>? favorableCommentTraderList2; //好评交易员2
  List<FollowKolInfo>? badTraderList; //不好

  FollowExploreGridModel(
      {this.popularTrader,
      this.steadyTrader,
      this.timesTrader,
      this.follow,
      this.comprehensiveRating,
      this.orderNumber,
      this.list});

  FollowExploreGridModel.fromJson(Map<String, dynamic> json) {
    if (json['popularTrader'] != null) {
      popularTrader = <FollowKolInfo>[];
      json['popularTrader'].forEach((v) {
        popularTrader!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['steadyTrader'] != null) {
      steadyTrader = <FollowKolInfo>[];
      json['steadyTrader'].forEach((v) {
        steadyTrader!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['timesTrader'] != null) {
      timesTrader = <FollowKolInfo>[];
      json['timesTrader'].forEach((v) {
        timesTrader!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['follow'] != null) {
      follow = <FollowKolInfo>[];
      json['follow'].forEach((v) {
        follow!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['comprehensiveRating'] != null) {
      comprehensiveRating = <FollowKolInfo>[];
      json['comprehensiveRating'].forEach((v) {
        comprehensiveRating!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['orderNumber'] != null) {
      orderNumber = <FollowKolInfo>[];
      json['orderNumber'].forEach((v) {
        orderNumber!.add(FollowKolInfo.fromJson(v));
      });
    }

    if (json['records'] != null) {
      list = <FollowKolInfo>[];
      json['records'].forEach((v) {
        list!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['favorableCommentTraderList1'] != null) {
      favorableCommentTraderList1 = <FollowKolInfo>[];
      json['favorableCommentTraderList1'].forEach((v) {
        favorableCommentTraderList1!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['favorableCommentTraderList2'] != null) {
      favorableCommentTraderList2 = <FollowKolInfo>[];
      json['favorableCommentTraderList2'].forEach((v) {
        favorableCommentTraderList2!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['badTraderList'] != null) {
      badTraderList = <FollowKolInfo>[];
      json['badTraderList'].forEach((v) {
        badTraderList!.add(FollowKolInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (popularTrader != null) {
      data['popularTrader'] = popularTrader!.map((v) => v.toJson()).toList();
    }
    if (steadyTrader != null) {
      data['steadyTrader'] = steadyTrader!.map((v) => v.toJson()).toList();
    }
    if (timesTrader != null) {
      data['timesTrader'] = timesTrader!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
