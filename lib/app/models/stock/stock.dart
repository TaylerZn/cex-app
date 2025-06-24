/// 股票列表数据模型
class StockRes {
  List<Stock>? data;
  int? total;
  int? pageSize;
  int? currentPage;
  int? totalPage;

  StockRes(
      {this.data, this.total, this.pageSize, this.currentPage, this.totalPage});

  StockRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Stock>[];
      json['data'].forEach((v) {
        data!.add(new Stock.fromJson(v));
      });
    }
    total = json['total'];
    pageSize = json['pageSize'];
    currentPage = json['currentPage'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['pageSize'] = this.pageSize;
    data['currentPage'] = this.currentPage;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

/// 股票数据模型
class Stock {
  int? id;
  String? name;
  String? symbol;
  String? micCode;
  String? datetime;
  String? price;
  List<StockMarket>? list;
  String? volume;
  String? changeRate;
  String? open;
  String? close;
  String? high;
  String? low;
  String? currency;
  bool? isMarketOpen;
  String? source;
  String? logo;
  String? dateFormat;

  Stock(
      {this.id,
      this.name,
      this.symbol,
      this.micCode,
      this.datetime,
      this.price,
      this.list,
      this.volume,
      this.changeRate,
      this.open,
      this.close,
      this.high,
      this.low,
      this.currency,
      this.isMarketOpen,
      this.source,
      this.logo,
      this.dateFormat});

  static Map<String,dynamic> json = {
    "id": 31093,
    "name": "长和",
    "symbol": "00001.hk",
    "micCode": null,
    "datetime": null,
    "open": null,
    "close": null,
    "high": null,
    "low": null,
    "volume": "100",
    "price": "39.5",
    "currency": "CNY",
    "list": [
      {
        "datetime": null,
        "time": null,
        "date": "2024-02-02",
        "open": "40.90000",
        "close": "40.65000",
        "high": "41.40000",
        "low": "40.30000",
        "volume": "3553665",
        "isMarketOpen": null
      },
      {
        "datetime": null,
        "time": null,
        "date": "2024-02-01",
        "open": "40.40000",
        "close": "40.45000",
        "high": "40.80000",
        "low": "39.90000",
        "volume": "2980145",
        "isMarketOpen": null
      }
    ],
    "isMarketOpen": false,
    "source": null,
    "logo": "https://nt-dev.oss-ap-southeast-1.aliyuncs.com/head/ded97a251ac04088b4845eeb27a72076.jpg",
    "dateFormat": null,
    "changeRate": "-1.85185"
  };

  Stock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    micCode = json['micCode'];
    datetime = json['datetime'];
    price = json['price'];
    if (json['list'] != null) {
      list = <StockMarket>[];
      json['list'].forEach((v) {
        list!.add(StockMarket.fromJson(v));
      });
    }
    volume = json['volume'];
    changeRate = json['changeRate'];
    open = json['open'];
    close = json['close'];
    high = json['high'];
    low = json['low'];
    currency = json['currency'];
    isMarketOpen = json['isMarketOpen'];
    source = json['source'];
    logo = json['logo'];
    dateFormat = json['dateFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['micCode'] = this.micCode;
    data['datetime'] = this.datetime;
    data['price'] = this.price;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['volume'] = this.volume;
    data['changeRate'] = this.changeRate;
    data['open'] = this.open;
    data['close'] = this.close;
    data['high'] = this.high;
    data['low'] = this.low;
    data['currency'] = this.currency;
    data['isMarketOpen'] = this.isMarketOpen;
    data['source'] = this.source;
    data['logo'] = this.logo;
    data['dateFormat'] = this.dateFormat;
    return data;
  }
}

/// 股票市场数据模型
class StockMarket {
  String? volume;
  String? datetime;
  String? high;
  String? low;
  String? close;
  String? open;

  StockMarket(
      {this.volume, this.datetime, this.high, this.low, this.close, this.open});

  StockMarket.fromJson(Map<String, dynamic> json) {
    volume = json['volume'];
    datetime = json['datetime'];
    high = json['high'];
    low = json['low'];
    close = json['close'];
    open = json['open'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['volume'] = this.volume;
    data['datetime'] = this.datetime;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['open'] = this.open;
    return data;
  }
}
