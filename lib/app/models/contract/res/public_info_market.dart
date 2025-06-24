// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_cell_model.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

import '../../spot_goods/spot_order_res.dart';

class PublicInfoMarket {
  MarketInfo? market; //Currency pairs per market
  FollowCoinList? followCoinList; //From coin list
  List<MarketInfoRateModel>? rate;
  List<String>? marketSort; //currency
  int? localPublicInfoTime;
  String? localPublicInfoTimeFormat;
  Map<String, MarketInfoCoinModel>? coinInfoMap = {};

  PublicInfoMarket(
      {this.market,
      this.followCoinList,
      this.localPublicInfoTimeFormat,
      this.rate,
      this.marketSort,
      this.localPublicInfoTime});

  PublicInfoMarket.fromJson(Map<String, dynamic> json) {
    market =
        json['market'] != null ? MarketInfo.fromJson(json['market']) : null;
    followCoinList = json['followCoinList'] != null
        ? FollowCoinList.fromJson(json['followCoinList'])
        : null;
    localPublicInfoTimeFormat = json['localPublicInfoTimeFormat'];
    rate = json["rate"] == null
        ? []
        : List<MarketInfoRateModel>.from(
            json["rate"]!.map((x) => MarketInfoRateModel.fromJson(x)));
    coinInfoMap =
        json['coinList'] != null ? coinInfoMapFromJson(json['coinList']) : null;
    marketSort = json['marketSort']?.cast<String>();
    localPublicInfoTime = json['localPublicInfoTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (market != null) {
      data['market'] = market!.toJson();
    }
    if (followCoinList != null) {
      data['followCoinList'] = followCoinList!.toJson();
    }
    data['localPublicInfoTimeFormat'] = localPublicInfoTimeFormat;

    data["rate"] =
        rate == null ? [] : List<dynamic>.from(rate!.map((x) => x.toJson()));
    data['coinInfoMap'] = coinInfoMapToJson();
    data['marketSort'] = marketSort;
    data['localPublicInfoTime'] = localPublicInfoTime;
    return data;
  }

  Map<String, MarketInfoCoinModel> coinInfoMapFromJson(
      Map<String, dynamic> json) {
    Map<String, MarketInfoCoinModel> tempMap = {};
    json.forEach((key, value) {
      tempMap[key] = MarketInfoCoinModel.fromJson(value);
    });
    return tempMap;
  }

  coinInfoMapToJson() {
    var tempMap = {};
    coinInfoMap?.forEach((key, value) {
      tempMap[key] = value.toJson();
    });
    return tempMap;
  }
}

class MarketInfo {
  List<MarketInfoModel>? bTC;
  List<MarketInfoModel>? uSDT;
  MarketInfo({this.bTC, this.uSDT});

