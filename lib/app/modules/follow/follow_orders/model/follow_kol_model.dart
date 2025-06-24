import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

mixin PagingModel {
  int pageSize = 10;
  int page = 1;
  bool haveMore = false;

  // String getmConvert(num? number, {bool isText = true}) {
  //   return isText ? NumberUtil.mConvert((number ?? 0).toString(), count: 2) : '******';
  // }

  String getmRateConvert(num? number, {bool isText = true, bool isRound = true, bool havePrefix = true}) {
    return isText
        ? '${(number ?? 0) > 0 ? havePrefix ? '+' : '' : ''}${getmConvert(number, isRound: isRound)}%'
        : '******';
  }

  Color getmColor(num? number) {
    return (number ?? 0) >= 0 ? AppColor.upColor : AppColor.downColor;
  }

  getmConvert(num? number, {bool isText = true, bool isDefault = true, bool isRound = true, int? pricePrecision}) {
    number = number ?? 0;
    if (isText) {
      String numberString = number.toString();
      int decimalDigits =
          pricePrecision ?? (isDefault ? 2 : (numberString.contains('.') ? numberString.split('.')[1].length : 0));

      if (isRound) {
        final formatter = NumberFormat('#,##0${decimalDigits > 0 ? '.${'0' * decimalDigits}' : ''}');
        return formatter.format(number);
      } else {
        String numberStr = number.toString();
        List<String> parts = numberStr.split('.');
        String integerPart = parts[0];
        String decimalPart = parts.length > 1 ? parts[1] : '';

        if (decimalPart.length > 2) {
          decimalPart = decimalPart.substring(0, 2);
        } else if (decimalPart.length < 2) {
          decimalPart = decimalPart.padRight(2, '0');
        }
        String adjustedNumberStr = '$integerPart.$decimalPart';
        NumberFormat formatter = NumberFormat('#,##0${decimalDigits > 0 ? '.${'0' * decimalDigits}' : ''}');
        return formatter.format(double.parse(adjustedNumberStr));
      }
    } else {
      return '******';
    }
  }
}

mixin PagingError {
  bool? isError;
  DioException? exception;
  String? get errText {
    if (isError != null) {
      return isError! ? LocaleKeys.follow244.tr : LocaleKeys.public8.tr;
    } else {
      return null;
    }
  }
}

class FollowKolListModel with PagingModel, PagingError {
  num? isOpenScale;
  num? count;
  List<FollowKolInfo>? list;
  List<FollowKolInfo>? hotList;
  List<FollowKolInfo>? steadyList;
  List<FollowKolInfo>? tenThousandfoldList;

  FollowKolListModel({this.isOpenScale, this.count, this.list, this.hotList, this.steadyList, this.tenThousandfoldList});

