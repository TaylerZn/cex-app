import 'dart:async';
import 'dart:collection';

import 'package:nt_app_flutter/app/ws/core/socket_io.dart';

import 'channel_symbol_util.dart';
import 'model/ws_receive_data.dart';
import 'model/ws_send_data.dart';

typedef SocketReceiveDataHandler = void Function(
    String symbol, WSReceiveData data);

class SocketManager {
  SocketIO? _socketIO;

  String get socketUrl {
    return '';
  }

  /// 当前订阅的channel和回调
  final LinkedHashMap<String, List<SocketReceiveDataHandler>> _linkedHashMap =
      LinkedHashMap();

  /// 当前的订阅赛事和回调，用于重连时再次订阅
  final LinkedHashMap<WsSendData, SocketReceiveDataHandler?>
      _currentSubDataMap = LinkedHashMap();

  connect() async {
    if (_socketIO?.isConnect ?? false) {
      _socketIO?.close();
    }

    _socketIO = SocketIO(socketUrl);

    /// 断开重连回调
    _socketIO?.reConnectCallback = () {
      _currentSubDataMap.forEach((key, value) {
        subscribe(key, value);
      });
    };

    await _socketIO?.connect();

    /// 用于前后台切换重连，重新订阅
    _currentSubDataMap.forEach((key, value) {
      subscribe(key, value);
    });
    _socketIO!.receive((data) {
      try {
        _checkWsIfOk();
        WSReceiveData receiveData = WSReceiveData.fromJson(data);
        final String? messageChannel = receiveData.channel;

        if (messageChannel != null) {
          String symbol = getSymbol(messageChannel);

          _linkedHashMap.forEach((key, value) {
            if (key == receiveData.channel) {
              for (var func in value) {
                func(symbol, receiveData);
              }
            }
          });
        }
      } on Exception catch (e) {
        print(e);
      }
    });
  }

