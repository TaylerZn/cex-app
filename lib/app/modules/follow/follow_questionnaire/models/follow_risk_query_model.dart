import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowRiskQueryModel {
  num? id;
  num? uid;
  num? basicSupport;
  num? liquidity;
  num? riskTolerance;
  num? investmentKnowledge;
  num? investmentPreference;
  num? totalScore;
  String? investorType;
  num? ctime;
  num? mtime;

  FollowRiskQueryModel(
      {this.id,
      this.uid,
      this.basicSupport,
      this.liquidity,
      this.riskTolerance,
      this.investmentKnowledge,
      this.investmentPreference,
      this.totalScore,
      this.investorType,
      this.ctime,
      this.mtime});

  FollowRiskQueryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    basicSupport = json['basicSupport'];
    liquidity = json['liquidity'];
    riskTolerance = json['riskTolerance'];
    investmentKnowledge = json['investmentKnowledge'];
    investmentPreference = json['investmentPreference'];
    totalScore = json['totalScore'];
    investorType = json['investorType'];
    ctime = json['ctime'];
    mtime = json['mtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['uid'] = uid;
    data['basicSupport'] = basicSupport;
    data['liquidity'] = liquidity;
    data['riskTolerance'] = riskTolerance;
    data['investmentKnowledge'] = investmentKnowledge;
    data['investmentPreference'] = investmentPreference;
    data['totalScore'] = totalScore;
    data['investorType'] = investorType;
    data['ctime'] = ctime;
    data['mtime'] = mtime;
    return data;
  }

  // bool get isRickFollow {
  //   return isSet == 0 ? false : true;
  // }

  String get investorTypeStr {
    if (investorType == 'Conservative') {
      return LocaleKeys.follow346.tr;//'保守投资者' ///'保守型投资者';
    } else if (investorType == 'Moderate') {
      return LocaleKeys.follow350.tr;//'稳健型投资者';
    } else if (investorType == 'Aggressive') {
      return LocaleKeys.follow354.tr; ////'激进型投资者';
    }
    return LocaleKeys.public55.tr; //'服务返回异常';
  }

  int get investorTypeInt {
    if (investorType == 'Conservative') {
      return 10;
    } else if (investorType == 'Moderate') {
      return 9;
    } else if (investorType == 'Aggressive') {
      return 8;
    }
    return LocaleKeys.public55.tr.hashCode; //'服务返回异常'.hashCode;
  }
}
