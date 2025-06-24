import 'dart:async';
import 'dart:collection';

import 'package:common_utils/common_utils.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/ws/core/socket_io.dart';
import 'package:nt_app_flutter/app/ws/core/socket_manager.dart';

import 'channel_symbol_util.dart';
import 'model/ws_receive_data.dart';
import 'model/ws_request.dart';
import 'model/ws_send_data.dart';

class RequestSocketManager {
  SocketIO? _socketIO;
  int timerDuration = 1; //轮训发送命令
  Map<String, dynamic> reqCache = {};

  String get socketUrl {
    return '';
  }

  /// 当前订阅的channel和回调
  final LinkedHashMap<String, List<SocketReceiveDataHandler>> _linkedHashMap =
      LinkedHashMap();

  /// 当前的订阅赛事和回调，用于重连时再次订阅
  final LinkedHashMap<WsRequest, SocketReceiveDataHandler?> _currentSubDataMap =
      LinkedHashMap();

  Timer? timer; //轮训发送命令定时器

  close(){
      _socketIO?.close();
      timer?.cancel();
      timer = null;
  }

  connect() async {
    if (_socketIO?.isConnect ?? false) {
      _socketIO?.close();
    }

    _socketIO = SocketIO(socketUrl);

    timer = Timer.periodic(Duration(seconds: timerDuration), (timer) {
      reqCache.values.forEach((element) {
        if (_socketIO!.isConnect && ObjectUtil.isNotEmpty(element)) {
          _sendData(element);
        }
      });
    });

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

        if (receiveData.data != null) {
          _linkedHashMap.forEach((key, value) {
            if (key == receiveData.event) {
              for (var func in value) {
                func(receiveData.event!, receiveData);
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
      _checkTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        _socketIO?.connect(isReConnect: true);
      });
    }
  }



  Future<void> subscribe(WsRequest sendData,
      [SocketReceiveDataHandler? callback]) async {
    if (_socketIO == null) return;
    reqCache[sendData.channel] = sendData;

    /// 订阅回调
    switch (sendData.action) {
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

      default:
        _currentSubDataMap[sendData] = callback;
        if (callback != null) {
          _linkedHashMap[sendData.channel] = [callback];
        }
    }

    if (!_socketIO!.isConnect) {
      await _socketIO!.connect();
    }

    _sendData(sendData);
  }

  void _sendData(WsRequest sendData) {
    sendData.token = UserGetx.to.isLogin ? UserGetx.to.user?.token : '';
    sendData.lang = 'zh_cn';
    _socketIO!.send(sendData.toJson());
  }
}
