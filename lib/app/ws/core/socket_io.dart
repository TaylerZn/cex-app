import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

typedef SocketHandler = void Function(Map<String, dynamic> data);

class SocketIO {
  final String wsUrl;

  SocketIO(this.wsUrl);

  WebSocketChannel? _socket;
  Timer? _heartTimer;
  Timer? _reconnectTimer;
   SocketHandler? _handler;
  bool _isConnect = false;

  bool get isConnect => _isConnect;

  /// 断开重连回调
  VoidCallback? reConnectCallback;

  /// @param isReConnect 是否自动连接
  Future<void> connect({bool isReConnect = false}) async {
    try {
      _stopReconnect();
      SecurityContext securityContext = SecurityContext.defaultContext;
      securityContext.setAlpnProtocols(['http/1.1'], true);
      _socket = IOWebSocketChannel.connect(
        Uri.parse(wsUrl),
        pingInterval: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 60),
        customClient: HttpClient(context: securityContext),
      );
      await _socket?.ready;
      _isConnect = true;
      _sendPong();
      _listen();
      if (isReConnect) {
        reConnectCallback?.call();
      }
    } catch (e) {
      _isConnect = false;
      _reconnect();
    }
  }

  void receive(SocketHandler handler) {
    _handler = handler;
  }

  /// 发送数据
  void send(Map data) {
    try {
      _socket?.sink.add(json.encode(data));
    } catch (e) {
      _reconnect();
    }
  }

  void close() {
    _heartTimer?.cancel();
    _stopReconnect();
    _socket?.sink.close();
  }
}

extension SocketIOExt on SocketIO {
  void _listen() {
    try {
      if (_socket == null || !_isConnect) return;
      _socket!.stream.asBroadcastStream().listen((event) {
        _stopReconnect();
        _heartBeat();

        Map<String, dynamic> ret = {};
        if (event is List<int>) {
          ret = _handleData(event);
        } else {
          try {
            ret = json.decode(event);
          } catch (error) {}
        }
        if (ret['ping'] != null) {
          _sendPong();
          return;
        }
        _handler?.call(ret);
      }, onDone: () {
        _isConnect = false;
        _reconnect();
      }, onError: (e) {
        _isConnect = false;
        _reconnect();
      });
    } catch (e) {}
  }

  _reconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      connect(isReConnect: true);
    });
  }

  _stopReconnect() {
    _reconnectTimer?.cancel();
  }

  /// 定时发送心跳 10s
  void _heartBeat() {
    _heartTimer?.cancel();
    _heartTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _sendPong();
    });
  }

  _sendPong() {
    int currentTime = DateUtil.getNowDateMs() ~/ 1000;
    send({"pong": currentTime});
  }

  Map<String, dynamic> _handleData(List<int> data) {
    Uint8List uint8List = Uint8List.fromList(data);
    ZLibDecoder decoder = ZLibDecoder();
    List<int> result = decoder.convert(uint8List);
    String dataString = utf8.decode(result);
    Map<String, dynamic> map = jsonDecode(dataString);
    return map;
  }
}
