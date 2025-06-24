class PriceInfo {
  /// 标记价格
  num tagPrice;

  /// 最新价格
  num lastPrice;
  num? buyOne;
  num? sellOne;

  PriceInfo({
    required this.tagPrice,
    required this.lastPrice,
    required this.buyOne,
    required this.sellOne,
  });

  factory PriceInfo.fromJson(Map<String, dynamic> json) => PriceInfo(
        tagPrice: json["tagPrice"]?.toDouble() ?? 0,
        lastPrice: json["lastPrice"]?.toDouble() ?? 0,
        buyOne: json["buyOne"],
        sellOne: json["sellOne"],
      );
}
