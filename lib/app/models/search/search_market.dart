import 'dart:convert';

import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

//搜索现货
class SearchMarketModel {
  SearchMarketModelMarkets? markets;

  SearchMarketModel({
    this.markets,
  });

  factory SearchMarketModel.fromRawJson(String str) =>
      SearchMarketModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchMarketModel.fromJson(Map<String, dynamic> json) =>
      SearchMarketModel(
        markets: json["markets"] == null
            ? null
            : SearchMarketModelMarkets.fromJson(json["markets"]),
      );

  Map<String, dynamic> toJson() => {
        "markets": markets?.toJson(),
      };
}

class SearchMarketModelMarkets {
  int? count;
  int? pageSize;
  int? page;
  List<MarketInfoModel>? list;

  SearchMarketModelMarkets({
    this.count,
    this.pageSize,
    this.page,
    this.list,
  });

  factory SearchMarketModelMarkets.fromRawJson(String str) =>
      SearchMarketModelMarkets.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchMarketModelMarkets.fromJson(Map<String, dynamic> json) =>
      SearchMarketModelMarkets(
        count: json["count"],
        pageSize: json["pageSize"],
        page: json["page"],
        list: json["list"] == null
            ? []
            : List<MarketInfoModel>.from(
                json["list"]!.map((x) => MarketInfoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pageSize": pageSize,
        "page": page,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}
