
class SpotGoodsOrderRes {
  num? pricePrecision;
  String? symbol;
  String? price;
  String? countCoinBalance;
  String? minVolume;
  String? minPrice;
  num? count;
  List<SpotGoodsOrder>? orderList;
  String? baseCoinBalance;
  num? volumePrecision;

  SpotGoodsOrderRes(
      {this.pricePrecision,
        this.symbol,
        this.price,
        this.countCoinBalance,
        this.minVolume,
        this.minPrice,
        this.count,
        this.orderList,
        this.baseCoinBalance,
        this.volumePrecision});

  SpotGoodsOrderRes.fromJson(Map<String, dynamic> json) {
    pricePrecision = json['pricePrecision'];
    symbol = json['symbol'];
    price = json['price'];
    countCoinBalance = json['countCoinBalance'];
    minVolume = json['minVolume'];
    minPrice = json['minPrice'];
    count = json['count'];
    if (json['orderList'] != null) {
      orderList = <SpotGoodsOrder>[];
      json['orderList'].forEach((v) {
        orderList!.add(new SpotGoodsOrder.fromJson(v));
      });
    }
    baseCoinBalance = json['baseCoinBalance'];
    volumePrecision = json['volumePrecision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pricePrecision'] = this.pricePrecision;
    data['symbol'] = this.symbol;
    data['price'] = this.price;
    data['countCoinBalance'] = this.countCoinBalance;
    data['minVolume'] = this.minVolume;
    data['minPrice'] = this.minPrice;
    data['count'] = this.count;
    if (this.orderList != null) {
      data['orderList'] = this.orderList!.map((v) => v.toJson()).toList();
    }
    data['baseCoinBalance'] = this.baseCoinBalance;
    data['volumePrecision'] = this.volumePrecision;
    return data;
  }
}


class SpotGoodsOrder {
  String? side;
  String? totalPrice;
  num? timeLong;
  String? createdAt;
  String? avgPrice;
  String? countCoin;
  String? source;
  num? type;
  String? volume;
  String? price;
  String? dealVolume;
  num? id;
  String? statusText;
  String? remainVolume;
  String? dealMoney;
  String? baseCoin;
  num? status;
  num? isCloseCancelOrder;

  SpotGoodsOrder(
      {this.side,
        this.totalPrice,
        this.timeLong,
        this.createdAt,
        this.avgPrice,
        this.countCoin,
        this.source,
        this.type,
        this.volume,
        this.price,
        this.dealVolume,
        this.id,
        this.statusText,
        this.remainVolume,
        this.dealMoney,
        this.baseCoin,
        this.status,
        this.isCloseCancelOrder});

  SpotGoodsOrder.fromJson(Map<String, dynamic> json) {
    side = json['side'];
    totalPrice = json['total_price'];
    timeLong = json['time_long'];
    createdAt = json['created_at'];
    avgPrice = json['avg_price'];
    countCoin = json['countCoin'];
    source = json['source'];
    type = json['type'];
    volume = json['volume'];
    price = json['price'];
    dealVolume = json['deal_volume'];
    id = json['id'];
    statusText = json['status_text'];
    remainVolume = json['remain_volume'];
    dealMoney = json['deal_money'];
    baseCoin = json['baseCoin'];
    status = json['status'];
    isCloseCancelOrder = json['isCloseCancelOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['side'] = this.side;
    data['total_price'] = this.totalPrice;
    data['time_long'] = this.timeLong;
    data['created_at'] = this.createdAt;
    data['avg_price'] = this.avgPrice;
    data['countCoin'] = this.countCoin;
    data['source'] = this.source;
    data['type'] = this.type;
    data['volume'] = this.volume;
    data['price'] = this.price;
    data['deal_volume'] = this.dealVolume;
    data['id'] = this.id;
    data['status_text'] = this.statusText;
    data['remain_volume'] = this.remainVolume;
    data['deal_money'] = this.dealMoney;
    data['baseCoin'] = this.baseCoin;
    data['status'] = this.status;
    data['isCloseCancelOrder'] = this.isCloseCancelOrder;
    return data;
  }
}

