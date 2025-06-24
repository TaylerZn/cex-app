// To parse this JSON data, do
//
//     final createOrderReq = createOrderReqFromJson(jsonString);

class CreateOrderReq {
  /// 合约id
  num contractId;

  // 持仓类型 1:全仓 2:逐仓
  int positionType;

  // 买卖方向 BUY:买 SELL:卖
  String side;

  // 杠杆倍数
  int leverageLevel;

  // 价格
  String price;

  // 下单量
  int volume;

  /// 开平方向 OPEN:开 CLOSE:平
  String open;

  // 订单类型 1:限价 2:市价 3:限价止盈止损 4:市价止盈止损
  int type;

  // 是否是条件单
  bool isConditionOrder;

  // 过期时间
  String? expireTime;

  // 是否是OTO单
  bool? isOto;

  // 是否检查爆仓
  int? isCheckLiq;

  // 触发价
  String? triggerPrice;

  String? attachAlgoOrds;

  CreateOrderReq({
    required this.contractId,
    required this.positionType,
    required this.side,
    required this.leverageLevel,
    required this.price,
    required this.volume,
    required this.open,
    required this.type,
    required this.isConditionOrder,
    this.expireTime,
    this.isOto,
    this.isCheckLiq,
    this.triggerPrice,
    this.attachAlgoOrds,
  });

  Map<String, dynamic> toJson() => {
        "contractId": contractId,
        "positionType": positionType,
        "side": side,
        "leverageLevel": leverageLevel,
        "price": price,
        "volume": volume,
        "open": open,
        "type": type,
        "isConditionOrder": isConditionOrder,
        "expireTime": expireTime,
        "isOto": isOto,
        "isCheckLiq": isCheckLiq,
        "triggerPrice": triggerPrice,
        "attachAlgoOrds": attachAlgoOrds,
      }..removeWhere((key, value) => value == null);
}

class AttachAlgoOrdsReq {
  /// 止盈止损订单类型（1止损 2止盈）
  final num triggerType;

  /// 止盈止损触发价格
  final num triggerPrice;

  /// 止盈止损触发类型（1最新价 2标记价 3指数价）
  final String triggerPxType;

  const AttachAlgoOrdsReq({
    required this.triggerType,
    required this.triggerPrice,
    required this.triggerPxType,
  });

  Map<String, dynamic> toJson() => {
        "triggerType": triggerType,
        "triggerPrice": triggerPrice,
        "triggerPxType": triggerPxType,
      };
}
