import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_explore.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowkolUserDetailModel with PagingModel {
  String userName = '';
  String? imgUrl;
  num? startCount;
  num? positionSize;
  num? ctime;
  num? isKol;
  String label = '';
  String? labelDesc;
  String? identityDesc;
  num? isFollowStart;
  num? switchFollowerNumber;
  num? applyFollowStatus;
  num? isBlacklistedUsers;
  num? isDisableUsers;
  num? copySwitch;
  num? copySetting;
  num? hisSetting;
  num? followSetting;
  num? followStatus;
  num? fanNum;
  num? focusNum;

//01
  List? monthProfit;
  num? monthProfitRate;
  num? monthProfitAmount;
  num? copyMode;
  String? signatureInfo;
  //02
  int? levelType;

  //v3
  num uid = -1;

  //v4
  String flagIcon = '';
  String organizationIcon = '';
  List? tradingStyleLabel;
  List? tradingPairType;
  String countryEnName = '';
  String leveTag = '';
  List? symbolList;

  //-------------------------
  var labelStr = ''.obs;
  var rating = 5.obs;
  var valueType = 0.obs;
  var gridModel = FollowExploreGridModel().obs;

  FollowkolUserDetailModel({
    this.userName = '',
    this.imgUrl,
    this.startCount,
    this.positionSize,
    this.ctime,
    this.isKol,
    this.fanNum,
    this.focusNum,
    this.label = '',
    this.labelDesc,
    this.isFollowStart,
    this.switchFollowerNumber,
    this.applyFollowStatus,
    this.isBlacklistedUsers,
    this.isDisableUsers,
    this.copySwitch,
    this.identityDesc,
    this.signatureInfo,
    this.copyMode,
    this.levelType,
    this.flagIcon = '',
    this.uid = -1,
  });

  FollowkolUserDetailModel.fromJson(Map<String, dynamic> json) {
    userName = json['name'] ?? '';
    imgUrl = json['imgUrl'];
    startCount = json['startCount'];
    positionSize = json['positionSize'];
    ctime = json['ctime'];
    isKol = json['isKol'];
    focusNum = json['focusNum'];
    fanNum = json['fanNum'];
    identityDesc = json['identityDesc'];
    label = json['label'] ?? '';
    labelDesc = json['labelDesc'];
    isFollowStart = json['isFollowStart'];
    switchFollowerNumber = json['switchFollowerNumber'];
    applyFollowStatus = json['applyFollowStatus'];
    isBlacklistedUsers = json['isBlacklistedUsers'];
    isDisableUsers = json['isDisableUsers'];
    copySwitch = json['copySwitch'];
    copySetting = json['copySetting'];
    followStatus = json['follow_status'];
    signatureInfo = json['signatureInfo'];
    monthProfit = json['monthProfit'];
    monthProfitRate = json['monthProfitRate'];
    monthProfitAmount = json['monthProfitAmount'];
    copyMode = json['copyModel'];
    hisSetting = json['hisSetting'];
    followSetting = json['followSetting'];
    levelType = json['levelType'];

    flagIcon = json['flagIcon'] ?? '';
    organizationIcon = json['organizationIcon'] ?? '';
    tradingStyleLabel = json['tradingStyleLabel'];
    tradingPairType = json['tradingPairType'];
    countryEnName = json['countryEnName'] ?? '';
    leveTag = json['leveTag'] ?? '';
    symbolList = json['symbolList'];

    labelStr.value = signatureStr;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = userName;
    data['imgUrl'] = imgUrl;
    data['startCount'] = startCount;
    data['positionSize'] = positionSize;
    data['ctime'] = ctime;
    data['isKol'] = isKol;
    data['label'] = label;
    data['labelDesc'] = labelDesc;
    data['signatureInfo'] = signatureInfo;
    data['identityDesc'] = identityDesc;
    data['isFollowStart'] = isFollowStart;
    data['switchFollowerNumber'] = switchFollowerNumber;
    data['applyFollowStatus'] = applyFollowStatus;
    data['isBlacklistedUsers'] = isBlacklistedUsers;
    data['isDisableUsers'] = isDisableUsers;
    data['copySwitch'] = copySwitch;
    data['copySetting'] = copySetting;
    data['follow_status'] = followStatus;
    data['copyMode'] = copyMode;
    data['hisSetting'] = hisSetting;
    data['followSetting'] = followSetting;
    data['levelType'] = levelType;

    data['flagIcon'] = flagIcon;
    data['organizationIcon'] = organizationIcon;
    data['tradingStyleLabel'] = tradingStyleLabel;
    data['tradingPairType'] = tradingPairType;
    data['countryEnName'] = countryEnName;
    data['leveTag'] = leveTag;
    data['symbolList'] = symbolList;

    return data;
  }

  String get sheareTime => MyTimeUtil.uaTime();

  String get icon => imgUrl?.isNotEmpty == true ? imgUrl! : "default/avatar_default".pngAssets();
  String get monthProfitAmountStr => getmConvert(monthProfitAmount);
  String get monthProfitRateStr => getmRateConvert(monthProfitRate);
  Color get monthProfitRateColor => getmColor(monthProfitRate);
  bool get isSmart => copyMode == 2 ? true : false;

  bool get isFollow => isFollowStart == 1 ? true : false;

  //v4
  String get tradingStyleStr => tradingStyleLabel?.isNotEmpty == true ? tradingStyleLabel!.first : '';

  List get tradingPairList =>
      tradingPairType?.isNotEmpty == true ? tradingPairType!.sublist(0, min(2, tradingPairType!.length)) : [];
  List get authenticationList => [identityDesc ?? ''];

  String get signatureStr => signatureInfo?.isNotEmpty == true ? signatureInfo! : LocaleKeys.follow497.tr;

  List<List<String>> get symbolIconList {
    // symbolList = [
    //   "B_0-BCH-USDT",
    //   "B_0-BTC-USDT",
    //   // "B_0-ETH-USDT",
    //   // "B_0-BCH-USDT",
    //   // "B_0-BTC-USDT",
    //   // "B_0-ETH-USDT",
    //   // "B_0-BCH-USDT",
    //   // "B_0-BTC-USDT",
    //   // "B_0-ETH-USDT",
    //   // "B_0-BCH-USDT",
    //   // "B_0-BTC-USDT",
    //   // "B_0-ETH-USDT",
    //   // "B_0-BCH-USDT",
    //   // "B_0-BTC-USDT",
    //   // "B_0-ETH-USDT",
    // ];

    List<String> array = [];

    symbolList?.forEach((element) {
      var name = (element as String).split('-').length > 1 ? (element).split('-')[1] : '';

      var urlStr = MarketDataManager.instance.getIconWithName(name);

      if (urlStr.contains('http')) {
        array.add(urlStr);
      }
    });
    array = array.sublist(0, min(15, array.length));

    List<String> arr1 = [];
    List<String> arr2 = [];

    for (var i = 0; i < array.length; i++) {
      if (i < 8) {
        arr1.add(array[i]);
      } else {
        arr2.add(array[i]);
      }
    }

    return [arr1, arr2];
  }

  List get organizationIconList {
    var array = organizationIcon.split(',');

    array = array.sublist(0, min(2, array.length));

    return array;
  }
}
