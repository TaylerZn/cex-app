import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/spot_goods/spot_goods_res.dart';
import 'package:nt_app_flutter/app/models/spot_goods/spot_public_info.dart';
import 'package:nt_app_flutter/app/models/spot_goods/spot_trade_res.dart';
import 'package:nt_app_flutter/app/network/retry_interceptor.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/spot_goods/spot_order_res.dart';
import '../../network/bika/bika_app_dio.dart';

part 'spot_goods_api.g.dart';

@RestApi()
abstract class SpotGoodsApi {
  factory SpotGoodsApi(Dio dio, {String baseUrl}) = _SpotGoodsApi;

  factory SpotGoodsApi.instance() => SpotGoodsApi(BikaAppDio.getInstance().dio);

  /// @description: 现货交易下单
  @POST('/order/create')
  Future<List<String>> orderCreate(
    @Field('volume') String volume, // 交易数量
    @Field('price') String price, // 交易价格 0 表示市价 其他表示限价
    @Field('type') int type, // 1限价 2是市价
    @Field('symbol') String symbol, // 交易对
    @Field('side') String side, // BUY 买入 SELL 卖出
  );

  /// @description: 当前委托
  @POST('/order/list/new')
  Future<SpotOrderRes> orderListNew(
    @Field('type') int? type,
    @Field('side') String? side,
    @Field('page') int page, // 页码
    @Field('pageSize') int pageSize, // 每页数量
    @Field('symbol') String? symbol,
  );

  /// @description: 订单撤销
  @POST('/order/cancel')
  Future orderCancel(
    @Field('orderId') String orderId, // 订单id
    @Field('symbol') String symbol, // 交易对
  );

  /// @description: 全部撤销
  @POST('/order/cancel/all')
  Future cancelAllOrder();

  /// 历史委托
  /// 状态：
  // 0-初始订单
  // 1-新订单
  // 2-完全成交
  // 3-部分成交
  // 4-已撤单
  // 5-待撤单
  // 6-异常订单
  // 7-部分成交已撤销
  @POST('/order/entrust_history/new')
  Future<SpotOrderRes> entrustHistory(
    @Field('page') int page, // 页码
    @Field('pageSize') int pageSize, // 每页数量
    @Field('isShowCanceled') int? isShowCanceled, // 是否展示取消订单 1 或者不传 展示 0: 不展示
    @Field('type') int? type, // 类型：1 limit，2 market，3 stop
    @Field('side') String? side,
    @Field('status') String? status,
    @Field('symbol') String? symbol,
  );

  /// @description: 历史成交
  @POST('/trade/new')
  Future<SpotTradeRes> tradeList(
    @Field('page') int page, // 页码
    @Field('pageSize') int pageSize, // 每页数量
    @Field('side') String? side,
    @Field('symbol') String? symbol,
  );

  /// @description: 获取交易对
  @POST('/finance/symbol_list')
  Future<List<String>> symbolList();

  /// @description: 获取交易对
  @POST('/common/public_info')
  Future<SpotPublicInfo> publicInfo();

  /// 获取icon
  @POST('/common/get_coin_url')
  Future getIcon();
}
