import 'dart:convert';

import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';

//搜索现货
class SearchTradersModel {
  SearchTradersModelMarkets? traders;

  SearchTradersModel({
    this.traders,
  });

  factory SearchTradersModel.fromRawJson(String str) => SearchTradersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchTradersModel.fromJson(Map<String, dynamic> json) => SearchTradersModel(
        traders: json["traders"] == null ? null : SearchTradersModelMarkets.fromJson(json["traders"]),
      );

  Map<String, dynamic> toJson() => {
        "traders": traders?.toJson(),
      };
}

class SearchTradersModelMarkets {
  int? count;
  int? pageSize;
  int? page;
  List<FollowKolInfo>? list;

  SearchTradersModelMarkets({
    this.count,
    this.pageSize,
    this.page,
    this.list,
  });

  factory SearchTradersModelMarkets.fromRawJson(String str) => SearchTradersModelMarkets.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchTradersModelMarkets.fromJson(Map<String, dynamic> json) => SearchTradersModelMarkets(
        count: json["count"],
        pageSize: json["pageSize"],
        page: json["page"],
        list: json["list"] == null ? [] : List<FollowKolInfo>.from(json["list"]!.map((x) => FollowKolInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pageSize": pageSize,
        "page": page,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}
