
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';

typedef BusCallBack = void Function(dynamic data);

class Bus {
  static final Bus _singleton = Bus._();

  Bus._();

  static Bus getInstance() {
    return _singleton;
  }

  final Map<String,List<BusCallBack>> _events = {};

  /// 订阅事件
  void on(EventType event, BusCallBack callback) {
    if (_events[event.name] == null) {
      _events[event.name] = [];
    }
    _events[event.name]!.add(callback);
  }

  /// 取消订阅
  void off(EventType event, BusCallBack callback) {
    if (_events[event.name] != null) {
      _events[event.name]!.remove(callback);
    }
  }

  /// 发送事件
  void emit(EventType event, [dynamic data]) {
    if (_events[event.name] != null) {
      for (var element in _events[event.name]!) {
        element(data);
      }
    }
  }
}