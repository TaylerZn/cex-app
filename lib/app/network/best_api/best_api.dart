import 'package:flutter/foundation.dart';

class BestApi {
  static Api devApi = Api(
      baseUrl: 'https://appapi-dev.tradevert.co',
      otcUrl: 'https://otcapi-dev.tradevert.co',
      moonpayBuyUrl: 'buy-sandbox.moonpay.com',
      standardReqWsUrl: 'wss://standard-futuresws-dev.tradevert.co/v2',
      moonpaySellUrl: 'sell-sandbox.moonpay.com',
      futureWsUrl: 'ws://10.20.184.249:6363/websocket',
      contractUrl: 'https://futuresappapi-dev.tradevert.co',
      contractWsUrl: 'wss://futuresws-dev.tradevert.co/webSocket',
      spotWsUrl: 'wss://ws-dev.tradevert.co/kline-api/ws',
      standardUrl: 'https://standard-futuresappapi-dev.tradevert.co',
      standardWsUrl: 'wss://standard-futuresws-dev.tradevert.co/kline-api/ws',
      imUrl: 'wss://otcws-dev.tradevert.co/chatServer',
      welfareUrl: 'https://www-dev.tradevert.co/welfare-center',
      followUrl: 'https://follow-dev.tradevert.co');

  static Api testApi = Api(
      baseUrl: 'http://appapi.tradingcex.com',
      otcUrl: 'http://otcapi.tradingcex.com',
      moonpayBuyUrl: 'buy-sandbox.moonpay.com',
      moonpaySellUrl: 'sell-sandbox.moonpay.com',
      standardReqWsUrl: 'wss://standard-futuresws.tradingcex.com/v2/',
      futureWsUrl: 'wss://futuresws.tradingcex.com/websocket',
      contractUrl: 'http://futuresappapi.tradingcex.com',
      contractWsUrl: 'wss://futuresws.tradingcex.com/webSocket',
      spotWsUrl: 'wss://ws.tradingcex.com/kline-api/ws',
      standardUrl: 'http://standard-futuresappapi.tradingcex.com',
      standardWsUrl: 'ws://standard-futuresws.tradingcex.com/kline-api/ws',
      imUrl: 'wss://otcws.tradingcex.com/chatServer',
      welfareUrl: 'http://www.tradingcex.com/welfare-center',
      followUrl: 'http://follow.tradingcex.com');
  // static Api testApi = Api(
  //   // baseUrl: 'https://appapi-test.tradevert.co',
  //     baseUrl: 'http://192.168.112.133:8228',
  //     otcUrl: 'https://otcapi-test.tradevert.co',
  //     moonpayBuyUrl: 'buy-sandbox.moonpay.com',
  //     moonpaySellUrl: 'sell-sandbox.moonpay.com',
  //     standardReqWsUrl: 'wss://standard-futuresws-test.tradevert.co/v2/',
  //     futureWsUrl: 'wss://futuresws-test.tradevert.co/v2/',
  //     contractUrl: 'https://futuresappapi-test.tradevert.co',
  //     contractWsUrl: 'wss://futuresws-test.tradevert.co/webSocket',
  //     spotWsUrl: 'wss://ws-test.tradevert.co/kline-api/ws',
  //     standardUrl: 'https://standard-futuresappapi-test.tradevert.co',
  //     standardWsUrl: 'wss://standard-futuresws-test.tradevert.co/kline-api/ws',
  //     imUrl: 'wss://otcws-test.tradevert.co/chatServer',
  //     welfareUrl: 'https://www-test.tradevert.co/welfare-center',
  //     followUrl: 'https://follow-test.tradevert.co');

  static Api preApi = Api(
      baseUrl: 'https://appapi-pre.tradevert.co',
      otcUrl: 'https://otcapi-pre.tradevert.co',
      moonpayBuyUrl: 'buy.moonpay.com',
      moonpaySellUrl: 'sell.moonpay.com',
      standardReqWsUrl: 'wss://standard-futuresws-pre.tradevert.co/v2/',
      futureWsUrl: 'wss://futuresws-pre.tradevert.co/v2/',
      contractUrl: 'https://futuresappapi-pre.tradevert.co',
      contractWsUrl: 'wss://futuresws-pre.tradevert.co/webSocket',
      spotWsUrl: 'wss://ws-pre.tradevert.co/kline-api/ws',
      standardUrl: 'https://standard-futuresappapi-pre.tradevert.co',
      standardWsUrl: 'wss://standard-futuresws-pre.tradevert.co/kline-api/ws',
      imUrl: 'wss://otcws-pre.tradevert.co/chatServer',
      welfareUrl: 'https://www-pre.tradevert.co/welfare-center',
      followUrl: 'https://follow-pre.tradevert.co');

  static Api prodApi = Api(
      baseUrl: 'https://appapi.uptx.com',
      otcUrl: 'https://otcappapi.uptx.com',
      moonpayBuyUrl: 'buy.moonpay.com',
      moonpaySellUrl: 'sell.moonpay.com',
      standardReqWsUrl: 'wss://standard-futuresws.tradevert.co/v2/',
      futureWsUrl: 'wss://futuresws-test.tradevert.co/v2/',
      contractUrl: 'https://futuresappapi.uptx.com',
      contractWsUrl: 'wss://futuresws.uptx.com/webSocket',
      spotWsUrl: 'wss://ws.uptx.com/kline-api/ws',
      standardUrl: 'https://standard-futuresappapi.uptx.com',
      standardWsUrl: 'wss://standard-futuresws.uptx.com/kline-api/ws',
      imUrl: 'wss://otcws.uptx.com/chatServer',
      welfareUrl: 'https://www.uptx.com/welfare-center',
      followUrl: 'https://follow.uptx.com');

  static Api getApi() {
    switch (apiType) {
      case ApiType.dev:
        return devApi;
      case ApiType.test:
        return testApi;
      case ApiType.pre:
        return preApi;
      case ApiType.prod:
        return prodApi;
    }
  }
}

ApiType apiType = ApiType.test;

enum ApiType {
  dev, //开发环境
  test, //测试环境
  pre, //预发布环境
  prod, //正式环境
}

class Api {
  // 基础url
  String baseUrl;
  // otc-url
  String otcUrl;
  // moonpay-url
  String moonpayBuyUrl;
  String moonpaySellUrl;
  // 合约url
  String contractUrl;
  // 合约ws url
  String contractWsUrl;
  //代替合约接口轮训
  String futureWsUrl;
  //代替合约接口轮训
  String standardReqWsUrl;

  // 现货ws url
  String spotWsUrl;
  // 标准合约url
  String standardUrl;
  // 标准合约ws url
  String standardWsUrl;
  // im url
  String imUrl;
  // 福利中心
  String welfareUrl;
  //跟单
  String followUrl;

  Api(
      {required this.baseUrl,
      required this.otcUrl,
      required this.moonpayBuyUrl,
      required this.moonpaySellUrl,
      required this.contractUrl,
      required this.contractWsUrl,
      required this.spotWsUrl,
      required this.futureWsUrl,
      required this.standardReqWsUrl,
      required this.standardUrl,
      required this.standardWsUrl,
      required this.imUrl,
      required this.welfareUrl,
      required this.followUrl});
}

const kTimerDurationSec = kDebugMode ? 1200 : 5;
const assetTimerDurationSec = kDebugMode ? 1200 : 60;
const contractTimerDurationSec = kDebugMode ? 1200 : 5;
