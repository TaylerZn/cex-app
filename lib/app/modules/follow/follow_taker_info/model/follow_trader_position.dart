import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowTradePositionModel with PagingModel, PagingError {
  List<FollowTradePosition>? list;

  FollowTradePositionModel({this.list});

  FollowTradePositionModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <FollowTradePosition>[];
      json['list'].forEach((v) {
        list!.add(FollowTradePosition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowTradePosition with PagingModel {
  num? id;
  num? positionId;
  num? uid;
  num? companyId;
  String? contractName;
  num? positionType;
  num? side;
  num? status;
  num? freezeLock;
  num? volume;
  num? pendingCloseVolume;
  num? closeVolume;
  num? avgPrice;
  num? openPrice;
  num? closePrice;
  num? holdAmount;
  num? realizedAmount;
  num unRealizedAmount = 0;
  num? reducePrice;
  num? historyRealizedAmount;
  num? leverageLevel;
  num earningsRate = 0;
  String? ctime;
  num? mtime;
  String? multiplier;
  num? settleType;
  num? userType;
  num? createdAtLong;
  num? updatedAtLong;
  num? followStatus;
  num? recordId;
  num? markPrice;
  num? marginRate;
  num? indexPrice;
  num? openDealCount;
  String? contractType;
  String? subSymbol;

  FollowTradePosition(
      {this.id,
      this.positionId,
      this.uid,
      this.companyId,
      this.contractName,
      this.positionType,
      this.side,
      this.status,
      this.freezeLock,
      this.volume,
      this.pendingCloseVolume,
      this.closeVolume,
      this.avgPrice,
      this.openPrice,
      this.closePrice,
      this.holdAmount,
      this.realizedAmount,
      this.unRealizedAmount = 0,
      this.reducePrice,
      this.historyRealizedAmount,
      this.leverageLevel,
      this.earningsRate = 0,
      this.ctime,
      this.mtime,
      this.multiplier,
      this.settleType,
      this.userType,
      this.createdAtLong,
      this.updatedAtLong,
      this.followStatus,
      this.recordId,
      this.openDealCount,
      this.contractType,
      this.subSymbol});

  FollowTradePosition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positionId = json['positionId'];
    uid = json['uid'];
    companyId = json['companyId'];
    contractName = json['contractName'];
    positionType = json['positionType'];
    side = json['side'];
    status = json['status'];
    freezeLock = json['freezeLock'];
    volume = json['volume'];
    pendingCloseVolume = json['pendingCloseVolume'];
    closeVolume = json['closeVolume'];
    avgPrice = json['avgPrice'];
    openPrice = json['openPrice'];
    closePrice = json['closePrice'];
    holdAmount = json['holdAmount'];
    realizedAmount = json['realizedAmount'];
    unRealizedAmount = json['unRealizedAmount'] ?? 0;
    reducePrice = json['reducePrice'];
    historyRealizedAmount = json['historyRealizedAmount'];
    leverageLevel = json['leverageLevel'];
    earningsRate = json['earningsRate'] ?? 0;
    ctime = json['ctime'];
    // mtime = json['mtime'];
    multiplier = json['multiplier'];
    settleType = json['settleType'];
    userType = json['userType'];
    createdAtLong = json['created_at_long'];
    updatedAtLong = json['updated_at_long'];
    followStatus = json['follow_status'];
    recordId = json['recordId'];
    markPrice = json['markPrice'];
    marginRate = json['marginRate'];
    indexPrice = json['indexPrice'];
    openDealCount = json['openDealCount'];
    contractType = json['contractType'];
    subSymbol = json['subSymbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['positionId'] = positionId;
    data['uid'] = uid;
    data['companyId'] = companyId;
    data['contractName'] = contractName;
    data['positionType'] = positionType;
    data['side'] = side;
    data['status'] = status;
    data['freezeLock'] = freezeLock;
    data['volume'] = volume;
    data['pendingCloseVolume'] = pendingCloseVolume;
    data['closeVolume'] = closeVolume;
    data['avgPrice'] = avgPrice;
    data['openPrice'] = openPrice;
    data['closePrice'] = closePrice;
    data['holdAmount'] = holdAmount;
    data['realizedAmount'] = realizedAmount;
    data['unRealizedAmount'] = unRealizedAmount;
    data['reducePrice'] = reducePrice;
    data['historyRealizedAmount'] = historyRealizedAmount;
    data['leverageLevel'] = leverageLevel;
    data['earningsRate'] = earningsRate;
    data['ctime'] = ctime;
    data['mtime'] = mtime;
    data['multiplier'] = multiplier;
    data['settleType'] = settleType;
    data['userType'] = userType;
    data['created_at_long'] = createdAtLong;
    data['updated_at_long'] = updatedAtLong;
    data['follow_status'] = followStatus;
    data['recordId'] = recordId;
    data['markPrice'] = markPrice;
    data['marginRate'] = marginRate;
    data['indexPrice'] = indexPrice;
    data['openDealCount'] = openDealCount;
    data['contractType'] = contractType;
    data['subSymbol'] = subSymbol;
    return data;
  }

  String get tag => side == 0 ? LocaleKeys.trade104.tr : LocaleKeys.trade103.tr;

  Color get tagColor => getmColor((side == 0 ? 1 : -1));

  String get name => contractName ?? '--';

  String get positionTypeStr => positionType == 1
      ? '${LocaleKeys.trade77.tr}${(leverageLevel ?? 1)}x'
      : '${LocaleKeys.trade78.tr}${(leverageLevel ?? 1)}x';

  String get createdTime => ctime == null ? '' : ctime!.split('T').first;

  num get _earningNum => ((unRealizedAmount) + (realizedAmount ?? 0));

  String get earningStr => '${getmConvert(_earningNum)} USDT';

  Color get earningColor => getmColor(_earningNum);

  String get earningsRateStr => '${getmConvert(earningsRate)}%';

  Color get earningsRateColor => getmColor(earningsRate);

  String get volumeStr => getmConvert(volume);

  String get holdAmountStr => getmConvert(holdAmount);

  String get markPriceStr => getmConvert(markPrice);

  String get openPriceStr => getmConvert(openPrice);

  String get unRealizedAmountStr => '${getmConvert(unRealizedAmount)} USDT';

  Color get unRealizedAmountColor => getmColor(unRealizedAmount);

  String get marginRateStr => getmConvert(marginRate);

  String get indexPriceStr => getmConvert(indexPrice);

  String get openDealCountStr => getmConvert(volume, isDefault: false);

  String get reducePriceStr =>
      reducePrice != null && reducePrice! > 0 ? getmConvert(reducePrice) : '--';

  bool get isStandardContract => contractType == 'E' ? false : true;

  String get contractTypeStr =>
      isStandardContract ? LocaleKeys.trade6.tr : LocaleKeys.trade7.tr;

  String get marketTypeStr => isStandardContract
      ? '${LocaleKeys.follow190.tr}(USDT)'
      : '${LocaleKeys.follow179.tr}(USDT)';

  String get tagStr =>
      side == 'BUY' ? LocaleKeys.trade22.tr : LocaleKeys.trade23.tr;

  String get type =>
      contractName?.contains('-') == true ? contractName!.split('-').first : '';

  String get subSymbolStr => (contractType != null && contractName != null)
      ? '$contractType-$contractName'
      : '--';
}
