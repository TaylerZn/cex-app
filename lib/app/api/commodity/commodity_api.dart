import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_open_time.dart';
import 'package:nt_app_flutter/app/models/contract/res/option_recommend_contract_id.dart';

import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_flow_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_historical_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_history_model.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/commodity/res/commodity_open_status.dart';
import '../../models/commodity/res/commodity_public_info.dart';
import '../../models/contract/req/create_order_req.dart';
import '../../models/contract/res/capital_list_info.dart';
import '../../models/contract/res/change_position_amount_info.dart';
import '../../models/contract/res/coin_info.dart';
import '../../models/contract/res/contract_leverage.dart';
import '../../models/contract/res/craate_order_res.dart';
import '../../models/contract/res/depth_map.dart';
import '../../models/contract/res/order_info.dart';
import '../../models/contract/res/position_res.dart';
import '../../models/contract/res/symbol_rate_info.dart';
import '../../models/contract/res/user_config_info.dart';
import '../../models/contract/res/funding_rate.dart';

part 'commodity_api.g.dart';

//标准合约api
@RestApi()
abstract class CommodityApi {
  factory CommodityApi(Dio dio, {String baseUrl}) = _CommodityApi;

  factory CommodityApi.instance() => CommodityApi(
        BikaAppDio.getInstance().dio,
        baseUrl: BestApi.getApi().standardUrl,
      );

  /// @description: 获取合约相关信息
  @POST('/common/public_info')
  Future<CommodityPublicInfo> getPublicInfo();

  /// @description: 获取自选合约列表
  @POST('/contract_optional_list')
  Future<OptionRecommendContractId> getContractOptionalList();

  /// @description: 添加自选合约
  /// @param {int} contractId 合约id，多个用逗号隔开
  @POST('/contract_optional_set')
  Future setContractOptionalList(
      @Field('contractOptionalList') String contractOptionalList);

  /// @Description: 获取用户配置信息
  /// @param contractId 合约id
  @POST('/user/get_user_config')
  Future<UserConfigInfo> getUserConfig(@Field('contractId') num contractId);

  /// @Description: 修改杠杆倍数
  /// @param contractId 合约id
  /// @param nowLevel 杠杆倍数
  @POST('/user/level_edit')
  Future levelEdit(
    @Field('nowLevel') int nowLevel,
    @Field('contractId') num contractId,
  );

  /// @description: 获取当前订单列表
  /// @param {int} limit
  /// @param {int} page 分页
  /// @param {int} contractId 合约id
  /// @return {Future<OrderRes>}
  @POST('/order/current_order_list')
  Future<OrderRes> currentOrderList(
    @Field('limit') int limit,
    @Field('page') int page,
    @Field('contractId') num contractId,
  );

  /// @description: 触发家委托
  @POST('/order/trigger_order_list')
  Future<OrderRes> triggerOrderList(
    @Field('limit') int limit,
    @Field('page') int page,
    @Field('contractId') num contractId,
  );

  /// @description: 获取仓位列表
  /// @param {int} onlyAccount 1 只返回资产信息 0 返回资产信息和仓位信息
  /// @param {int} marginCoin 保证金币中，不传查全部币种
  @FormUrlEncoded()
  @POST('/position/get_assets_list')
  Future<PositionRes> getAssetsList(
    @Field('onlyAccount') String onlyAccount,
    @Field('marginCoin') String? marginCoin,
  );

  /// @description: 创建委托订单
  @POST('/order/order_create')
  Future<CreateOrderRes> createOrder(@Body() CreateOrderReq req);

  /// @description: 取消委托订单
  /// @param {String} orderId 订单id
  /// @param {bool} isConditionOrder 是否是条件单
  /// @param {int} contractId 合约id
  @POST('/order/order_cancel')
  Future cancelOrder(
    @Field('orderId') String orderId,
    @Field('isConditionOrder') bool isConditionOrder,
    @Field('contractId') num contractId,
  );

  /// @description: 取消所有委托订单
  @POST('/order/cancel_all')
  Future cancelAllOrder();

  /// 获取资金费率
  @POST('/common/public_market_info')
  Future<FundingRate> getMarketInfo(
    @Field('symbol') String symbol,
    @Field('contractId') num contractId,
  );

  /// @description: 获取历史委托列表
  /// @param {int} limit
  /// @param {int} page 分页
  /// @param {int} contractId 合约id
  /// @return {Future<TransactionHistoryEntrust>}
  @POST('/order/history_order_list')
  Future<TransactionHistoryEntrust> historyOrderList(
    @Field('limit') int limit,
    @Field('page') int page,
    @Field('contractId') num? contractId,
    @Field('type') num? type,
    @Field('status') List<num>? status,
    @Field('beginTime') num? beginTime,
    @Field('endTime') num? endTime,
  );

  /// @description: 获取历史条件委托
  @POST('/order/history_trigger_order_list')
  Future<TransactionHistoryEntrust> historyTriggerOrderList(
    @Field('limit') int limit,
    @Field('page') int page,
    @Field('contractId') num? contractId,
    @Field('type') num? type,
    @Field('status') List<num>? status,
    @Field('beginTime') num? beginTime,
    @Field('endTime') num? endTime,
  );

