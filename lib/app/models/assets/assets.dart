import 'dart:convert';
import 'package:nt_app_flutter/app/models/assets/assets_overview.dart';

class AssetsGetxModel {
  AssetsOverView? overViewBalanceInfo;
  bool eyesOpen;
  String searchKeyword;
  String searchKeywordFound;
  bool hideZero = false;
  bool hideZeroOverView = false;

  AssetsGetxModel({
    this.overViewBalanceInfo,
    this.eyesOpen = true,
    this.searchKeyword = "",
    this.hideZero = false,
    this.searchKeywordFound = "",
  });

  factory AssetsGetxModel.fromRawJson(String str) =>
      AssetsGetxModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetsGetxModel.fromJson(Map<String, dynamic> json) =>
      AssetsGetxModel(
        overViewBalanceInfo: json["info"] == null
            ? null
            : AssetsOverView.fromJson(json["overViewBalanceInfo"]),
        eyesOpen: json["eyesOpen"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "overViewBalanceInfo": overViewBalanceInfo,
        "eyesOpen": eyesOpen,
      };
}
