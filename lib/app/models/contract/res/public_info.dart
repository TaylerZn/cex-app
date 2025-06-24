import 'dart:ui';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_cell_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class PublicInfo {
  /// websocket地址
  String wsUrl;

  /// 保证⾦币种列表（别名）
  List<String> marginCoinList;

  /// 合约列表
  List<ContractInfo> contractList;

  /// 系统当前时间戳
  num currentTimeMillis;

  /// 真实保证⾦币种集合
  List<String> originalCoinList;
  List<LangInfo> langList;

  /// 合约产品说明url
  String contractProInfo;

  PublicInfo({
    required this.wsUrl,
    required this.marginCoinList,
    required this.contractList,
    required this.currentTimeMillis,
    required this.originalCoinList,
    required this.langList,
    required this.contractProInfo,
  });

  factory PublicInfo.fromJson(Map<String, dynamic> json) => PublicInfo(
        wsUrl: json["wsUrl"],
        marginCoinList: List<String>.from(json["marginCoinList"].map((x) => x)),
        contractList: List<ContractInfo>.from(
            json["contractList"].map((x) => ContractInfo.fromJson(x))),
        currentTimeMillis: json["currentTimeMillis"],
        originalCoinList:
            List<String>.from(json["originalCoinList"].map((x) => x)),
        langList: List<LangInfo>.from(
            json["langList"].map((x) => LangInfo.fromJson(x))),
        contractProInfo: json["contractProInfo"],
      );

  Map<String, dynamic> toJson() => {
        "wsUrl": wsUrl,
        "marginCoinList": List<dynamic>.from(marginCoinList.map((x) => x)),
        "contractList": List<dynamic>.from(contractList.map((x) => x.toJson())),
        "currentTimeMillis": currentTimeMillis,
        "originalCoinList": List<dynamic>.from(originalCoinList.map((x) => x)),
        "langList": List<dynamic>.from(langList.map((x) => x.toJson())),
        "contractProInfo": contractProInfo,
      };
}

/// 合约信息
class ContractInfo with TickerMixin {
  /// 合约id
  num id;

  /// 合约名称
  String contractName;

  /// 合约标识
  String symbol;

  /// 合约类型 E:永续合约 S:模拟合约 H: 混合合约
  String contractType;

  /// 合约类型 E:永续合约 S:模拟合约 H: 混合合约
  // String? coType;

  /// 合约类型 , 转义后展示字段
  // String contractShowType;

  /// 交割周期
  // String deliveryKind;

  /// 合约方向 1:正向合约 2:反向合约
  // num contractSide;

  /// 合约⾯值
  num multiplier;

  /// 保证金币种（注意别名）
  String multiplierCoin;

  /// 保证金币种
  String marginCoin;

  /// 原始币种
  // String originalCoin;

  /// 保证⾦汇率
  num marginRate;

  ///  收取资⾦费率开始时间(整点时间0-23)
  // num capitalStartTime;

  /// 间隔多⻓时间(单位：⼩时)
  num capitalFrequency;

  /// 结算频率(单位：分钟)
  // num settlementFrequency;

  /// 专属客户id，1表示⽆
  // num brokerId;

  /// 基准货币(数量单位)
  String base;

  /// 计价货币(价格单位)
  String quote;

  /// 币种币对配置对象
  CoinResultVo? coinResultVo;

  /// 排序
  num sort;

  /// 系统配置最⼤杠杆
  // num maxLever;

  /// 系统配置最⼩杠杆
  // num minLever;

  /// 合约别名
  String contractOtherName;

  /// 合约分类:合约分类 1,USDT合约 2,币本位合约 3,混合合约 4,模拟合
  // num? classification;

  /// 真实类型_币对
  String subSymbol;
  String coinAlias;

  /// 滑点
  num slippage;

  //标识股票类型
  String market;

  num kind = 0;

  String get getContractType {
    if (contractType == 'E') {
      return LocaleKeys.trade7.tr;
    } else if (contractType == 'S') {
      return '模拟';
    } else if (contractType == 'H') {
      return '混合';
    }
    return LocaleKeys.trade6.tr;
  }

