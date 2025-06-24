class CreateConditionOrderReq {
  String contractId;
  String leverageLevel;
  String positionType;
  String side;
  OrderList orderListStr;

  CreateConditionOrderReq({
    required this.contractId,
    required this.leverageLevel,
    required this.positionType,
    required this.side,
    required this.orderListStr,
  });

  factory CreateConditionOrderReq.fromJson(Map<String, dynamic> json) =>
      CreateConditionOrderReq(
        contractId: json["contractId"],
        leverageLevel: json["leverageLevel"],
        positionType: json["positionType"],
        side: json["side"],
        orderListStr: OrderList.fromJson(json["orderListStr"]),
      );

  Map<String, dynamic> toJson() => {
        "contractId": contractId,
        "leverageLevel": leverageLevel,
        "positionType": positionType,
        "side": side,
        "orderListStr": orderListStr.toJson(),
      };
}

class OrderList {
  String tiggerType;
  String price;
  String volume;
  String triggerPrice;
  num type;
  num expiredTime;

  OrderList({
    required this.tiggerType,
    required this.price,
    required this.volume,
    required this.triggerPrice,
    required this.type,
    required this.expiredTime,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        tiggerType: json["tiggerType"],
        price: json["price"],
        volume: json["volume"],
        triggerPrice: json["triggerPrice"],
        type: json["type"],
        expiredTime: json["expiredTime"],
      );

  Map<String, dynamic> toJson() => {
        "tiggerType": tiggerType,
        "price": price,
        "volume": volume,
        "triggerPrice": triggerPrice,
        "type": type,
        "expiredTime": expiredTime,
      };
}
