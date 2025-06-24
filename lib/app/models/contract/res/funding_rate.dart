
class FundingRate {
  final num? currentFundRate;
  final num? indexPrice;
  final num? tagPrice;
  final num? nextFundRate;

  FundingRate({
    required this.currentFundRate,
    required this.indexPrice,
    required this.tagPrice,
    required this.nextFundRate,
  });

  factory FundingRate.fromJson(Map<String, dynamic> json) {
    return FundingRate(
      currentFundRate: json['currentFundRate'],
      indexPrice: json['indexPrice'],
      tagPrice: json['tagPrice'],
      nextFundRate: json['nextFundRate'],
    );
  }
}