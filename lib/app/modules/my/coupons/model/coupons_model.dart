import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///筛选项 枚举
enum CouponsType {
  claimed,
  invalid;

  String get value => [LocaleKeys.other57.tr, LocaleKeys.user267.tr][index];
}

class CouponsListModel with PagingError {
  List<CouponsModel>? cardList;

  CouponsListModel({this.cardList});

  CouponsListModel.fromJson(Map<String, dynamic> json) {
    if (json['cardList'] != null) {
      cardList = <CouponsModel>[];
      json['cardList'].forEach((v) {
        cardList!.add(CouponsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (cardList != null) {
      data['cardList'] = cardList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponsModel {
  String? coinSymbol;
  String? expire;
  num? tokenNum;
  num? cardType;
  String? contractName;
  String? conditionNum;
  num? maxLeverage;
  num? status;

//v2
  num? type;
  num? expStatus;
  num? cardExpire;
  num? expExpire;
  String? followUids;
  String? followNames;
  String? cardSn;

  CouponsModel(
      {this.coinSymbol,
      this.expire,
      this.tokenNum,
      this.cardType,
      this.contractName,
      this.conditionNum,
      this.maxLeverage,
      this.status,
      this.type,
      this.expStatus,
      this.cardExpire,
      this.expExpire,
      this.followUids,
      this.followNames,
      this.cardSn});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    coinSymbol = json['coinSymbol'];
    expire = json['expire'];
    tokenNum = json['tokenNum'];
    cardType = json['cardType'];
    contractName = json['contractName'];
    conditionNum = json['conditionNum'];
    maxLeverage = json['maxLeverage'];
    status = json['status'];
    type = json['type'];
    expStatus = json['expStatus'] ?? -1;
    cardExpire = json['cardExpire'];
    expExpire = json['expExpire'];
    followUids = json['followUids'];
    followNames = json['followNames'];
    cardSn = json['cardSn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['coinSymbol'] = coinSymbol;
    data['expire'] = expire;
    data['tokenNum'] = tokenNum;
    data['cardType'] = cardType;
    data['contractName'] = contractName;
    data['conditionNum'] = conditionNum;
    data['maxLeverage'] = maxLeverage;
    data['status'] = status;
    data['type'] = type;
    data['expStatus'] = expStatus;
    data['cardExpire'] = cardExpire;
    data['expExpire'] = expExpire;
    data['followUids'] = followUids;
    data['followNames'] = followNames;
    data['cardSn'] = cardSn;
    return data;
  }

// 新增jia expStatus 体验金状态  0已领取、  、6已失效  只有这两个状态
  String get coinSymbolStr => coinSymbol ?? '--';
  String get conditionNumStr => conditionNum ?? '--';
  String get tokenNumStr => tokenNum != null ? Decimal.parse(tokenNum!.toString()).toString() : '0';
  String get btnText {
    if (isBonus) {
      if (status == 0) {
        //未领取
        return LocaleKeys.other55.tr;
      } else {
        if (expStatus == 1) {
          //未领取
          return LocaleKeys.other55.tr;
        } else if (expStatus == 5) {
          //已过期

          return LocaleKeys.user297.tr;
        } else {
          //已领取
          return LocaleKeys.user266.tr;
        }
      }
    } else {
      return status == 0
          ? LocaleKeys.user268.tr
          : status == 1
              ? LocaleKeys.user267.tr
              : LocaleKeys.user272.tr;
    }
  }

  bool get btnEnabled {
    return status == 0;
  }

// 1未领取、2已领取未激活、3已激活、4已结算、5已失效
// 前端这样判断的 2 || 3 || 4 已领取 5 已过期

  String get statusStr {
    if (isBonus) {
      return (expStatus == 2 || expStatus == 3 || expStatus == 4) ? LocaleKeys.user266.tr : '';
    } else {
      return status == 2 ? LocaleKeys.user272.tr : '';
    }
  }

  String get contractTypeStr => cardType == 2
      ? LocaleKeys.follow17.tr
      : cardType == 1
          ? LocaleKeys.trade4.tr
          : LocaleKeys.trade5.tr;
  String get maxLeverageStr => (maxLeverage ?? 1).toString();
  String get expireStr {
// status=0		使用cardExpire
// status=1
// 	type=0		使用cardExpire
// 	type=1		使用expExpire

    if (status == 0) {
      if (isBonus) {
        return cardExpire != null
            ? '${LocaleKeys.other52.tr}: ${MyTimeUtil.getYMDime(MyTimeUtil.timestampToDate(cardExpire!.toInt()), format: 'yyyy-MM-dd HH:mm')}'
            : '--'; //cardExpire 替换
      } else {
        return cardExpire != null
            ? '${MyTimeUtil.getYMDime(MyTimeUtil.timestampToDate(cardExpire!.toInt()), format: 'yyyy-MM-dd HH:mm')} ${LocaleKeys.user271.tr}'
            : '--'; //cardExpire 替换
      }
    } else {
      if (isBonus) {
        return expExpire != null
            ? '${LocaleKeys.other52.tr}: ${MyTimeUtil.getYMDime(MyTimeUtil.timestampToDate(expExpire!.toInt()), format: 'yyyy-MM-dd HH:mm')}'
            : '--'; //cardExpire 替换
      } else {
        return cardExpire != null
            ? '${MyTimeUtil.getYMDime(MyTimeUtil.timestampToDate(cardExpire!.toInt()), format: 'yyyy-MM-dd HH:mm')} ${LocaleKeys.user271.tr}'
            : '--'; //cardExpire 替换
      }
    }
  }

  String get contractNameStr => contractName?.isNotEmpty == true ? contractName! : LocaleKeys.public35.tr;

  bool get isStandardContract => cardType == 1 ? true : false;

  bool get isBonus => type == 1;

  String get followName => followNames ?? '';
  String get followId => followUids != null ? followUids!.split(',').first : '';

  String get coinName {
    if (contractName?.isNotEmpty == true) {
      var str = contractName!.split(',').first;
      if (isStandardContract) {
        return "B_0_${str.replaceAll('-', '')}".toLowerCase();
      } else {
        return "E_${str.replaceAll('-', '')}".toLowerCase();
      }
    } else {
      return '';
    }
  }

  //   String get icon => imgUrl != null && imgUrl!.isNotEmpty ? imgUrl! : "default/avatar_default".pngAssets();
  // String get winRateStr => getmRateConvert(winRateWeek);
  // Color get winRateColor => getmColor(winRateWeek);
  // String get monthProfitRateStr => getmRateConvert(monthProfitRate, isRound: false);
  // Color get monthProfitRateColor => getmColor(monthProfitRate);

  // String get monthProfitAmountStr => '\$${getmConvert(monthProfitAmount)}';
  // Color get monthProfitAmountColor => getmColor(monthProfitAmount);
  // String get profitAmountStr => getmConvert(profitAmount);
  // String get labelStr => label.isNotEmpty ? label : ''; //'这个人很懒，什么也没留下'

  // String get copyAmountStr => '\$${getmConvert(copyAmount)}';
  // bool get isFollow => isFollowStart == 1 ? true : false;

  // String get positionSizeStr => positionSize != null && positionSize! > 0 ? '' : LocaleKeys.follow243.tr;

  // String get timeStr => ctime == null
  //     ? ''
  //     : '${MyTimeUtil.getYMDime(MyTimeUtil.timestampToDate(ctime!.toInt()).toLocal())} ${LocaleKeys.follow245.tr}';
  // String get startCountStr => startCount == null ? '0' : startCount!.toString();
  // bool get isSmart => copyMode == 2 ? true : false;
}