  /// @description: 获取历史成交
  /// @param {int} limit
  /// @param {int} page 分页
  /// @param {int} contractId 合约id
  /// @return {Future<TransactionHistoricalTrans>}
  @POST('/order/his_trade_list')
  Future<TransactionHistoricalTrans> hisTradeList(
    @Field('limit') int limit,
    @Field('page') int page,
    @Field('contractId') num? contractId,
    @Field("beginTime") int? beginTime,
    @Field("endTime") int? endTime,
  );

  /// @description: 获取资金流水
  /// @param {int} limit
  /// @param {int} page 分页
  /// @param {int} contractId 合约id
  /// @return {Future<TransactionFlowFunds>}
  @POST('/record/get_transaction_list')
  Future<TransactionFlowFunds> flowFundsList(
    @Field('limit') int limit,
    @Field('page') int page,
    @Field('symbol') String? symbol,
    @Field('type') num? type,
    @Field('beginTime') int? beginTime,
    @Field('endTime') int? endTime,
  );

  /// 汇率
  @POST('/common/symbol_rate_list')
  Future<SymbolRateListRes> getSymbolRateList();

  /// 深度
  @POST('/common/depth_map')
  Future<DepthMap> getDepthMap(
    @Field('contractId') num contractId,
  );

  /// 开通合约
  @POST("/user/create_co_id")
  Future createCoId(@Field('token') String token);

  /// 一键平仓
  @POST("/order/close_all_position")
  Future closeAllPosition(@Field('contractId') num? contractId);

  /// 修改保证金模式
  /// @param {int} contractId 合约id
  /// @param {String} marginModel 保证金模式 1 全仓 2 逐仓
  @POST('/user/margin_model_edit')
  Future marginModelEdit(
    @Field('contractId') num contractId,
    @Field('marginModel') num marginModel,
  );

  /// 获取标准合约的交易时段
  @POST('/common/get_contract_open_time')
  Future<CommodityOpenTime> getContractOpenTime(
    @Field('contractId') num contractId,
  );

  /// 获取标准合约的交易时段
  @POST('/common/get_contract_open_status')
  Future<CommodityOpenStatus> getContractOpenStatus(
    @Field('contractId') num contractId,
  );

  /// 查询合约订单
  @POST('/order/find_co_order')
  Future<OrderRes> findCoOrder(
      @Field('pageNum') num pageNum,
      @Field('pageSize') num pageSize,
      @Field('contractId') num? contractId,
      @Field('status') String? status,
      [@Field('createTimeStart') int? beginTime,
      @Field('createTimeEnd') int? endTime,
      @Field('type') int? type,
      @Field('sortType') String sortType = 'CREATE_TIME']);

  /// 查询条件单
  /// @param {int} pageNum
  /// @param {int} pageSize
  /// @param {int} contractId 合约id
  /// @param {String} status 订单状态
  /// 普通委托订单(非条件单)状态包括：0 (INIT 初始状态 未进撮合) 1(NEW 进撮合盘口)
  /// 2(FILLED 完全成交) 3(PART_FILLED 部分成交) 4(CANCELED 已取消)
  /// 5(PENDING_CANCEL 待取消) 6(EXPIRED 已过期) 7(PART_FILLED_CANCELED 无法自动处理的异常订单)
  @POST('/order/find_trigger_order')
  Future<OrderRes> findTriggerOrder(
    @Field('pageNum') num pageNum,
    @Field('pageSize') num pageSize,
    @Field('contractId') num? contractId,
    @Field('status') String? status, [
    @Field('createTimeStart') int? beginTime,
    @Field('createTimeEnd') int? endTime,
        @Field('sortType') String sortType = 'CREATE_TIME'
  ]);

  /// 资金费率
  @POST("/common/funding_rate_list")
  Future<CapitalListInfo> fundingRateList(@Field('contractId') num contractId,
      @Field('limit') num limit, @Field('page') num page);

  /// 价格列表
  @POST('/common/price_list')
  Future getPriceList();

  /// 查询变更保证金限制
  @POST('/position/query_change_position_amount')
  Future<ChangePositionAmountInfo> queryChangePositionAmount(
      @Field('positionId') String positionId, @Field('amount') String amount);

  /// 变更持仓保证金
  @POST('/position/change_position_margin')
  Future changePositionMargin(
      @Field('positionId') String positionId, @Field('amount') String amount);

  /// 获取阶梯配置
  @POST('/common/get_ladder_info')
  Future<ContractLeverage> getLadderInfo(
      @Field('contractId') String contractId);

  /// 获取icon
  /// @param {String} iconId iconId
  /// @param {String} iconType iconType
  /// 0 加密货币 1 股票 2指数 3 外汇 4 大宗 5 ETF
  @GET('/common/coin_market_info/{coinSymbol}')
  Future getCoinMarketInfo(
      @Path('coinSymbol') String coinSymbol, @Query('kind') int kind);
}
