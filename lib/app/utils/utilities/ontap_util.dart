import 'dart:async';

/// 函数防抖
///
/// [func]: 要执行的方法
/// [delay]: 要迟延的时长
void Function() myDebounce(
  Function func, [
  Duration delay = const Duration(milliseconds: 500),
]) {
  Timer? timer;
  return () {
    timer?.cancel();
    timer = Timer(delay, () {
      func.call();
    });
  };
}

/// 节流
///
/// [func]: 要执行的方法
/// [delay]: 要迟延的时长
Function() throttle(
  Function func, [
  Duration delay = const Duration(milliseconds: 1000),
]) {
  bool shouldCall = true;
  return () {
    if (!shouldCall) return;

    shouldCall = false;
    func.call();
    Timer(delay, () {
      shouldCall = true;
    });
  };
}
