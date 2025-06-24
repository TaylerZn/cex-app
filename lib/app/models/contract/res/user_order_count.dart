// {
//     "orderCount": "",
//     "triggerOrderCount": ""
//   }
class UserOrderCount {
  int orderCount;
  int triggerOrderCount;

  UserOrderCount({
    required this.orderCount,
    required this.triggerOrderCount,
  });

  factory UserOrderCount.fromJson(Map<String, dynamic> json) => UserOrderCount(
        orderCount: json["orderCount"] ?? 0,
        triggerOrderCount:
            json["triggerOrderCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "orderCount": orderCount,
        "triggerOrderCount":
            triggerOrderCount,
      };
}
