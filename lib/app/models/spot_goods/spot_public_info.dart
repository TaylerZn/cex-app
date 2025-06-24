// To parse this JSON data, do
//
//     final spotPublicInfo = spotPublicInfoFromJson(jsonString);

import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

class SpotPublicInfo {
  // Map<String, CoinList?>? coinList;
  String? otcUrl;
  String? depositOpen;
  Map<String, String>? emailOptCode;
  List<dynamic>? limitCountryList;
  Map<String, String>? smsOptCode;
  KlineColor? klineColor;
  // Map<String,MarketInfoRateModel>? rate;
  String? otcOpen;
  String? maketIndex;
  Lan? lan;
  List<String>? klineScale;
  int? isNewContract;
  String? contractOpen;
  String? footerStyle;
  String? mobileOpen;
  List<LangInfo>? langList;
  List<String>? marketSort;
  String? bankNameEqualAuth;
  Map<String, Map<String, MarketInfoModel>>? market;
  String? wsUrl;
  String? sharingPage;
  String? ncLang;
  AppLogoList? appLogoList;
  String? ncAppkey;
  String? defaultCountryCode;
  String? verificationType;
  String? h5MiningStyle;

  SpotPublicInfo({
    // required this.coinList,
    required this.otcUrl,
    required this.depositOpen,
    required this.emailOptCode,
    required this.limitCountryList,
    required this.smsOptCode,
    required this.klineColor,
    // required this.rate,
    required this.otcOpen,
    required this.maketIndex,
    required this.lan,
    required this.klineScale,
    required this.isNewContract,
    required this.contractOpen,
    required this.footerStyle,
    required this.mobileOpen,
    required this.langList,
    required this.marketSort,
    required this.bankNameEqualAuth,
    required this.market,
    required this.wsUrl,
    required this.sharingPage,
    required this.ncLang,
    required this.appLogoList,
    required this.ncAppkey,
    required this.defaultCountryCode,
    required this.verificationType,
    required this.h5MiningStyle,
  });

  factory SpotPublicInfo.fromJson(Map<String, dynamic> json) => SpotPublicInfo(
        // coinList: Map.from(json["coinList"])
        //     .map((k, v) => MapEntry<String, CoinList>(k, CoinList.fromJson(v))),
        otcUrl: json["otcUrl"],
        depositOpen: json["depositOpen"],
        emailOptCode: Map.from(json["emailOptCode"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        limitCountryList:
            List<dynamic>.from(json["limitCountryList"].map((x) => x)),
        smsOptCode: Map.from(json["smsOptCode"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        klineColor: KlineColor.fromJson(json["klineColor"]),
        // rate: Map.from(json["rate"]).map((k, v) => MapEntry<String, MarketInfoRateModel>(k, MarketInfoRateModel.fromJson(v))),
        otcOpen: json["otcOpen"],
        maketIndex: json["maket_index"],
        lan: Lan.fromJson(json["lan"]),
        klineScale: List<String>.from(json["klineScale"].map((x) => x)),
        isNewContract: json["isNewContract"],
        contractOpen: json["contractOpen"],
        footerStyle: json["footer_style"],
        mobileOpen: json["mobileOpen"],
        langList: List<LangInfo>.from(
            json["langList"].map((x) => LangInfo.fromJson(x))),
        marketSort: List<String>.from(json["marketSort"].map((x) => x)),
        bankNameEqualAuth: json["bank_name_equal_auth"],
        market: Map.from(json["market"]).map((k, v) =>
            MapEntry<String, Map<String, MarketInfoModel>>(
                k,
                Map.from(v).map((k, v) => MapEntry<String, MarketInfoModel>(
                    k, MarketInfoModel.fromJson(v))))),
        wsUrl: json["wsUrl"],
        sharingPage: json["sharingPage"],
        ncLang: json["nc_lang"],
        appLogoList: AppLogoList.fromJson(json["app_logo_list"]),
        ncAppkey: json["nc_appkey"],
        defaultCountryCode: json["default_country_code"],
        verificationType: json["verificationType"],
        h5MiningStyle: json["h5_mining_style"],
      );
}

class AppLogoList {
  String loginLogo;
  String startupLogo;
  String userCenterLogo;
  String marketLogo;

  AppLogoList({
    required this.loginLogo,
    required this.startupLogo,
    required this.userCenterLogo,
    required this.marketLogo,
  });

  factory AppLogoList.fromJson(Map<String, dynamic> json) => AppLogoList(
        loginLogo: json["login_logo"],
        startupLogo: json["startup_logo"],
        userCenterLogo: json["user_center_logo"],
        marketLogo: json["market_logo"],
      );

  Map<String, dynamic> toJson() => {
        "login_logo": loginLogo,
        "startup_logo": startupLogo,
        "user_center_logo": userCenterLogo,
        "market_logo": marketLogo,
      };
}

class CoinList {
  int isOvercharge;
  String showName;
  int otcOpen;
  String name;
  String icon;
  int tagType;
  int sort;
  String tokenBase;
  int showPrecision;

  CoinList({
    required this.isOvercharge,
    required this.showName,
    required this.otcOpen,
    required this.name,
    required this.icon,
    required this.tagType,
    required this.sort,
    required this.tokenBase,
    required this.showPrecision,
  });

  factory CoinList.fromJson(Map<String, dynamic> json) => CoinList(
        isOvercharge: json["isOvercharge"],
        showName: json["showName"],
        otcOpen: json["otcOpen"],
        name: json["name"],
        icon: json["icon"],
        tagType: json["tagType"],
        sort: json["sort"],
        tokenBase: json["tokenBase"],
        showPrecision: json["showPrecision"],
      );

  Map<String, dynamic> toJson() => {
        "isOvercharge": isOvercharge,
        "showName": showName,
        "otcOpen": otcOpen,
        "name": name,
        "icon": icon,
        "tagType": tagType,
        "sort": sort,
        "tokenBase": tokenBase,
        "showPrecision": showPrecision,
      };
}

class KlineColor {
  String up;
  String down;

  KlineColor({
    required this.up,
    required this.down,
  });

  factory KlineColor.fromJson(Map<String, dynamic> json) => KlineColor(
        up: json["up"],
        down: json["down"],
      );

  Map<String, dynamic> toJson() => {
        "up": up,
        "down": down,
      };
}

class Lan {
  String defLan;
  List<LanList> lanList;

  Lan({
    required this.defLan,
    required this.lanList,
  });

  factory Lan.fromJson(Map<String, dynamic> json) => Lan(
        defLan: json["defLan"],
        lanList:
            List<LanList>.from(json["lanList"].map((x) => LanList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "defLan": defLan,
        "lanList": List<dynamic>.from(lanList.map((x) => x.toJson())),
      };
}

class LanList {
  String name;
  String id;

  LanList({
    required this.name,
    required this.id,
  });

  factory LanList.fromJson(Map<String, dynamic> json) => LanList(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
