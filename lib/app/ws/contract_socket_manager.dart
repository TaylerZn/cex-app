import 'package:nt_app_flutter/app/ws/core/socket_manager.dart';

import '../network/best_api/best_api.dart';
import 'core/model/ws_send_data.dart';

class ContractSocketManager extends SocketManager {
  static ContractSocketManager get instance => _instance;

  static final ContractSocketManager _instance =
      ContractSocketManager._internal();

  factory ContractSocketManager() {
    return _instance;
  }

  ContractSocketManager._internal();

  @override
  String get socketUrl {
    return BestApi.getApi().contractWsUrl;
  }

}