  ContractInfo({
    required this.id,
    required this.contractName,
    required this.symbol,
    required this.contractType,
    // required this.coType,
    // required this.contractShowType,
    // required this.deliveryKind,
    // required this.contractSide,
    required this.multiplier,
    required this.multiplierCoin,
    required this.marginCoin,
    // required this.originalCoin,
    required this.marginRate,
    // required this.capitalStartTime,
    required this.capitalFrequency,
    // required this.settlementFrequency,
    // required this.brokerId,
    required this.base,
    required this.quote,
    required this.coinResultVo,
    required this.sort,
    // required this.maxLever,
    // required this.minLever,
    required this.contractOtherName,
    // required this.classification,
    required this.subSymbol,
    required this.coinAlias,
    required this.slippage,
    required this.market,
  }) {
    type = contractType;
    splitName = symbol;
    precisionNum = coinResultVo?.symbolPricePrecision.toInt() ?? 4;
    coinAliasStr = coinAlias;
  }

  factory ContractInfo.fromJson(Map<String, dynamic> json) => ContractInfo(
      id: json["id"] ?? 0,
      contractName: json["contractName"] ?? '',
      symbol: json["symbol"] ?? '',
      contractType: json["contractType"] ?? 'E',
      // coType: json["coType"] ?? 'E',
      // contractShowType: json["contractShowType"] ?? '',
      // deliveryKind: json["deliveryKind"] ?? '',
      // contractSide: json["contractSide"] ?? 1,
      multiplier: json["multiplier"] ?? 0,
      multiplierCoin: json["multiplierCoin"] ?? '',
      marginCoin: json["marginCoin"] ?? '',
      // originalCoin: json["originalCoin"] ?? '',
      marginRate: json["marginRate"] ?? 0,
      // capitalStartTime: json["capitalStartTime"] ?? 0,
      capitalFrequency: json["capitalFrequency"] ?? 0,
      // settlementFrequency: json["settlementFrequency"] ?? 0,
      // brokerId: json["brokerId"] ?? 0,
      base: json["base"] ?? '',
      quote: json["quote"] ?? '',
      coinResultVo: json['coinResultVo'] != null
          ? CoinResultVo.fromJson(json["coinResultVo"])
          : null,
      sort: json["sort"] ?? 0,
      // maxLever: json["maxLever"] ?? 0,
      // minLever: json["minLever"] ?? 0,
      contractOtherName: json["contractOtherName"] ?? '',
      // classification: json["classification"] ?? 1,
      subSymbol: json["subSymbol"] ?? '',
      coinAlias: json["coinAlias"] ?? '',
      slippage: json["slippage"] ?? 0,
      market: json["market"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "contractName": contractName,
        "symbol": symbol,
        "contractType": contractType,
        // "coType": coType,
        // "contractShowType": contractShowType,
        // "deliveryKind": deliveryKind,
        // "contractSide": contractSide,
        "multiplier": multiplier,
        "multiplierCoin": multiplierCoin,
        "marginCoin": marginCoin,
        // "originalCoin": originalCoin,
        "marginRate": marginRate,
        // "capitalStartTime": capitalStartTime,
        "capitalFrequency": capitalFrequency,
        // "settlementFrequency": settlementFrequency,
        // "brokerId": brokerId,
        "base": base,
        "quote": quote,
        "coinResultVo": coinResultVo?.toJson(),
        "sort": sort,
        // "maxLever": maxLever,
        // "minLever": minLever,
        "contractOtherName": contractOtherName,
        // "classification": classification,
        "subSymbol": subSymbol,
        "coinAlias": coinAlias,
        "slippage": slippage,
        "market": market
      };
}

class CoinResultVo {
  /// 合约币对价格精度
  num symbolPricePrecision;

  /// 深度数组
  List<String> depth;

  /// 最⼩下单量
  num minOrderVolume;

  /// 最⼩下单⾦额
  num minOrderMoney;

  /// 市价单最⼤下单数量
  num maxMarketVolume;

  /// 市价单最⼤下单⾦额
  num maxMarketMoney;

  /// 限价单最⼤下单数量
  num maxLimitVolume;

  /// 限价单最⼤下单⾦额
  num maxLimitMoney;

  /// 下单价格最⼤偏离⽐例（不带百分号）
  num priceRange;

  /// 保证⾦币种显示精度
  num marginCoinPrecision;

  /// 资⾦划⼊状态
  num fundsInStatus;

  /// 资⾦划出状态
  num fundsOutStatus;

  CoinResultVo({
    required this.symbolPricePrecision,
    required this.depth,
    required this.minOrderVolume,
    required this.minOrderMoney,
    required this.maxMarketVolume,
    required this.maxMarketMoney,
    required this.maxLimitVolume,
    required this.maxLimitMoney,
    required this.priceRange,
    required this.marginCoinPrecision,
    required this.fundsInStatus,
    required this.fundsOutStatus,
  });

