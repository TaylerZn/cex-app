
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/ws/core/socket_manager.dart';

class StandardSocketManager extends SocketManager{
  static StandardSocketManager get instance => _instance;

  static final StandardSocketManager _instance =
  StandardSocketManager._internal();

  factory StandardSocketManager() {
    return _instance;
  }

  StandardSocketManager._internal();

  @override
  String get socketUrl {
    return BestApi.getApi().standardWsUrl;
  }
}
