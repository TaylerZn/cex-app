import 'dart:ui';

import 'package:nt_app_flutter/app/config/theme/app_color.dart';

class HistoryTradeRes {
  List<HistoryTradeInfo>? data;
  int? ts;

  HistoryTradeRes({this.data, this.ts});

  HistoryTradeRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HistoryTradeInfo>[];
      json['data'].forEach((v) {
        data!.add(HistoryTradeInfo.fromJson(v));
      });
    }
    ts = json['ts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['ts'] = ts;
    return data;
  }
}

class HistoryTradeInfo {
  String amount;
  String ds;
  String price;
  String? es_price;
  String side;
  int ts;
  String vol;
  Color priceColor = AppColor.upColor;

  HistoryTradeInfo(this.amount, this.ds, this.price, this.es_price, this.side,
      this.ts, this.vol);

  static List<HistoryTradeInfo> fromJsonList(List<dynamic> jsonList) {
    List<HistoryTradeInfo> list = [];
    for (var element in jsonList) {
      list.add(HistoryTradeInfo.fromJson(element));
    }
    return list;
  }

  factory HistoryTradeInfo.fromJson(Map<String, dynamic> json) {
    return HistoryTradeInfo(
      json['amount'].toString(),
      json['ds'].toString(),
      json['price'].toString(),
      json['es_price'].toString(),
      json['side'].toString(),
      json['ts'],
      json['vol'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = amount;
    data['ds'] = ds;
    data['price'] = price;
    data['es_price'] = es_price;
    data['side'] = side;
    data['ts'] = ts;
    data['vol'] = vol;
    return data;
  }
}
