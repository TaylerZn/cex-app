import 'dart:convert';

class AssetsConvertRecord {
  List<AssetsConvertRecordItem>? financeList; // orderList
  int? conunt; // total
  int? pageSize;

  AssetsConvertRecord({
    this.financeList,
    this.conunt,
    this.pageSize,
  });

  factory AssetsConvertRecord.fromRawJson(String str) => AssetsConvertRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetsConvertRecord.fromJson(Map<String, dynamic> json) => AssetsConvertRecord(
        financeList: json["orderList"] == null
            ? []
            : List<AssetsConvertRecordItem>.from(json["orderList"]!.map((x) => AssetsConvertRecordItem.fromJson(x))),
        conunt: json["total"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "orderList": financeList == null ? [] : List<dynamic>.from(financeList!.map((x) => x.toJson())),
        "total": conunt,
        "pageSize": pageSize,
      };
}

class AssetsConvertRecordItem {
  String? orderId;
  String? base;
  String? baseVolume;
  String? quote;
  String? quoteVolume;
  String? dealRate;
  String? reverseRate;
  String? rate;
  String? status;
  int? ctime;
  int? settleTime;
  String? side; //BUY/SELL

  AssetsConvertRecordItem({
    this.orderId,
    this.base,
    this.baseVolume,
    this.quote,
    this.quoteVolume,
    this.dealRate,
    this.reverseRate,
    this.rate,
    this.status,
    this.ctime,
    this.settleTime,
    this.side,
  });

  factory AssetsConvertRecordItem.fromRawJson(String str) => AssetsConvertRecordItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetsConvertRecordItem.fromJson(Map<String, dynamic> json) => AssetsConvertRecordItem(
        orderId: json["orderId"],
        base: json["base"],
        baseVolume: json["baseVolume"],
        quote: json["quote"],
        quoteVolume: json["quoteVolume"],
        dealRate: json["dealRate"],
        reverseRate: json["reverseRate"],
        rate: json["rate"],
        status: json["status"],
        ctime: json["ctime"],
        settleTime: json["settleTime"],
        side: json["side"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "base": base,
        "baseVolume": baseVolume,
        "quote": quote,
        "quoteVolume": quoteVolume,
        "dealRate": dealRate,
        "reverseRate": reverseRate,
        "rate": rate,
        "status": status,
        "ctime": ctime,
        "settleTime": settleTime,
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
      return quoteVolume ?? '--';
    } else if (side == 'SELL') {
      return baseVolume ?? '--';
    } else {
      return 'server error';
    }
  }

  String get rightVolume {
    if (side == 'BUY') {
      return baseVolume ?? '--';
    } else if (side == 'SELL') {
      return quoteVolume ?? '--';
    } else {
      return 'server error';
    }
  }

  String get coverRate {
    if (side == 'BUY') {
      return "1 $quote ≈ $dealRate $base";
    } else if (side == 'SELL') {
      return "1 $base ≈ $reverseRate $quote";
    } else {
      return 'server error';
    }
  }
}
