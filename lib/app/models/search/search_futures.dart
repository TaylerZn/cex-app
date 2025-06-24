import 'dart:convert';

import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';

//搜索合约
class SearchFuturesModel {
  SearchFuturesModelFutures? futures;

  SearchFuturesModel({
    this.futures,
  });

  factory SearchFuturesModel.fromRawJson(String str) =>
      SearchFuturesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFuturesModel.fromJson(Map<String, dynamic> json) =>
      SearchFuturesModel(
        futures: json["futures"] == null
            ? null
            : SearchFuturesModelFutures.fromJson(json["futures"]),
      );

  Map<String, dynamic> toJson() => {
        "futures": futures?.toJson(),
      };
}

class SearchFuturesModelFutures {
  int? count;
  int? pageSize;
  int? page;
  List<ContractInfo>? list;

  SearchFuturesModelFutures({
    this.count,
    this.pageSize,
    this.page,
    this.list,
  });

  factory SearchFuturesModelFutures.fromRawJson(String str) =>
      SearchFuturesModelFutures.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFuturesModelFutures.fromJson(Map<String, dynamic> json) =>
      SearchFuturesModelFutures(
        count: json["count"],
        pageSize: json["pageSize"],
        page: json["page"],
        list: json["list"] == null
            ? []
            : List<ContractInfo>.from(
                json["list"]!.map((x) => ContractInfo.fromJson(x))),
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
