class StrategyNameEnum {
  static const Day = 1;
  static const Month = 2;
  static const Vip = 3;
  static const Free = 4;

  static String getName(code) {
    switch (code) {
      case Day:
        return '按天策略';
      case Month:
        return '按月策略';
      case Vip:
        return 'VIP策略';
      case Free:
        return '免息策略';
      default:
        return '';
    }
  }
}
