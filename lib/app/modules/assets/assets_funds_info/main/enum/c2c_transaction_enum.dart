enum C2cTransactionEnum {
  /// 全部
  all,

  /// 快捷交易
  quickBuy,

  /// c2c
  c2c,

  /// 划转
  transfer;

  String get value => [
        '0',
        '2',
        '3',
        '1',
      ][index];
}
// 1划转 2 快捷买币 3 c2c交易
