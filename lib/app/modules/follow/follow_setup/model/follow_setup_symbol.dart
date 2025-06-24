class FollowSetupSymbol {
  List<CoinList>? coinList;
  List? symbolList;

  FollowSetupSymbol({this.coinList, this.symbolList});

  FollowSetupSymbol.fromJson(Map<String, dynamic> json) {
    if (json['coinList'] != null) {
      coinList = <CoinList>[];
      json['coinList'].forEach((v) {
        coinList!.add(CoinList.fromJson(v));
      });
    }
    if (json['symbolList'] != null) {
      symbolList = [];
      json['symbolList'].forEach((v) {
        symbolList!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (coinList != null) {
      data['coinList'] = coinList!.map((v) => v.toJson()).toList();
    }
    if (symbolList != null) {
      data['symbolList'] = symbolList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoinList {
  String? coin;
  num? type;
  num? amount;

  CoinList({this.coin, this.type, this.amount});

  CoinList.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    type = json['type'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['coin'] = coin;
    data['type'] = type;
    data['amount'] = amount;
    return data;
  }
}

class SymbolList {
  String? symbol;
  int? instrumentId;
  String? marginCoin;
  int? lever;

  SymbolList({this.symbol, this.instrumentId, this.marginCoin, this.lever});

  SymbolList.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    instrumentId = json['instrumentId'];
    marginCoin = json['marginCoin'];
    lever = json['lever'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['symbol'] = symbol;
    data['instrumentId'] = instrumentId;
    data['marginCoin'] = marginCoin;
    data['lever'] = lever;
    return data;
  }
}
