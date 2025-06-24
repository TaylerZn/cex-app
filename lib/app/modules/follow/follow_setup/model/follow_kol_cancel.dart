import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

class FollowCancelDetail with PagingModel {
  String? imgUrl;
  String? name;
  num? margin;
  num? totalPNL;
  num? platformFee;
  num? expectedShardProfit;
  num? expectedAmount;
  int? levelType;

  FollowCancelDetail(
      {this.imgUrl, this.name, this.margin, this.totalPNL, this.platformFee, this.expectedShardProfit, this.expectedAmount});

  FollowCancelDetail.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
    name = json['name'];
    margin = json['margin'];
    totalPNL = json['totalPNL'];
    platformFee = json['platformFee'];
    expectedShardProfit = json['expectedShardProfit'];
    expectedAmount = json['expectedAmount'];
    levelType = json['levelType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['imgUrl'] = imgUrl;
    data['name'] = name;
    data['margin'] = margin;
    data['totalPNL'] = totalPNL;
    data['platformFee'] = platformFee;
    data['expectedShardProfit'] = expectedShardProfit;
    data['expectedAmount'] = expectedAmount;
    data['levelType'] = levelType;

    return data;
  }

  String get icon => imgUrl != null && imgUrl!.isNotEmpty ? imgUrl! : "default/avatar_default".pngAssets();
  String get userName => name != null ? name! : '--';
  String get marginStr => '${getmConvert(margin)} USDT';
  String get totalPNLStr => '${getmConvert(totalPNL)} USDT';
  String get expectedShardProfitStr => '${getmConvert(expectedShardProfit)} USDT';
  String get expectedAmountStr => '${getmConvert(expectedAmount)} USDT';
  String get platformFeeStr => '${getmConvert(platformFee)} USDT';
}
