import 'package:get/get_core/src/get_main.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_contract.dart';
import 'package:nt_app_flutter/app/models/contract/res/funding_rate.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/ws/core/socket_manager.dart';

import '../models/contract/res/position_res.dart';
import '../models/contract/res/price_info.dart';
import '../network/best_api/best_api.dart';
import 'core/model/ws_receive_data.dart';
import 'core/model/ws_request.dart';
import 'core/model/ws_send_data.dart';
import 'core/request_socket_manager.dart';

class StandardFutureSocketManager extends RequestSocketManager {
  //标准合约ws

  Function(dynamic)? assetListCallback;
  static StandardFutureSocketManager get instance => _instance;

  static final StandardFutureSocketManager _instance =
      StandardFutureSocketManager._internal();

  factory StandardFutureSocketManager() {
    return _instance;
  }

  StandardFutureSocketManager._internal();

  @override
  String get socketUrl {
    return BestApi.getApi().standardReqWsUrl;
  }

  void subAssetList({String? account = '0',Function(PositionRes)? callback}) {
    String channel = 'standard_get_assets_list';
    subscribe(
        WsRequest(
          action: SubEvent.req,
          params: {"onlyAccount": account},
          event: channel,
          channel: channel,
          token: UserGetx.to.user?.token,
        ), (channel, WSReceiveData data) {
      AssetsContract temp =  AssetsContract.fromJson(data.data);
      callback?.call(PositionRes.fromJson(temp.toJson()));
      AssetsGetx.to.handleAssetStandardContract(temp);
    });
  }

  void subMarketInfo(String symbol, num contractId,
      {Function(FundingRate)? callback}) {
    String channel = 'standard_public_market_info';
    subscribe(
        WsRequest(
            action: SubEvent.req,
            params: {"symbol": symbol, 'contractId': contractId},
            event: channel,
            channel: channel,
            token: UserGetx.to.user?.token), (channel, WSReceiveData data) {
      callback?.call(FundingRate.fromJson(data.data));
    });
  }

  void subPriceList({Function(dynamic)? callback}) {
    String channel = 'standard_price_list';
    subscribe(WsRequest(event: channel, channel: channel),
        (channel, WSReceiveData data) {
        callback?.call(data.data);
    });
  }

  void subAllOrder(num? contractId,
      {String status = '[0,1,3,5]', Function(OrderRes order)? callback}) {
    String channel = 'standard_find_all_order';
    subscribe(
        WsRequest(
            action: SubEvent.req,
            params: {
              "pageNum": 1,
              'pageSize': 100,
              'contractId': contractId,
              'status': status
            },
            event: channel,
            channel: channel,
            token: UserGetx.to.user?.token,
            lang: 'zn_ch'), (channel, WSReceiveData data) {
      callback?.call(OrderRes.fromJson(data.data));
    });
  }
}
