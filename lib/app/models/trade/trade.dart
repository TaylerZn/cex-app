import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/widgets.dart';
part 'trade.g.dart';

@JsonSerializable()
class TraderInfoModel {
  var id;
  var memberId;
  var memberName;
  var memberUid;
  var memberType;
  var picture;
  var signature;
  var balanceAmount;
  var activeAmount;
  var totalAssets;
  var incomeAmount;
  var income;
  var incomePer;
  var todayIncomeAmount;
  var todayIncomePer;
  var orderScale;
  var amount;
  var currentFollowNum;
  var currentFollowAmount;
  var historyFollowNum;
  var fansNum;
  var rebatePer;
  var historyRebateAmount;
  var expectRebateAmount;
  var rebateRatio;
  var ntMemberTagVOList;
  var isFocus;
  TraderInfoModel({
    this.id,
    this.memberId,
    this.memberName,
    this.memberUid,
    this.memberType,
    this.picture,
    this.signature,
    this.balanceAmount,
    this.activeAmount,
    this.totalAssets,
    this.incomeAmount,
    this.income,
    this.incomePer,
    this.todayIncomeAmount,
    this.todayIncomePer,
    this.orderScale,
    this.amount,
    this.currentFollowNum,
    this.currentFollowAmount,
    this.historyFollowNum,
    this.fansNum,
    this.rebatePer,
    this.historyRebateAmount,
    this.expectRebateAmount,
    this.rebateRatio,
    this.ntMemberTagVOList,
    this.isFocus,
  });

  factory TraderInfoModel.fromJson(Map<String, dynamic> json) =>
      _$TraderInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TraderInfoModelToJson(this);
}

@JsonSerializable()
class TraderinvestpageListModel {
  var name;
  var price;
  var picture;
  var gainsLosses;
  var riseShort;
  var leverageRatio;
  var createTime;
  var incomeAmount;
  var income;
  var marginAmount;
  var amount;
  var id;
  var uid;
  var ratio;
  var closingAmount;
  var followAmount;
  var logo;
  var strategyId;
  TraderinvestpageListModel({
    this.name,
    this.price,
    this.picture,
    this.gainsLosses,
    this.riseShort,
    this.leverageRatio,
    this.createTime,
    this.incomeAmount,
    this.income,
    this.marginAmount,
    this.amount,
    this.id,
    this.uid,
    this.ratio,
    this.closingAmount,
    this.followAmount,
    this.logo,
    this.strategyId,
  });

  factory TraderinvestpageListModel.fromJson(Map<String, dynamic> json) =>
      _$TraderinvestpageListModelFromJson(json);
  Map<String, dynamic> toJson() => _$TraderinvestpageListModelToJson(this);
}

@JsonSerializable()
class TraderInfoModelUserCount {
  var id;
  var createBy;
  var updateBy;
  var comments;
  var createTime;
  var updateTime;
  var userId;
  var followingNum;
  var followersNum;
  var likeNum;
  var collectNum;
  TraderInfoModelUserCount({
    this.id,
    this.createBy,
    this.updateBy,
    this.comments,
    this.createTime,
    this.updateTime,
    this.userId,
    this.followingNum,
    this.followersNum,
    this.likeNum,
    this.collectNum,
  });

  factory TraderInfoModelUserCount.fromJson(Map<String, dynamic> json) =>
      _$TraderInfoModelUserCountFromJson(json);
  Map<String, dynamic> toJson() => _$TraderInfoModelUserCountToJson(this);
}

@JsonSerializable()
class NoAuthtraderassetDistributionModel {
  var totalInvestment;
  var rebateRatio;
  List<NoAuthtraderassetDistributionModelList>? list;
  NoAuthtraderassetDistributionModel({
    this.totalInvestment,
    this.rebateRatio,
    this.list,
  });

  factory NoAuthtraderassetDistributionModel.fromJson(
          Map<String, dynamic> json) =>
      _$NoAuthtraderassetDistributionModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$NoAuthtraderassetDistributionModelToJson(this);
}

@JsonSerializable()
class NoAuthtraderassetDistributionModelList {
  var symbol;
  var amount;
  var ratio;
  NoAuthtraderassetDistributionModelList({
    this.symbol,
    this.amount,
    this.ratio,
  });

  factory NoAuthtraderassetDistributionModelList.fromJson(
          Map<String, dynamic> json) =>
      _$NoAuthtraderassetDistributionModelListFromJson(json);
  Map<String, dynamic> toJson() =>
      _$NoAuthtraderassetDistributionModelListToJson(this);
}

@JsonSerializable()
class FollowOrderConfiglistModel {
  var id;
  var name;
  var followOrderRatio;
  FollowOrderConfiglistModel({
    this.id,
    this.name,
    this.followOrderRatio,
  });

  factory FollowOrderConfiglistModel.fromJson(Map<String, dynamic> json) =>
      _$FollowOrderConfiglistModelFromJson(json);
  Map<String, dynamic> toJson() => _$FollowOrderConfiglistModelToJson(this);
}

@JsonSerializable()
class TraderinvestlistModel {
  var id;
  var stockId;
  var riseShort;
  var leverageRatio;
  var createTime;
  var marginAmount;
  TraderinvestlistModel({
    this.id,
    this.stockId,
    this.riseShort,
    this.leverageRatio,
    this.createTime,
    this.marginAmount,
  });

  factory TraderinvestlistModel.fromJson(Map<String, dynamic> json) =>
      _$TraderinvestlistModelFromJson(json);
  Map<String, dynamic> toJson() => _$TraderinvestlistModelToJson(this);
}
