// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TraderInfoModel _$TraderInfoModelFromJson(Map<String, dynamic> json) =>
    TraderInfoModel(
      id: json['id'],
      memberId: json['memberId'],
      memberName: json['memberName'],
      memberUid: json['memberUid'],
      memberType: json['memberType'],
      picture: json['picture'],
      signature: json['signature'],
      balanceAmount: json['balanceAmount'],
      activeAmount: json['activeAmount'],
      totalAssets: json['totalAssets'],
      incomeAmount: json['incomeAmount'],
      income: json['income'],
      incomePer: json['incomePer'],
      todayIncomeAmount: json['todayIncomeAmount'],
      todayIncomePer: json['todayIncomePer'],
      orderScale: json['orderScale'],
      amount: json['amount'],
      currentFollowNum: json['currentFollowNum'],
      currentFollowAmount: json['currentFollowAmount'],
      historyFollowNum: json['historyFollowNum'],
      fansNum: json['fansNum'],
      rebatePer: json['rebatePer'],
      historyRebateAmount: json['historyRebateAmount'],
      expectRebateAmount: json['expectRebateAmount'],
      rebateRatio: json['rebateRatio'],
      ntMemberTagVOList: json['ntMemberTagVOList'],
      isFocus: json['isFocus'],
    );

Map<String, dynamic> _$TraderInfoModelToJson(TraderInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'memberUid': instance.memberUid,
      'memberType': instance.memberType,
      'picture': instance.picture,
      'signature': instance.signature,
      'balanceAmount': instance.balanceAmount,
      'activeAmount': instance.activeAmount,
      'totalAssets': instance.totalAssets,
      'incomeAmount': instance.incomeAmount,
      'income': instance.income,
      'incomePer': instance.incomePer,
      'todayIncomeAmount': instance.todayIncomeAmount,
      'todayIncomePer': instance.todayIncomePer,
      'orderScale': instance.orderScale,
      'amount': instance.amount,
      'currentFollowNum': instance.currentFollowNum,
      'currentFollowAmount': instance.currentFollowAmount,
      'historyFollowNum': instance.historyFollowNum,
      'fansNum': instance.fansNum,
      'rebatePer': instance.rebatePer,
      'historyRebateAmount': instance.historyRebateAmount,
      'expectRebateAmount': instance.expectRebateAmount,
      'rebateRatio': instance.rebateRatio,
      'ntMemberTagVOList': instance.ntMemberTagVOList,
      'isFocus': instance.isFocus,
    };

TraderinvestpageListModel _$TraderinvestpageListModelFromJson(
        Map<String, dynamic> json) =>
    TraderinvestpageListModel(
      name: json['name'],
      price: json['price'],
      picture: json['picture'],
      gainsLosses: json['gainsLosses'],
      riseShort: json['riseShort'],
      leverageRatio: json['leverageRatio'],
      createTime: json['createTime'],
      incomeAmount: json['incomeAmount'],
      income: json['income'],
      marginAmount: json['marginAmount'],
      amount: json['amount'],
      id: json['id'],
      uid: json['uid'],
      ratio: json['ratio'],
      closingAmount: json['closingAmount'],
      followAmount: json['followAmount'],
      logo: json['logo'],
      strategyId: json['strategyId'],
    );

Map<String, dynamic> _$TraderinvestpageListModelToJson(
        TraderinvestpageListModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'picture': instance.picture,
      'gainsLosses': instance.gainsLosses,
      'riseShort': instance.riseShort,
      'leverageRatio': instance.leverageRatio,
      'createTime': instance.createTime,
      'incomeAmount': instance.incomeAmount,
      'income': instance.income,
      'marginAmount': instance.marginAmount,
      'amount': instance.amount,
      'id': instance.id,
      'uid': instance.uid,
      'ratio': instance.ratio,
      'closingAmount': instance.closingAmount,
      'followAmount': instance.followAmount,
      'logo': instance.logo,
      'strategyId': instance.strategyId,
    };

TraderInfoModelUserCount _$TraderInfoModelUserCountFromJson(
        Map<String, dynamic> json) =>
    TraderInfoModelUserCount(
      id: json['id'],
      createBy: json['createBy'],
      updateBy: json['updateBy'],
      comments: json['comments'],
      createTime: json['createTime'],
      updateTime: json['updateTime'],
      userId: json['userId'],
      followingNum: json['followingNum'],
      followersNum: json['followersNum'],
      likeNum: json['likeNum'],
      collectNum: json['collectNum'],
    );

Map<String, dynamic> _$TraderInfoModelUserCountToJson(
        TraderInfoModelUserCount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createBy': instance.createBy,
      'updateBy': instance.updateBy,
      'comments': instance.comments,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'userId': instance.userId,
      'followingNum': instance.followingNum,
      'followersNum': instance.followersNum,
      'likeNum': instance.likeNum,
      'collectNum': instance.collectNum,
    };

NoAuthtraderassetDistributionModel _$NoAuthtraderassetDistributionModelFromJson(
        Map<String, dynamic> json) =>
    NoAuthtraderassetDistributionModel(
      totalInvestment: json['totalInvestment'],
      rebateRatio: json['rebateRatio'],
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => NoAuthtraderassetDistributionModelList.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NoAuthtraderassetDistributionModelToJson(
        NoAuthtraderassetDistributionModel instance) =>
    <String, dynamic>{
      'totalInvestment': instance.totalInvestment,
      'rebateRatio': instance.rebateRatio,
      'list': instance.list,
    };

NoAuthtraderassetDistributionModelList
    _$NoAuthtraderassetDistributionModelListFromJson(
            Map<String, dynamic> json) =>
        NoAuthtraderassetDistributionModelList(
          symbol: json['symbol'],
          amount: json['amount'],
          ratio: json['ratio'],
        );

Map<String, dynamic> _$NoAuthtraderassetDistributionModelListToJson(
        NoAuthtraderassetDistributionModelList instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'amount': instance.amount,
      'ratio': instance.ratio,
    };

FollowOrderConfiglistModel _$FollowOrderConfiglistModelFromJson(
        Map<String, dynamic> json) =>
    FollowOrderConfiglistModel(
      id: json['id'],
      name: json['name'],
      followOrderRatio: json['followOrderRatio'],
    );

Map<String, dynamic> _$FollowOrderConfiglistModelToJson(
        FollowOrderConfiglistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'followOrderRatio': instance.followOrderRatio,
    };

TraderinvestlistModel _$TraderinvestlistModelFromJson(
        Map<String, dynamic> json) =>
    TraderinvestlistModel(
      id: json['id'],
      stockId: json['stockId'],
      riseShort: json['riseShort'],
      leverageRatio: json['leverageRatio'],
      createTime: json['createTime'],
      marginAmount: json['marginAmount'],
    );

Map<String, dynamic> _$TraderinvestlistModelToJson(
        TraderinvestlistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stockId': instance.stockId,
      'riseShort': instance.riseShort,
      'leverageRatio': instance.leverageRatio,
      'createTime': instance.createTime,
      'marginAmount': instance.marginAmount,
    };