  FollowKolListModel.fromJson(Map<String, dynamic> json) {
    isOpenScale = json['isOpenScale'];
    count = json['count'];
    if (json['list'] != null) {
      list = <FollowKolInfo>[];
      json['list'].forEach((v) {
        list!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['hotList'] != null) {
      hotList = <FollowKolInfo>[];
      json['hotList'].forEach((v) {
        hotList!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['steadyList'] != null) {
      steadyList = <FollowKolInfo>[];
      json['steadyList'].forEach((v) {
        steadyList!.add(FollowKolInfo.fromJson(v));
      });
    }
    if (json['tenThousandfoldList'] != null) {
      tenThousandfoldList = <FollowKolInfo>[];
      json['tenThousandfoldList'].forEach((v) {
        tenThousandfoldList!.add(FollowKolInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isOpenScale'] = isOpenScale;
    data['count'] = count;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (hotList != null) {
      data['hotList'] = hotList!.map((v) => v.toJson()).toList();
    }
    if (steadyList != null) {
      data['steadyList'] = steadyList!.map((v) => v.toJson()).toList();
    }
    if (tenThousandfoldList != null) {
      data['tenThousandfoldList'] = tenThousandfoldList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowKolInfo with PagingModel {
  String userName = '';
  String? coinSymbol;
  num winRateWeek = 0;
  num? profitRate;
  num profitAmount = 0;
  num? singleMinAmount;
  num? singleMaxAmount;
  num? orderNumber;
  num uid = -1;
  num? sort;
  num? totalNumber;
  num? maxNumber;
  num? currentNumber;
  num? switchFollowerNumber;
  num? followStatus;
  num? lastTradeTime;
  String label = '';
  List? profitRateList;
  List? symbolList;
  num? copyAmount;
  String? imgUrl;
  num? winRate;
  num monthProfitRate = 0;
  num monthProfitAmount = 0;
  num? monthDeficitAmount;
  num? applyFollowStatus;
  num? copySwitch;
  num? isFollowStart;
  num? isBlacklistedUsers;
  num? isDisableUsers;

  num? positionSize;
  num? ctime;
  num? startCount;

  num? topicId;
  dynamic topicNo;
  String? topicTitle;
  String? topicType;
  num? copyMode;
  int currentIndex = 0;

  //v2
  num? compositeScore;
  num? grade;
  List? monthProfitRateList;
  num? traderScore;

  //v3
  int? levelType;

  //v4
  String flagIcon = '';
  String organizationIcon = '';
  List? tradingStyleLabel;
  List? tradingPairType;
  num? userRating;
  num? riskRating;
  num? weekNum;
  List<RecordVoListItem>? recordVoList;
  String? signatureInfo;
  num rate = 0;

  FollowKolInfo({
    this.userName = '',
    this.coinSymbol,
    this.winRateWeek = 0,
    this.profitRate,
    this.profitAmount = 0,
    this.singleMinAmount,
    this.singleMaxAmount,
    this.orderNumber,
    this.uid = -1,
    this.sort,
    this.totalNumber,
    this.maxNumber,
    this.currentNumber,
    this.switchFollowerNumber,
    this.followStatus,
    this.lastTradeTime,
    this.label = '',
    this.profitRateList,
    this.symbolList,
    this.copyAmount,
    this.imgUrl,
    this.winRate,
    this.monthProfitRate = 0,
    this.monthProfitAmount = 0,
    this.monthDeficitAmount,
    this.copySwitch,
    this.applyFollowStatus,
    this.isBlacklistedUsers,
    this.isDisableUsers,
    this.isFollowStart,
    this.positionSize,
    this.topicId,
    this.topicNo,
    this.ctime,
    this.startCount,
    this.topicTitle,
    this.topicType,
    this.copyMode,
    this.compositeScore,
    this.grade,
    this.monthProfitRateList,
    this.levelType,
    this.traderScore,
    this.recordVoList,
    this.rate = 0,
  });

  FollowKolInfo.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'] ?? '';
    coinSymbol = json['coin_symbol'];
    winRateWeek = json['win_rate_week'] ?? 0;
    profitRate = json['profit_rate'];
    profitAmount = json['profit_amount'] ?? 0;
    singleMinAmount = json['single_min_amount'];
    singleMaxAmount = json['single_max_amount'];
    orderNumber = json['order_number'];
    uid = json['uid'] ?? -1;
    sort = json['sort'];
    totalNumber = json['total_number'];
    maxNumber = json['maxNumber'];
    currentNumber = json['current_number'];
    switchFollowerNumber = json['switchFollowerNumber'];
    followStatus = json['follow_status'];
    lastTradeTime = json['last_trade_time'];
    label = json['label'] ?? '';
    profitRateList = json['profitRateList'];
    symbolList = json['symbolList'];
    copyAmount = json['copyAmount'] ?? 0;
    imgUrl = json['imgUrl'];
    winRate = json['winRate'];
    monthProfitRate = json['monthProfitRate'] ?? 0;
    monthProfitAmount = json['monthProfitAmount'] ?? 0;
    monthDeficitAmount = json['monthDeficitAmount'];
    applyFollowStatus = json['applyFollowStatus'];
    copySwitch = json['copySwitch'];
    isFollowStart = json['isFollowStart'];
    isBlacklistedUsers = json['isBlacklistedUsers'];
    isDisableUsers = json['isDisableUsers'];
    positionSize = json['positionSize'];
    topicNo = json['topicNo'];
    topicId = json['topicId'];
    topicTitle = json['topicTitle'];
    topicType = json['topicType'];
    copyMode = json['copyMode'];
    compositeScore = json['compositeScore'];
    grade = json['grade'];
    monthProfitRateList = json['monthProfitRateList'];
    levelType = json['levelType'];
    traderScore = json['traderScore'];
    flagIcon = json['flagIcon'] ?? '';
    organizationIcon = json['organizationIcon'] ?? '';
    tradingStyleLabel = json['tradingStyleLabel'];
    tradingPairType = json['tradingPairType'];
    userRating = json['userRating'];
    riskRating = json['riskRating'];
    weekNum = json['weekNum'];
    recordVoList = json['recordVoList'] == null
        ? []
        : List<RecordVoListItem>.from(json['recordVoList'].map((x) => RecordVoListItem.fromJson(x)));
    signatureInfo = json['signatureInfo'];
    rate = json['rate'] ?? 0;

    isFollowObs.value = isFollow;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['coin_symbol'] = coinSymbol;
    data['win_rate_week'] = winRateWeek;
    data['profit_rate'] = profitRate;
    data['profit_amount'] = profitAmount;
    data['single_min_amount'] = singleMinAmount;
    data['single_max_amount'] = singleMaxAmount;
    data['order_number'] = orderNumber;
    data['uid'] = uid;
    data['sort'] = sort;
    data['total_number'] = totalNumber;
    data['maxNumber'] = maxNumber;
    data['current_number'] = currentNumber;
    data['switchFollowerNumber'] = switchFollowerNumber;
    data['follow_status'] = followStatus;
    data['last_trade_time'] = lastTradeTime;
    data['label'] = label;
    data['profitRateList'] = profitRateList;
    data['symbolList'] = symbolList;
    data['copyAmount'] = copyAmount;
    data['imgUrl'] = imgUrl;
    data['winRate'] = winRate;
    data['monthProfitRate'] = monthProfitRate;
    data['monthProfitAmount'] = monthProfitAmount;
    data['monthDeficitAmount'] = monthDeficitAmount;
    data['applyFollowStatus'] = applyFollowStatus;
    data['copySwitch'] = copySwitch;
    data['isFollowStart'] = isFollowStart;
    data['isBlacklistedUsers'] = isBlacklistedUsers;
    data['isDisableUsers'] = isDisableUsers;
    data['positionSize'] = positionSize;
    data['topicNo'] = topicNo;
    data['topicId'] = topicId;
    data['topicTitle'] = topicTitle;
    data['topicType'] = topicType;
    data['copyMode'] = copyMode;
    data['compositeScore'] = compositeScore;
    data['grade'] = grade;
    data['monthProfitRateList'] = monthProfitRateList;
    data['levelType'] = levelType;
    data['traderScore'] = traderScore;
    data['recordVoList'] = recordVoList == null ? [] : List<dynamic>.from(recordVoList!.map((x) => x.toJson()));
    data['signatureInfo'] = signatureInfo;

    return data;
  }

  String get icon => imgUrl != null && imgUrl!.isNotEmpty ? imgUrl! : "default/avatar_default".pngAssets();

  String get winRateStr => getmRateConvert(winRate, havePrefix: false);

  Color get winRateColor => getmColor(winRate);

  String get monthProfitRateStr => getmRateConvert(monthProfitRate, isRound: false);

  Color get monthProfitRateColor => getmColor(monthProfitRate);

  String get monthProfitAmountStr => '\$${getmConvert(monthProfitAmount)}';

  Color get monthProfitAmountColor => getmColor(monthProfitAmount);

  String get profitAmountStr => getmConvert(profitAmount);

  String get labelStr => label.isNotEmpty ? label : LocaleKeys.follow497.tr;

  String get copyAmountStr => '\$${getmConvert(copyAmount)}';

  bool get isFollow => isFollowStart == 1 ? true : false;

  String get positionSizeStr => positionSize != null && positionSize! > 0 ? '' : LocaleKeys.follow243.tr;

  // String get timeStr => ctime == null
  //     ? ''
  //     : '${MyTimeUtil.getYMDime(MyTimeUtil.timestampToDate(ctime!.toInt()).toLocal())} ${LocaleKeys.follow245.tr}';
  String get startCountStr => startCount == null ? '0' : startCount!.toString();

  bool get isSmart => copyMode == 2 ? true : false;

  String get compositeScoreStr => compositeScore != null ? compositeScore.toString() : '0';

  double get traderScoreStart => (traderScore ?? 0) / 20;

  //v4
  String get tradingStyleStr => tradingStyleLabel?.isNotEmpty == true ? tradingStyleLabel!.first : '';

  List get tradingPairList =>
      tradingPairType?.isNotEmpty == true ? tradingPairType!.sublist(0, min(2, tradingPairType!.length)) : [];

  List get organizationIconList {
    var array = organizationIcon.split(',');

    array = array.sublist(0, min(2, array.length));
    return array;
  }

  double get userRatingNum => (userRating ?? 0).toDouble();

  String get riskRatingStr => riskRating != null ? riskRating!.toString() : '0';

  String get weekNumStr => weekNum != null ? '$weekNum' : '0';
  var isFollowObs = false.obs;

  String get signatureInfoStr => signatureInfo?.isNotEmpty == true ? signatureInfo! : LocaleKeys.follow497.tr;

  Color get riskRatingColor {
    if (riskRating != null) {
      if (riskRating! < 3) {
        return AppColor.upColor;
      } else if (riskRating! > 3 && riskRating! < 8) {
        return const Color(0XFFFF8800);
      } else {
        return const Color(0XFFF54B45);
      }
    } else {
      return AppColor.upColor;
    }
  }
}

class RecordVoListItem {
  String? email;
  num? profit;

  RecordVoListItem({
    this.email,
    this.profit,
  });

  factory RecordVoListItem.fromRawJson(String str) => RecordVoListItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecordVoListItem.fromJson(Map<String, dynamic> json) => RecordVoListItem(
        email: json["email"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "profit": profit,
      };
}
