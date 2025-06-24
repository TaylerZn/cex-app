import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_contract.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/position_res.dart';
import 'package:nt_app_flutter/app/ws/core/model/ws_receive_data.dart';
import 'package:nt_app_flutter/app/ws/core/socket_manager.dart';

import '../models/contract/res/funding_rate.dart';
import '../network/best_api/best_api.dart';
import 'core/model/ws_request.dart';
import 'core/model/ws_send_data.dart';
import 'core/request_socket_manager.dart';

class FuturetSocketManager extends RequestSocketManager {
  static FuturetSocketManager get instance => _instance;

  static final FuturetSocketManager _instance =
      FuturetSocketManager._internal();

  factory FuturetSocketManager() {
    return _instance;
  }

  FuturetSocketManager._internal();

  @override
  String get socketUrl {
    return BestApi.getApi().futureWsUrl;
  }

  void subAssetList({String? account = '0',Function(PositionRes)? callback}) {
    String channel = 'futures_get_assets_list';
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
          AssetsGetx.to.handleAssetContract(temp);

    });
  }

  void subMarketInfo(String symbol, num contractId,
      {Function(FundingRate)? callback}) {
    String channel = 'futures_public_market_info';
    subscribe(
        WsRequest(
            action: SubEvent.req,
            params: {"symbol": symbol, 'contractId': contractId},
            event: channel,
            channel: channel,
            token: UserGetx.to.user?.token,
            ), (channel, WSReceiveData data) {
      callback?.call(FundingRate.fromJson(data.data));
    });
  }

  void subAllOrder(num? contractId, {String status = '[0,1,3,5]',Function(OrderRes order)? callback}) {
    String channel = 'futures_find_all_order';
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
            ),
        (channel, WSReceiveData data) {
          callback?.call(OrderRes.fromJson(data.data));
        });
  }


  void subPriceList({Function(dynamic)? callback}) {
    String channel = 'futures_price_list';
    subscribe(WsRequest(event: channel, channel: channel),
            (channel, WSReceiveData data) {
          callback?.call(data.data);
        });
  }
}
