import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/ws/core/socket_manager.dart';

class SpotGoodsSocketManager extends SocketManager {
  static SpotGoodsSocketManager get instance => _instance;

  static final SpotGoodsSocketManager _instance =
      SpotGoodsSocketManager._internal();

  factory SpotGoodsSocketManager() {
    return _instance;
  }

  SpotGoodsSocketManager._internal();

  @override
  String get socketUrl {
    return BestApi.getApi().spotWsUrl;
  }
}
