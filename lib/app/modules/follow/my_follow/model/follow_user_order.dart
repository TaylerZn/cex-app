import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowUserFollowOrderModel with PagingModel, PagingError {
  num? count;
  List<FollowUserFollowOrder>? list;

  FollowUserFollowOrderModel({this.count, this.list});

  FollowUserFollowOrderModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <FollowUserFollowOrder>[];
      json['list'].forEach((v) {
        list!.add(FollowUserFollowOrder.fromJson(v));
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

class FollowUserFollowOrder with PagingModel {
  String? symbol;
  num side = 0;
  num? followStatus;
  String? kolName;
  num? lever;
  num? instrumentId;
  num? allAmount;
  num realisedPnl = 0;
  num? uid;
  num? avgClosePx;
  num? tradeAmount;
  num rate = 0;
  num? avgCostPx;
  num? kolUid;
  num? id;
  num? positionType;
  String? coin;
  num? volume;
  num? holdAmount;
  num? openPrice;
  num? cTime;
  num? markPrice;
  String? kolImg;
  num? reducePrice;
  String? contractName;
  String? contractType;
  String? subSymbol;
  int? levelType;
  String flagIcon = '';
  String organizationIcon = '';
  String? isTraderRating;

  FollowUserFollowOrder(
      {this.symbol,
      this.side = 0,
      this.followStatus,
      this.kolName,
      this.lever,
      this.instrumentId,
      this.allAmount,
      this.realisedPnl = 0,
      this.uid,
      this.avgClosePx,
      this.tradeAmount,
      this.rate = 0,
      this.avgCostPx,
      this.kolUid,
      this.id,
      this.positionType,
      this.coin,
      this.volume,
      this.holdAmount,
      this.openPrice,
      this.cTime,
      this.reducePrice,
      this.contractName,
      this.contractType,
      this.subSymbol,
      this.levelType});

  FollowUserFollowOrder.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    side = json['side'] ?? 0;
    followStatus = json['follow_status'];
    kolName = json['kol_name'];
    lever = json['lever'];
    instrumentId = json['instrument_id'];
    allAmount = json['all_amount'];
    realisedPnl = json['realised_pnl'] ?? 0;
    uid = json['uid'];
    avgClosePx = json['avg_close_px'];
    tradeAmount = json['trade_amount'];
    rate = json['rate'] ?? 0;
    avgCostPx = json['avg_cost_px'];
    kolUid = json['kol_uid'];
    id = json['id'];
    positionType = json['position_type'];
    coin = json['coin'];
    volume = json['volume'];
    holdAmount = json['holdAmount'];
    openPrice = json['openPrice'];
    cTime = json['cTime'];
    markPrice = json['markPrice'];
    kolImg = json['kolImg'];
    reducePrice = json['reducePrice'];
    contractName = json['contractName'];
    contractType = json['contractType'];
    subSymbol = json['subSymbol'];
    levelType = json['levelType'];
    isTraderRating = json['isTraderRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['side'] = side;
    data['follow_status'] = followStatus;
    data['kol_name'] = kolName;
    data['lever'] = lever;
    data['instrument_id'] = instrumentId;
    data['all_amount'] = allAmount;
    data['realised_pnl'] = realisedPnl;
    data['uid'] = uid;
    data['avg_close_px'] = avgClosePx;
    data['trade_amount'] = tradeAmount;
    data['rate'] = rate;
    data['avg_cost_px'] = avgCostPx;
    data['kol_uid'] = kolUid;
    data['id'] = id;
    data['position_type'] = positionType;
    data['coin'] = coin;
    data['volume'] = volume;
    data['holdAmount'] = holdAmount;
    data['openPrice'] = openPrice;
    data['cTime'] = cTime;
    data['markPrice'] = markPrice;
    data['kolImg'] = kolImg;
    data['reducePrice'] = reducePrice;
    data['contractName'] = contractName;

    data['contractType'] = contractType;
    data['subSymbol'] = subSymbol;
    data['levelType'] = levelType;
    data['isTraderRating'] = isTraderRating;

    return data;
  }

  String get iconStr => kolImg != null && kolImg!.isNotEmpty ? kolImg! : "default/avatar_default".pngAssets();
  String get tag => side == 1 ? LocaleKeys.trade104.tr : LocaleKeys.trade103.tr;
  Color get tagColor => getmColor(side == 1 ? 1 : -1);
  String get name => contractName ?? '--';
  String get positionTypeStr =>
      positionType == 2 ? '${LocaleKeys.trade77.tr}${(lever ?? 1)}x' : '${LocaleKeys.trade78.tr}${(lever ?? 1)}x';
  String get createdTime => MyTimeUtil.timestampToStr((cTime ?? 0).toInt());

  String get earnStr => getmConvert(realisedPnl);
  Color get earnColor => getmColor(realisedPnl);

  String get rateStr => getmRateConvert(rate);
  String get volumeStr => getmConvert(volume, isDefault: false);

  String get holdAmountStr => getmConvert(holdAmount);
  String get markPriceStr => getmConvert(markPrice);
  String get openPriceStr => getmConvert(openPrice);
  String get kolNameStr => kolName ?? '--';

  String get followTimeStr => '${LocaleKeys.follow69.tr}: ${MyTimeUtil.timestampToStr((cTime ?? 0).toInt())}';
  String get followAmountStr => (allAmount ?? 0).toString();

  String get kolUidStr => (kolUid ?? -1).toString();

  String get currentSymbol => contractName?.isNotEmpty == true
      ? contractName!.contains('-')
          ? '(${contractName!.split('-').first})'
          : ''
      : '';

  bool get isStandardContract => contractType == 'E' ? false : true;

  String get contractTypeStr => isStandardContract ? LocaleKeys.trade6.tr : LocaleKeys.trade7.tr;
  String get subSymbolStr => symbol ?? '--';

  bool get isRating => isTraderRating == '1' ? true : false;

  bool get isfollowStatus => followStatus == 1 ? true : false;
  List get organizationIconList {
    var array = organizationIcon.split(',');

    array = array.sublist(0, min(2, array.length));

    return array;
  }
}