  factory CoinResultVo.fromJson(Map<String, dynamic> json) => CoinResultVo(
        symbolPricePrecision: json["symbolPricePrecision"],
        depth: List<String>.from(json["depth"].map((x) => x)),
        minOrderVolume: json["minOrderVolume"],
        minOrderMoney: json["minOrderMoney"],
        maxMarketVolume: json["maxMarketVolume"],
        maxMarketMoney: json["maxMarketMoney"],
        maxLimitVolume: json["maxLimitVolume"],
        maxLimitMoney: json["maxLimitMoney"],
        priceRange: json["priceRange"],
        marginCoinPrecision: json["marginCoinPrecision"],
        fundsInStatus: json["fundsInStatus"],
        fundsOutStatus: json["fundsOutStatus"],
      );

  Map<String, dynamic> toJson() => {
        "symbolPricePrecision": symbolPricePrecision,
        "depth": List<dynamic>.from(depth.map((x) => x)),
        "minOrderVolume": minOrderVolume,
        "minOrderMoney": minOrderMoney,
        "maxMarketVolume": maxMarketVolume,
        "maxMarketMoney": maxMarketMoney,
        "maxLimitVolume": maxLimitVolume,
        "maxLimitMoney": maxLimitMoney,
        "priceRange": priceRange,
        "marginCoinPrecision": marginCoinPrecision,
        "fundsInStatus": fundsInStatus,
        "fundsOutStatus": fundsOutStatus,
      };
}

/// 语言状态
class LangInfo {
  /// id
  num id;

  /// 语言类型
  num type; // app 2

  /// 语言key
  String langKey_;

  /// 兼容后端语言配置错误，el_GR 为希腊语，实际为繁体中文
  String get langKey {
    // el_GR 为希腊语，实际为繁体中文
    if (langKey_ == 'el_GR') {
      return 'zh_TW';
    }
    // xl_XL 为希腊语，正确的为 el_GR
    if (langKey_ == 'xl_XL') {
      return 'el_GR';
    }
    return langKey_;
  }

  /// 语言描述
  String langName;

  /// 文件名
  String fileName;

  /// 0:停⽤ 1:启⽤
  num status;

  /// 编辑语⾔包地址
  String nowFileAddress;

  /// 参照语⾔包地址
  String backupFileAddress;

  /// 排序
  num sort;

  /// 创建时间
  String ctime;

  /// 修改时间
  String mtime;

  static LangInfo defaultLangInfo = LangInfo(
    id: 102,
    type: 2,
    langKey_: 'en_US',
    langName: 'English',
    fileName: '',
    status: 1,
    nowFileAddress:
        "https://s3.ap-northeast-1.amazonaws.com/tradog-test/exchange_app_en_US.json",
    backupFileAddress:
        "https://chainup-test.s3.ap-northeast-1.amazonaws.com/language-conf/exchange/APP/en_US.json",
    sort: 2,
    ctime: '2023-03-09T08:36:41',
    mtime: '2024-03-01T10:29:41',
  );

  Locale get locale {
    if (langKey_.isEmpty) return const Locale('en', 'US');
    String languageCode = langKey.split('_')[0];
    String countryCode = langKey.split('_')[1];
    return Locale(languageCode, countryCode);
  }

  LangInfo({
    required this.id,
    required this.type,
    required this.langKey_,
    required this.langName,
    required this.fileName,
    required this.status,
    required this.nowFileAddress,
    required this.backupFileAddress,
    required this.sort,
    required this.ctime,
    required this.mtime,
  });

  factory LangInfo.fromJson(Map<String, dynamic> json) => LangInfo(
        id: json["id"],
        type: json["type"],
        langKey_: json["langKey"],
        langName: json["langName"],
        fileName: json["fileName"],
        status: json["status"],
        nowFileAddress: json["nowFileAddress"],
        backupFileAddress: json["backupFileAddress"],
        sort: json["sort"],
        ctime: json["ctime"].toString(),
        mtime: json["mtime"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "langKey": langKey_,
        "langName": langName,
        "fileName": fileName,
        "status": status,
        "nowFileAddress": nowFileAddress,
        "backupFileAddress": backupFileAddress,
        "sort": sort,
        "ctime": ctime,
        "mtime": mtime,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LangInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          langKey_ == other.langKey_ &&
          langName == other.langName &&
          fileName == other.fileName;

  @override
  int get hashCode =>
      id.hashCode ^ langKey_.hashCode ^ langName.hashCode ^ fileName.hashCode;
}