  /// 检查是否收到数据，否则5s后重新连接：处理ws未断开但是不推数据
  Timer? _checkTimer;
  _checkWsIfOk() {
    _checkTimer?.cancel();
    _checkTimer = null;

    /// ws未断开的情况，主动连接，如果ws断开的情况，会自动重连
    if (_socketIO?.isConnect ?? true) {
      _checkTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
        _socketIO?.connect(isReConnect: true);
      });
    }
  }

  close() {
    _socketIO?.close();
    _checkTimer?.cancel();
    _checkTimer = null;
  }

  Future<void> subscribe(WsSendData sendData,
      [SocketReceiveDataHandler? callback]) async {
    if (_socketIO == null) return;

    /// 订阅回调
    switch (sendData.event) {
      case SubEvent.req:
        _currentSubDataMap[sendData] = callback;
        if (callback != null) {
          if (_linkedHashMap.containsKey(sendData.channel)) {
            _linkedHashMap[sendData.channel]?.add(callback);
          } else {
            _linkedHashMap[sendData.channel] = [callback];
          }
        }
        break;
      case SubEvent.unSub:
        _currentSubDataMap
            .removeWhere((key, value) => key.channel == sendData.channel);
        _linkedHashMap.remove(sendData.channel);
        break;
      case SubEvent.sub:
        _currentSubDataMap[sendData] = callback;
        if (_linkedHashMap.containsKey(sendData.channel)) {
          List<SocketReceiveDataHandler> funcs =
              _linkedHashMap[sendData.channel] ?? [];
          if (callback != null) {
            funcs.add(callback);
            _linkedHashMap[sendData.channel] = funcs;
          }
        } else {
          if (callback != null) {
            _linkedHashMap[sendData.channel] = [callback];
          }
        }
        break;
      case SubEvent.subBatch:
        _currentSubDataMap[sendData] = callback;
        List<String> channels = sendData.channel.split(',');
        for (var item in channels) {
          if (callback != null) {
            if (!_linkedHashMap.containsKey(item)) {
              _linkedHashMap[item] = [callback];
            } else {
              _linkedHashMap[item]?.add(callback);
            }
          }
        }
        break;
      case SubEvent.unSubBatch:
        _currentSubDataMap
            .removeWhere((key, value) => key.channel == sendData.channel);
        List<String> channels = sendData.channel.split(',');
        for (var item in channels) {
          _linkedHashMap.remove(item);
        }
        break;
      default:
        _currentSubDataMap[sendData] = callback;
        if (callback != null) {
          _linkedHashMap[sendData.channel] = [callback];
        }
    }

    if (!_socketIO!.isConnect) {
      await _socketIO!.connect();
    }

    _socketIO!.send(sendData.toJson());
  }

  void subReview(SocketReceiveDataHandler callback) {
    subscribe(
      WsSendData.req(channel: 'review', cid: '0'),
      callback,
    );
  }

  void subDepth(String symbol, int step, SocketReceiveDataHandler callback) {
    if (symbol.isEmpty) return;
    subscribe(
      WsSendData.sub(
          channel: 'market_${symbol}_depth_step$step',
          asks: 150,
          bids: 150,
          cbId: symbol),
      callback,
    );
  }

  void unSubDepth(String symbol, int step) {
    if (symbol.isEmpty) return;
    subscribe(
      WsSendData.unsub(channel: 'market_${symbol}_depth_step$step'),
    );
  }

  void subKline(String symbol, String time, SocketReceiveDataHandler callback) {
    if (symbol.isEmpty) return;
    subscribe(
        WsSendData.sub(channel: 'market_${symbol}_kline_$time', cbId: symbol),
        callback);
  }

  void unSubKline(
    String symbol,
    String time,
  ) {
    if (symbol.isEmpty) return;
    subscribe(WsSendData.unsub(
        channel: 'market_${symbol}_kline_$time', cbId: symbol));
  }

  void reqKline(String symbol, String time, SocketReceiveDataHandler callback,
      {int? endIdx, int? pageSize}) {
    if (symbol.isEmpty) return;
    subscribe(
        WsSendData.req(
          channel: 'market_${symbol}_kline_$time',
          cbId: symbol,
          endIdx: endIdx,
          pageSize: pageSize,
        ),
        callback);
  }

  void subTicker(String symbol, SocketReceiveDataHandler callback) {
    if (symbol.isEmpty) return;
    subscribe(WsSendData.sub(channel: 'market_${symbol}_ticker', cbId: symbol),
        callback);
  }

  void unSubTicker(String symbol) {
    if (symbol.isEmpty) return;
    subscribe(
      WsSendData.unsub(channel: 'market_${symbol}_ticker'),
    );
  }

  /// 请求历史成交
  void reqTradeTicker(String symbol, SocketReceiveDataHandler callback) {
    if (symbol.isEmpty) return;
    subscribe(
        WsSendData.req(
          channel: 'market_${symbol}_trade_ticker',
          cbId: symbol,
          pageSize: 20,
        ),
        callback);
  }

  /// 订阅实时成交
  void subTradeTicker(String symbol, SocketReceiveDataHandler callback) {
    if (symbol.isEmpty) return;
    subscribe(
        WsSendData.sub(
            channel: 'market_${symbol}_trade_ticker', cbId: symbol, top: '20'),
        callback);
  }

  /// 取消订阅实时成交
  void unSubTradeTicker(String symbol) {
    if (symbol.isEmpty) return;
    subscribe(WsSendData.unsub(channel: 'market_${symbol}_trade_ticker'));
  }

  /// 批量订阅
  void subBatchTicker(List<String> symbols, SocketReceiveDataHandler callback) {
    String channel =
        symbols.map((e) => 'market_${e}_ticker').toList().join(',');
    subscribe(WsSendData.subBatch(channel: channel, cbId: '1'), callback);
  }

  /// 批量取消订阅
  void unSubBatchTicker(List<String> symbols) {
    if (symbols.isEmpty) return;
    String channel =
        symbols.map((e) => 'market_${e}_ticker').toList().join(',');
    subscribe(WsSendData.unsubBatch(channel: channel, cbId: '1'));
  }

  /// 日期涨跌数据历史
  void reqTradeDetail(String symbol, SocketReceiveDataHandler callback) {
    if (symbol.isEmpty) return;
    subscribe(
        WsSendData.req(channel: 'market_${symbol}_detailtrade', cbId: symbol),
        callback);
  }

  /// 日期涨跌数据
  void subTradeDetail(String symbol, SocketReceiveDataHandler callback) {
    if (symbol.isEmpty) return;
    subscribe(
        WsSendData.sub(channel: 'market_${symbol}_detailtrade', cbId: symbol),
        callback);
  }

  /// 取消日期涨跌数据
  void unSubTradeDetail(String symbol) {
    if (symbol.isEmpty) return;
    subscribe(WsSendData.unsub(channel: 'market_${symbol}_detailtrade'));
  }

  /// 深度的历史数据
  void reqDepthHistory(String symbol, SocketReceiveDataHandler callback) {
    if (symbol.isEmpty) return;
    subscribe(
        WsSendData.req(channel: 'market_${symbol}_depthtrade', cbId: symbol),
        callback);
  }

  /// 实时深度
  void subDepthTrade(String symbol, SocketReceiveDataHandler callback) {
    if (symbol.isEmpty) return;
    subscribe(
        WsSendData.sub(channel: 'market_${symbol}_depthtrade', cbId: symbol),
        callback);
  }

  /// 取消深度订阅
  void unSubDepthTrade(String symbol) {
    if (symbol.isEmpty) return;
    subscribe(WsSendData.unsub(channel: 'market_${symbol}_depthtrade'));
  }
}
