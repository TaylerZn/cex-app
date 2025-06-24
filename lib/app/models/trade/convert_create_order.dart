import 'dart:convert';

class ConvertCreateOrder {
  String? orderType; //订单类型 固定2市价
  String? channel; //支付渠道 固定spot现货
  String? base; //消耗币
  String? baseAmount; // 消耗币数量
  String? fee; //手续费
  String? rate; //交换率
  int? ctime; // 下单时间戳的字符串 -> int
  String? quote; //获得币
  String? quoteAmount; //获得币的数量
  String? side; //BUY/SELL 买卖方向 //TODO: 后台的没有加

  ConvertCreateOrder({
    this.orderType,
    this.channel,
    this.base,
    this.baseAmount,
    this.fee,
    this.rate,
    this.ctime,
    this.quote,
    this.quoteAmount,
    this.side,
  });

  factory ConvertCreateOrder.fromRawJson(String str) =>
      ConvertCreateOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConvertCreateOrder.fromJson(Map<String, dynamic> json) =>
      ConvertCreateOrder(
        orderType: json["orderType"],
        channel: json["channel"],
        base: json["base"],
        baseAmount: json["baseAmount"],
        fee: json["fee"],
        rate: json["rate"],
        ctime: json["ctime"],
        quote: json["quote"],
        quoteAmount: json["quoteAmount"],
        side: json["side"],
      );

  Map<String, dynamic> toJson() => {
        "orderType": orderType,
        "channel": channel,
        "base": base,
        "baseAmount": baseAmount,
        "fee": fee,
        "rate": rate,
        "ctime": ctime,
        "quote": quote,
        "quoteAmount": quoteAmount,
        "side": side,
      };

  // 后台设计,忽略消耗获得,后台判断一次,端上又判断一次 并没有按接口评审约定返回
  String get leftCoin {
    if (side == 'BUY') {
      return quote ?? '--';
    } else if (side == 'SELL') {
      return base ?? '--';
    } else {
      return 'server error';
    }
  }

  String get rightCoin {
    if (side == 'BUY') {
      return base ?? '--';
    } else if (side == 'SELL') {
      return quote ?? '--';
    } else {
      return 'server error';
    }
  }

  String get leftVolume {
    if (side == 'BUY') {
      return quoteAmount ?? '--';
    } else if (side == 'SELL') {
      return baseAmount ?? '--';
    } else {
      return 'server error';
    }
  }

  String get rightVolume {
    if (side == 'BUY') {
      return baseAmount ?? '--';
    } else if (side == 'SELL') {
      return quoteAmount ?? '--';
    } else {
      return 'server error';
    }
  }

  String get coverRate {
    if (side == 'BUY') {
      return "1 $quote = $rate $base";
    } else if (side == 'SELL') {
      return "1 $base = $rate $quote"; //TODO: 需要跟后台确定取值
    } else {
      return 'server error';
    }
  }
}
