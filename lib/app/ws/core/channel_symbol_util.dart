/// 从channel中获取symbol
/// market_${symbol}_depth_step$step
/// market_${symbol}_kline_$time
/// market_${symbol}_ticker
/// market_${symbol}_trade_ticker
/// market_${symbol}_detailTrade
/// market_${symbol}_depthtrade
String getSymbol(String channel) {
  /// 先干掉market_
  var target = channel.replaceAll('market_', '');

  /// 再干掉尾部
  if (target.contains('_depth_step')) {
    // 干掉depth_steap及后面的所有
    target = target.substring(0, target.indexOf('_depth_step'));
  } else if (target.contains('_kline')) {
    // 干掉kline及后面的所有
    target = target.substring(0, target.indexOf('_kline'));
  } else if (target.contains('_trade_ticker')) {
    // 干掉trade_ticker及后面的所有
    target = target.substring(0, target.indexOf('_trade_ticker'));
  } else if (target.contains('_ticker')) {
    // 干掉ticker及后面的所有
    target = target.substring(0, target.indexOf('_ticker'));
  } else if (target.contains('_detailtrade')) {
    // 干掉detailtrade及后面的所有
    target = target.substring(0, target.indexOf('_detailtrade'));
  } else if (target.contains('_depthtrade')) {
    /// 干掉depthtrade及后面的所有
    target = target.substring(0, target.indexOf('_depthtrade'));
  }
  return target;
}
