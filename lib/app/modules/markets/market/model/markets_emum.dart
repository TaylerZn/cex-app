import 'package:get/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///TabBar类型 枚举
enum MarketFirstType {
  optional,
  market,
  community;

  String get value => [
        LocaleKeys.markets1.tr,
        LocaleKeys.markets2.tr,
        LocaleKeys.markets3.tr,
      ][index];
  String get tag => ['行情自选', '行情行情', '行情社区'][index];
}

enum MarketSecondType {
  standardContract,
  perpetualContract,
  spot,
  standardContractOnly;

  String get value => [
        LocaleKeys.markets7.tr,
        LocaleKeys.markets8.tr,
        LocaleKeys.markets9.tr,
        LocaleKeys.markets7.tr,
      ][index];
  String get tag => ['标准合约', '永续合约', '现货', '标准合约'][index];
}

enum MarketThirdType {
  all,
  crypto,
  stocks,
  eTFs,
  forex,
  bulk,
  metals,
  other;

  String get typeName => ['B_all', 'B_0', 'B_1', 'B_2', 'B_3', 'B_4', 'B_5', 'B_6'][index];
  String get tag => ['全部', '加密货币', '股票', '指数', '外汇', '大宗', 'ETF', '其他'][index];

  String get value => [
        LocaleKeys.public35.tr,
        LocaleKeys.markets32.tr,
        LocaleKeys.markets11.tr,
        LocaleKeys.markets12.tr,
        LocaleKeys.markets13.tr,
        LocaleKeys.markets14.tr,
        'ETF',
        LocaleKeys.markets15.tr,
      ][index];
}

enum MarketFourType {
  stockAll,
  stockUS,
  stockHK,
  stockOther;

  String get typeName => ['STOCK-ALL', 'STOCK-US', 'STOCK-HK', ''][index];
  String get tag => ['全部', '美股', '港股', '其他'][index];
  String get value => [
        LocaleKeys.public35.tr,
        LocaleKeys.markets33.tr,
        LocaleKeys.markets34.tr,
        LocaleKeys.markets15.tr,
      ][index];
}

enum MarketFourFilter {
  defaultFilter,
  downFilter,
  upFilter;
}

enum MarketHomeFirstType {
  optional,
  crypto,
  stocks,
  eTFs,
  forex,
  bulk,
  metals,
  other;

  String get typeName => ['', 'B_0', 'B_1', 'B_2', 'B_3', 'B_4', 'B_5', 'B_6'][index];
  String get tag => ['自选', '加密货币', '股票', '指数', '外汇', '大宗', 'ETF', '其他'][index];

  String get value => [
        LocaleKeys.markets1.tr,
        LocaleKeys.markets32.tr,
        LocaleKeys.markets11.tr,
        LocaleKeys.markets12.tr,
        LocaleKeys.markets13.tr,
        LocaleKeys.markets14.tr,
        'ETF',
        LocaleKeys.markets15.tr,
      ][index];
  // hot,
  // riseList,
  // fallList,
  // volume;

  // String get tag => ['自选', '热门', '涨幅榜', '跌幅榜', '成交量'][index];
  // String get value => [
  //       LocaleKeys.markets1.tr,
  //       LocaleKeys.markets20.tr,
  //       LocaleKeys.markets21.tr,
  //       LocaleKeys.markets22.tr,
  //       LocaleKeys.markets23.tr
  //     ][index];
}

enum MarketHomeThirdType {
  all,
  crypto,
  stocks,
  eTFs,
  forex,
  bulk,
  metals,
  other;

  String get typeName => ['B_all', 'B_0', 'B_1', 'B_2', 'B_3', 'B_4', 'B_5', 'B_6'][index];
  String get tag => ['全部', '加密货币', '股票', '指数', '外汇', '大宗', 'ETF', '其他'][index];

  String get value => [
        LocaleKeys.public35.tr,
        LocaleKeys.markets32.tr,
        LocaleKeys.markets11.tr,
        LocaleKeys.markets12.tr,
        LocaleKeys.markets13.tr,
        LocaleKeys.markets14.tr,
        'ETF',
        LocaleKeys.markets15.tr,
      ][index];
}

enum MarketHomeFourType {
  coinName,
  latestPrice,
  riseAndFall;

  String get value => [LocaleKeys.markets10, LocaleKeys.markets18, LocaleKeys.markets19][index];
}

enum MarketHomeFourFilter {
  defaultFilter,
  downFilter,
  upFilter;
}