  MarketInfo.fromJson(Map<String, dynamic> json) {
    bTC = json['BTC'] != null
        ? (json['BTC'] as Map)
            .values
            .map((e) => MarketInfoModel.fromJson(e))
            .toList()
        : null;
    uSDT = json['USDT'] != null
        ? (json['USDT'] as Map)
            .values
            .map((e) => MarketInfoModel.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bTC != null) {
      data['BTC'] = bTC!.map((e) => e.toJson()).toList();
    }
    if (uSDT != null) {
      data['USDT'] = uSDT!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class MarketInfoModel with TickerMixin {
  num? limitVolumeMin;
  // num? isOpenLever;
  String symbol = '';
  String showName = '';
  // num? marketBuyMin;
  // num? isGridOpen;
  // num? multiple;
  // num? isOnlyHoldShow;
  // num? marketSellMin;
  num sort = 100000;
  // num? etfOpen;
  String? quoteFeeRate;
  // num? newcoinFlag;
  // num? isShow;
  num volume = 0;
  String? depth;
  num price = 0;
  // String? isMine;
  // String? name;
  // num? limitPriceMin;
  // String? isLimitPlat;
  // num? openQuoteFee;
  // String? longName;

  int get precision => depth?.split(',').first.toNum().numDecimalPlaces() ?? 0;

  /// 现货精度对象
  SpotOrderRes? spotOrderRes;

  MarketInfoModel();
  MarketInfoModel.fromJson(Map<String, dynamic> json) {
    // limitVolumeMin = json['limitVolumeMin'];
    // isOpenLever = json['isOpenLever'];
    symbol = json['symbol'] ?? '';
    showName = json['showName'] ?? '';
    // marketBuyMin = json['marketBuyMin'];
    // isGridOpen = json['is_grid_open'];
    // multiple = json['multiple'];
    // isOnlyHoldShow = json['isOnlyHoldShow'];
    // marketSellMin = json['marketSellMin'];
    sort = json['sort'] ?? 100000;
    // etfOpen = json['etfOpen'];
    quoteFeeRate = json['quoteFeeRate'] is String
        ? json['quoteFeeRate']
        : json['quoteFeeRate'] is num
            ? json['quoteFeeRate'].toString()
            : '';
    // newcoinFlag = json['newcoinFlag'];
    // isShow = json['isShow'];
    volume = json['volume'] ?? 0;
    depth = json['depth'];
    price = json['price'] ?? 0;
    // isMine = json['IsMine'];
    // name = json['name'];
    // limitPriceMin = json['limitPriceMin'];
    // isLimitPlat = json['IsLimitPlat'];
    // openQuoteFee = json['openQuoteFee'];
    // longName = json['longName'];
    splitName = showName;
    precisionNum = volume.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['limitVolumeMin'] = limitVolumeMin;
    // data['isOpenLever'] = isOpenLever;
    data['symbol'] = symbol;
    data['showName'] = showName;
    // data['marketBuyMin'] = marketBuyMin;
    // data['is_grid_open'] = isGridOpen;
    // data['multiple'] = multiple;
    // data['isOnlyHoldShow'] = isOnlyHoldShow;
    // data['marketSellMin'] = marketSellMin;
    data['sort'] = sort;
    // data['etfOpen'] = etfOpen;
    data['quoteFeeRate'] = quoteFeeRate;
    // data['newcoinFlag'] = newcoinFlag;
    // data['isShow'] = isShow;
    data['volume'] = volume;
    data['depth'] = depth;
    data['price'] = price;
    // data['IsMine'] = isMine;
    // data['name'] = name;
    // data['limitPriceMin'] = limitPriceMin;
    // data['IsLimitPlat'] = isLimitPlat;
    // data['openQuoteFee'] = openQuoteFee;
    // data['longName'] = longName;
    return data;
  }
}

class FollowCoinList {
  // APO? uSDT;
  List<FollowCoinInfoModel>? uSDT;

  FollowCoinList({this.uSDT});

  FollowCoinList.fromJson(Map<String, dynamic> json) {
    uSDT = json['USDT'] != null
        ? (json['USDT'] as Map)
            .values
            .map((e) => FollowCoinInfoModel.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uSDT != null) {
      data['USDT'] = uSDT!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class FollowCoinInfoModel {
  String? showName;
  String? coinTag;
  String? mainChainName;
  String? icon;
  num? sort;
  String? tokenBase;
  num? depositOpen;
  String? mainChainSymbol;
  num? otcOpen;
  String? name;
  num? tagType;
  num? mainChainType;
  num? showPrecision;
  num? withdrawOpen;

  FollowCoinInfoModel(
      {this.showName,
      this.coinTag,
      this.mainChainName,
      this.icon,
      this.sort,
      this.tokenBase,
      this.depositOpen,
      this.mainChainSymbol,
      this.otcOpen,
      this.name,
      this.tagType,
      this.mainChainType,
      this.showPrecision,
      this.withdrawOpen});

  FollowCoinInfoModel.fromJson(Map<String, dynamic> json) {
    showName = json['showName'];
    coinTag = json['coinTag'];
    mainChainName = json['mainChainName'];
    icon = json['icon'];
    sort = json['sort'];
    tokenBase = json['tokenBase'];
    depositOpen = json['depositOpen'];
    mainChainSymbol = json['mainChainSymbol'];
    otcOpen = json['otcOpen'];
    name = json['name'];
    tagType = json['tagType'];
    mainChainType = json['mainChainType'];
    showPrecision = json['showPrecision'];
    withdrawOpen = json['withdrawOpen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['showName'] = showName;
    data['coinTag'] = coinTag;
    data['mainChainName'] = mainChainName;
    data['icon'] = icon;
    data['sort'] = sort;
    data['tokenBase'] = tokenBase;
    data['depositOpen'] = depositOpen;
    data['mainChainSymbol'] = mainChainSymbol;
    data['otcOpen'] = otcOpen;
    data['name'] = name;
    data['tagType'] = tagType;
    data['mainChainType'] = mainChainType;
    data['showPrecision'] = showPrecision;
    data['withdrawOpen'] = withdrawOpen;
    return data;
  }
}

// class MarketInfoRateModel extends ISuspensionBean {
//   String? tagIndex;
//   String? aPO;
//   String? coinPrecision;
//   String? bCH;
//   String? uSD;
//   String? langCoin;
//   String? eOS;
//   String? uSDT;
//   String? bTC;
//   String? uNI;
//   String? langLogo;
//   String? coinFiatPrecision;
//   String? eTC;
//   String? bRD;
//   String? eTH;
//   String? lINK;
//   String? lTC;
//   String? tRX;

//   MarketInfoRateModel(
//       {this.tagIndex,
//       this.aPO,
//       this.coinPrecision,
//       this.bCH,
//       this.uSD,
//       this.langCoin,
//       this.eOS,
//       this.uSDT,
//       this.bTC,
//       this.uNI,
//       this.langLogo,
//       this.coinFiatPrecision,
//       this.eTC,
//       this.bRD,
//       this.eTH,
//       this.lINK,
//       this.lTC,
//       this.tRX});

//   MarketInfoRateModel.fromJson(Map<String, dynamic> json) {
//     tagIndex = json['tagIndex'];
//     aPO = json['APO'] is String
//         ? json['APO']
//         : json['APO'] is num
//             ? json['APO'].toString()
//             : '';
//     coinPrecision = json['coin_precision'] is String
//         ? json['coin_precision']
//         : json['coin_precision'] is num
//             ? json['coin_precision'].toString()
//             : '';
//     bCH = json['BCH'] is String
//         ? json['BCH']
//         : json['BCH'] is num
//             ? json['BCH'].toString()
//             : '';
//     uSD = json['USD'] is String
//         ? json['USD']
//         : json['USD'] is num
//             ? json['USD'].toString()
//             : '';
//     langCoin = json['lang_coin'] is String
//         ? json['lang_coin']
//         : json['lang_coin'] is num
//             ? json['lang_coin'].toString()
//             : '';
//     eOS = json['EOS'] is String
//         ? json['EOS']
//         : json['EOS'] is num
//             ? json['EOS'].toString()
//             : '';
//     uSDT = json['USDT'] is String
//         ? json['USDT']
//         : json['USDT'] is num
//             ? json['USDT'].toString()
//             : '';
//     bTC = json['BTC'] is String
//         ? json['BTC']
//         : json['BTC'] is num
//             ? json['BTC'].toString()
//             : '';
//     uNI = json['UNI'] is String
//         ? json['UNI']
//         : json['UNI'] is num
//             ? json['UNI'].toString()
//             : '';
//     langLogo = json['lang_logo'] is String
//         ? json['lang_logo']
//         : json['lang_logo'] is num
//             ? json['lang_logo'].toString()
//             : '';
//     coinFiatPrecision = json['coin_fiat_precision'] is String
//         ? json['coin_fiat_precision']
//         : json['coin_fiat_precision'] is num
//             ? json['coin_fiat_precision'].toString()
//             : '';
//     eTC = json['ETC'] is String
//         ? json['ETC']
//         : json['ETC'] is num
//             ? json['ETC'].toString()
//             : '';
//     bRD = json['BRD'] is String
//         ? json['BRD']
//         : json['BRD'] is num
//             ? json['BRD'].toString()
//             : '';
//     eTH = json['ETH'] is String
//         ? json['ETH']
//         : json['ETH'] is num
//             ? json['ETH'].toString()
//             : '';
//     lINK = json['LINK'] is String
//         ? json['LINK']
//         : json['LINK'] is num
//             ? json['LINK'].toString()
//             : '';
//     lTC = json['LTC'] is String
//         ? json['LTC']
//         : json['LTC'] is num
//             ? json['LTC'].toString()
//             : '';
//     tRX = json['TRX'] is String
//         ? json['TRX']
//         : json['TRX'] is num
//             ? json['TRX'].toString()
//             : '';
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['tagIndex'] = tagIndex;
//     data['APO'] = aPO;
//     data['coin_precision'] = coinPrecision;
//     data['BCH'] = bCH;
//     data['USD'] = uSD;
//     data['lang_coin'] = langCoin;
//     data['EOS'] = eOS;
//     data['USDT'] = uSDT;
//     data['BTC'] = bTC;
//     data['UNI'] = uNI;
//     data['lang_logo'] = langLogo;
//     data['coin_fiat_precision'] = coinFiatPrecision;
//     data['ETC'] = eTC;
//     data['BRD'] = bRD;
//     data['ETH'] = eTH;
//     data['LINK'] = lINK;
//     data['LTC'] = lTC;
//     data['TRX'] = tRX;
//     return data;
//   }

//   // @override
//   // String getSuspensionTag() {
//   //   // TODO: implement getSuspensionTag
//   //   throw UnimplementedError();
//   // }

//   @override
//   String getSuspensionTag() => tagIndex as String;

//   //   @override
//   // String getSuspensionTag() => tagIndex ?? '';
// }

class MarketInfoCoinModel {
  String? showName;
  String? coinTag;
  num? otcOpen;
  String? name;
  String? icon;
  num? tagType;
  num? sort;
  String? tokenBase;
  num? showPrecision;

  MarketInfoCoinModel(
      {this.showName,
      this.coinTag,
      this.otcOpen,
      this.name,
      this.icon,
      this.tagType,
      this.sort,
      this.tokenBase,
      this.showPrecision});

  MarketInfoCoinModel.fromJson(Map<String, dynamic> json) {
    showName = json['showName'];
    coinTag = json['coinTag'];
    otcOpen = json['otcOpen'];
    name = json['name'];
    icon = json['icon'];
    tagType = json['tagType'];
    sort = json['sort'];
    tokenBase = json['tokenBase'];
    showPrecision = json['showPrecision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['showName'] = showName;
    data['coinTag'] = coinTag;
    data['otcOpen'] = otcOpen;
    data['name'] = name;
    data['icon'] = icon;
    data['tagType'] = tagType;
    data['sort'] = sort;
    data['tokenBase'] = tokenBase;
    data['showPrecision'] = showPrecision;
    return data;
  }
}

class MarketInfoRateModel extends ISuspensionBean {
  String? tagIndex;
  String? apo;
  String? coinPrecision;
  String? bch;
  String? usd;
  String? langCoin;
  String? eos;
  String? usdt;
  String? doge;
  String? langType;
  String? btc;
  String? uni;
  String? avax;
  String? langLogo;
  String? coinFiatPrecision;
  String? etc;
  String? brd;
  String? xrp;
  String? eth;
  String? xlm;
  String? link;
  String? ltc;
  String? trx;

  MarketInfoRateModel({
    this.tagIndex,
    this.apo,
    this.coinPrecision,
    this.bch,
    this.usd,
    this.langCoin,
    this.eos,
    this.usdt,
    this.doge,
    this.langType,
    this.btc,
    this.uni,
    this.avax,
    this.langLogo,
    this.coinFiatPrecision,
    this.etc,
    this.brd,
    this.xrp,
    this.eth,
    this.xlm,
    this.link,
    this.ltc,
    this.trx,
  });

  factory MarketInfoRateModel.fromRawJson(String str) =>
      MarketInfoRateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketInfoRateModel.fromJson(Map<String, dynamic> json) =>
      MarketInfoRateModel(
        tagIndex: json["tagIndex"],
        apo: json["APO"],
        coinPrecision: json["coin_precision"],
        bch: json["BCH"],
        usd: json["USD"],
        langCoin: json["lang_coin"],
        eos: json["EOS"],
        usdt: json["USDT"],
        doge: json["DOGE"],
        langType: json["langType"],
        btc: json["BTC"],
        uni: json["UNI"],
        avax: json["AVAX"],
        langLogo: json["lang_logo"],
        coinFiatPrecision: json["coin_fiat_precision"],
        etc: json["ETC"],
        brd: json["BRD"],
        xrp: json["XRP"],
        eth: json["ETH"],
        xlm: json["XLM"],
        link: json["LINK"],
        ltc: json["LTC"],
        trx: json["TRX"],
      );

  Map<String, dynamic> toJson() => {
        'tagIndex': tagIndex,
        "APO": apo,
        "coin_precision": coinPrecision,
        "BCH": bch,
        "USD": usd,
        "lang_coin": langCoin,
        "EOS": eos,
        "USDT": usdt,
        "DOGE": doge,
        "langType": langType,
        "BTC": btc,
        "UNI": uni,
        "AVAX": avax,
        "lang_logo": langLogo,
        "coin_fiat_precision": coinFiatPrecision,
        "ETC": etc,
        "BRD": brd,
        "XRP": xrp,
        "ETH": eth,
        "XLM": xlm,
        "LINK": link,
        "LTC": ltc,
        "TRX": trx,
      };

  @override
  String getSuspensionTag() => tagIndex as String;
}
