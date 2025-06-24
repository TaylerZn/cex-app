class TickerModel {
  String? symbol;
  String? amount;
  String? high;
  String? vol;
  String? low;
  String? rose;
  String? close;
  String? open;

  TickerModel({this.symbol, this.amount, this.high, this.vol, this.low, this.rose, this.close, this.open});

  TickerModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    amount = json['amount'];
    high = json['high'];
    vol = json['vol'];
    low = json['low'];
    rose = json['rose'];
    close = json['close'];
    open = json['open'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['amount'] = amount;
    data['high'] = high;
    data['vol'] = vol;
    data['low'] = low;
    data['rose'] = rose;
    data['close'] = close;
    data['open'] = open;
    return data;
  }
}
