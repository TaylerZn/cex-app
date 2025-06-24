//b2c历史订单Enum
enum B2cOrderHistoryListTypeEnumn {
  prePayment, //待付款
  alreadyPaid, //已付款
  waitingForPayment, //等待打款
  finish, //完成
  fail, //失败
  unknown; //未知

  int get value => [0, 4, 0, 1, 2, 99][index];
}

B2cOrderHistoryListTypeEnumn getEnumFromValue(int value) {
  for (var type in B2cOrderHistoryListTypeEnumn.values) {
    if (type.value == value) {
      return type;
    }
  }
  return B2cOrderHistoryListTypeEnumn.unknown;
}
