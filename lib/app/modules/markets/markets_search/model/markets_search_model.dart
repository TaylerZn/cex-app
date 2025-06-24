import 'package:nt_app_flutter/app/modules/markets/market/model/markets_ticker_model.dart';

class MarketRecommend {
  List<MarketRecommendModel>? recommendSymbolList;

  MarketRecommend({this.recommendSymbolList});

  MarketRecommend.fromJson(Map<String, dynamic> json) {
    if (json['recommendSymbolList'] != null) {
      recommendSymbolList = <MarketRecommendModel>[];
      json['recommendSymbolList'].forEach((v) {
        recommendSymbolList!.add(MarketRecommendModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recommendSymbolList != null) {
      data['recommendSymbolList'] = recommendSymbolList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarketRecommendModel {
  String? symbol;
  TickerModel? ticker;

  MarketRecommendModel({this.symbol, this.ticker});

  MarketRecommendModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    ticker = TickerModel.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['ticker'] = ticker?.toJson();
    return data;
  }
}

class MarketSearchResModel {
  String symbol = '';
  String price = '';
  String rate = '';
}
