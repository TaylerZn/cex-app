import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowHistoryOrderModel with PagingModel, PagingError {
  List<FollowHistoryOrder>? list;

  FollowHistoryOrderModel({this.list});

  FollowHistoryOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <FollowHistoryOrder>[];
      json['list'].forEach((v) {
        list!.add(FollowHistoryOrder.fromJson(v));
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

class FollowHistoryOrder with PagingModel {
  String? symbol;
  num side = 0;
  num updatedAt = 0;
  num rate = 0;
  num createdAt = 0;
  num? lever;
  num? instrumentId;
  num? positionType;
  num avgOpenPx = 0;
  num avgClosePx = 0;
  num? volume;
  num profit = 0;
  String? contractType;

  FollowHistoryOrder(
      {this.symbol,
      this.side = 0,
      this.updatedAt = 0,
      this.rate = 0,
      this.createdAt = 0,
      this.lever,
      this.instrumentId,
      this.positionType,
      this.avgOpenPx = 0,
      this.avgClosePx = 0,
      this.volume,
      this.profit = 0,
      this.contractType});

  FollowHistoryOrder.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    side = json['side'] ?? 0;
    avgClosePx = json['avg_close_px'] ?? 0;
    updatedAt = json['updated_at'] ?? 0;
    rate = json['rate'] ?? 0;
    createdAt = json['created_at'] ?? 0;
    lever = json['lever'];
    instrumentId = json['instrument_id'];
    positionType = json['position_type'];
    avgOpenPx = json['avg_open_px'] ?? 0;
    volume = json['volume'];
    profit = json['profit'] ?? 0;
    contractType = json['contractType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['side'] = side;
    data['avg_close_px'] = avgClosePx;
    data['updated_at'] = updatedAt;
    data['rate'] = rate;
    data['created_at'] = createdAt;
    data['lever'] = lever;
    data['instrument_id'] = instrumentId;
    data['position_type'] = positionType;
    data['avg_open_px'] = avgOpenPx;
    data['volume'] = volume;
    data['profit'] = profit;
    data['contractType'] = contractType;
    return data;
  }

  String get tag => side == 1 ? LocaleKeys.trade104.tr : LocaleKeys.trade103.tr;
  Color get tagColor => getmColor(side == 1 ? 1 : -1);
  String get name => symbol ?? '--';
  String get positionTypeStr =>
      positionType == 1 ? '${LocaleKeys.trade77.tr}${(lever ?? 1)}x' : '${LocaleKeys.trade78.tr}${(lever ?? 1)}x';

  String get avgOpenPxStr => getmConvert(avgOpenPx);
  String get avgClosePxStr => getmConvert(avgClosePx);

  String get profitStr => getmConvert(profit);
  Color get profitColor => getmColor(profit);
  String get volumeStr => getmConvert(volume, isDefault: false);

  String get rateStr => rate > 0 ? '+${getmConvert(rate)}%' : '${getmConvert(rate)}%';

  String get createdTime => MyTimeUtil.timestampToStr(createdAt.toInt());
  String get closeTime => MyTimeUtil.timestampToStr(updatedAt.toInt());
  String get type => symbol?.contains('-') == true ? symbol!.split('-').first : '';
  bool get isStandardContract => contractType == 'E' ? false : true;
  String get contractTypeStr => isStandardContract ? LocaleKeys.trade6.tr : LocaleKeys.trade7.tr;
}
