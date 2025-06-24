class SymbolRateListRes {
  double usdtToUsdRate;
  List<SymbolRateInfo> symbolRateList;

  SymbolRateListRes({
    required this.usdtToUsdRate,
    required this.symbolRateList,
  });

  factory SymbolRateListRes.fromJson(Map<String, dynamic> json) => SymbolRateListRes(
    usdtToUsdRate: json["usdtToUsdRate"]?.toDouble(),
    symbolRateList: List<SymbolRateInfo>.from(json["symbolRateList"].map((x) => SymbolRateInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "usdtToUsdRate": usdtToUsdRate,
    "symbolRateList": List<dynamic>.from(symbolRateList.map((x) => x.toJson())),
  };
}

class SymbolRateInfo {
  int? id;
  String baseSymbol;
  String quoteSymbol;
  double rate;
  String updateTime;

  SymbolRateInfo({
    required this.id,
    required this.baseSymbol,
    required this.quoteSymbol,
    required this.rate,
    required this.updateTime,
  });

  factory SymbolRateInfo.fromJson(Map<String, dynamic> json) => SymbolRateInfo(
    id: json["id"],
    baseSymbol: json["baseSymbol"],
    quoteSymbol: json["quoteSymbol"],
    rate: json["rate"]?.toDouble(),
    updateTime: json["updateTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "baseSymbol": baseSymbol,
    "quoteSymbol": quoteSymbol,
    "rate": rate,
    "updateTime": updateTime,
  };
}

