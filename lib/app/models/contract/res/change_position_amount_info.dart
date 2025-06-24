class ChangePositionAmountInfo {
  /// 最大可划转
  String? canAdd;

  /// 最大可减少量（不能等于这个值）
  String? canReduce;

  /// 修改保证金后的强平价格
  String? reducePrice;

  /// 当前持仓保证金
  String? holdAmount;

  ChangePositionAmountInfo({
    this.canAdd,
    this.canReduce,
    this.reducePrice,
    this.holdAmount,
  });

  factory ChangePositionAmountInfo.fromJson(Map<String, dynamic> json) =>
      ChangePositionAmountInfo(
        canAdd: json["canAdd"].toString(),
        canReduce: json["canReduce"].toString(),
        reducePrice: json["reducePrice"].toString(),
        holdAmount: json["holdAmount"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "canAdd": canAdd,
        "canReduce": canReduce,
        "reducePrice": reducePrice,
        "holdAmount": holdAmount,
      };
}
