class ContractLeverage {
  List<LeverList>? leverList;

  ContractLeverage({
    this.leverList,
  });

  factory ContractLeverage.fromJson(Map<String, dynamic> json) => ContractLeverage(
    leverList: json["leverList"] == null ? [] : List<LeverList>.from(json["leverList"]!.map((x) => LeverList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "leverList": leverList == null ? [] : List<dynamic>.from(leverList!.map((x) => x.toJson())),
  };
}

class LeverList {
  int? level;
  int? minPositionValue;
  int? maxPositionValue;
  double? minMarginRate;
  int? minLever;
  int? maxLever;
  int? maxHoldAmount;

  LeverList({
    this.level,
    this.minPositionValue,
    this.maxPositionValue,
    this.minMarginRate,
    this.minLever,
    this.maxLever,
    this.maxHoldAmount,
  });

  factory LeverList.fromJson(Map<String, dynamic> json) => LeverList(
    level: json["level"],
    minPositionValue: json["minPositionValue"],
    maxPositionValue: json["maxPositionValue"],
    minMarginRate: json["minMarginRate"]?.toDouble(),
    minLever: json["minLever"],
    maxLever: json["maxLever"],
    maxHoldAmount: json["maxHoldAmount"],
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "minPositionValue": minPositionValue,
    "maxPositionValue": maxPositionValue,
    "minMarginRate": minMarginRate,
    "minLever": minLever,
    "maxLever": maxLever,
    "maxHoldAmount": maxHoldAmount,
  };
}