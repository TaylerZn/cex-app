import 'dart:ui';

import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

class FollowSuperListModel {
  int? count;
  List<FollowSuperModel>? list;

  FollowSuperListModel({this.count, this.list});

  FollowSuperListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <FollowSuperModel>[];
      json['list'].forEach((v) {
        list!.add(FollowSuperModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowSuperModel with PagingModel {
  String? userName;
  num? balance;
  num? profitAmount;
  num? currentNumber;
  String? imgUrl;
  num? profitAmountRate;

  FollowSuperModel({this.userName, this.balance, this.profitAmount, this.currentNumber, this.imgUrl, this.profitAmountRate});

  FollowSuperModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    balance = json['balance'];
    profitAmount = json['profitAmount'];
    currentNumber = json['currentNumber'];
    imgUrl = json['imgUrl'];
    profitAmountRate = json['profitAmountRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userName'] = userName;
    data['balance'] = balance;
    data['profitAmount'] = profitAmount;
    data['currentNumber'] = currentNumber;
    data['imgUrl'] = imgUrl;
    data['profitAmountRate'] = profitAmountRate;
    return data;
  }

  String get icon => imgUrl != null && imgUrl!.isNotEmpty ? imgUrl! : "default/avatar_default".pngAssets();
  String get userNmae => userName != null ? userName! : '--';
  String get profitAmountStr => profitAmount != null ? profitAmount!.toString() : '--';
  String get profitAmountRateStr =>
      profitAmountRate != null ? '${profitAmountRate! > 0 ? '+' : ''}${profitAmountRate!}%' : '--';
  String get balanceStr => balance != null ? balance!.toString() : '--';
  String get currentNumberStr => currentNumber != null ? currentNumber!.toString() : '--';

  Color get profitAmountRateClor => getmColor(profitAmountRate);
}

class FollowCheckTraderModel {
  num? overAmount;
  num? isKyc;
  num? inviteCondition;
  num? positionCondition;
  num? winRate;
  num? profitability;
  num? monthlyCountAmount;

  FollowCheckTraderModel(
      {this.overAmount,
      this.isKyc,
      this.inviteCondition,
      this.positionCondition,
      this.winRate,
      this.profitability,
      this.monthlyCountAmount});

  FollowCheckTraderModel.fromJson(Map<String, dynamic> json) {
    overAmount = json['overAmount'];
    isKyc = json['isKyc'];
    inviteCondition = json['inviteCondition'];
    positionCondition = json['positionCondition'];
    winRate = json['winRate'];
    profitability = json['profitability'];
    monthlyCountAmount = json['monthlyCountAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['overAmount'] = overAmount;
    data['isKyc'] = isKyc;
    data['inviteCondition'] = inviteCondition;
    data['positionCondition'] = positionCondition;
    data['winRate'] = winRate;
    data['profitability'] = profitability;
    data['monthlyCountAmount'] = monthlyCountAmount;
    return data;
  }
}
