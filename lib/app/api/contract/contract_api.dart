import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/contract/res/contract_leverage.dart';
import 'package:nt_app_flutter/app/models/contract/res/option_recommend_contract_id.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_flow_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_historical_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_history_model.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';
import 'package:nt_app_flutter/app/network/retry_interceptor.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/assets/assets_deposit_record.dart';
import '../../models/contract/req/create_order_req.dart';
import '../../models/contract/res/capital_list_info.dart';
import '../../models/contract/res/change_position_amount_info.dart';
import '../../models/contract/res/craate_order_res.dart';
import '../../models/contract/res/depth_map.dart';
import '../../models/contract/res/funding_rate.dart';
import '../../models/contract/res/order_info.dart';
import '../../models/contract/res/position_res.dart';
import '../../models/contract/res/public_info.dart';
import '../../models/contract/res/symbol_rate_info.dart';
import '../../models/contract/res/user_config_info.dart';
import '../../models/contract/res/user_order_count.dart';

part 'contract_api.g.dart';

//永续合约api
@RestApi()
abstract class ContractApi {
  factory ContractApi(Dio dio, {String baseUrl}) = _ContractApi;

  factory ContractApi.instance() => ContractApi(
        BikaAppDio.getInstance().dio,
        baseUrl: BestApi.getApi().contractUrl,
      );

  /// @description: 获取合约相关信息
  @POST('/common/public_info')
  @Extra({kRetry: true})
  Future<PublicInfo> getPublicInfo();

  /// @description: 获取语言包
  /// @param {String} 语言key
  /// @param {int} type 1 web 2 app 3 server 4 后台
  /// @return {Future<PublicInfoMarket>}
  @POST('/common/get_locale')
  Future<LangInfo> getLocale(
      @Field('langKey') String langeKey, @Field('type') num type);

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
  Future<UserConfigInfo?> getUserConfig(@Field('contractId') num contractId);

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

  /// @description: 条件委托列表
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
  @Extra({showLoading: true})
  Future cancelOrder(
    @Field('orderId') String orderId,
    @Field('isConditionOrder') bool? isConditionOrder,
    @Field('contractId') num contractId,
  );

  /// @description: 取消所有委托订单
  @POST('/order/cancel_all')
  @Extra({showLoading: true})
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
  @Extra({showLoading: true})
  Future<TransactionHistoryEntrust> historyOrderList(
    @Field('limit') int limit,
    @Field('page') int page,
    @Field('contractId') num contractId,
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
    @Field('contractId') num? contractId, {
    @Field('beginTime') num? beginTime,
    @Field('endTime') num? endTime,
  });

  /// @description: 获取资金流水
  /// @param {int} limit
  /// @param {int} page 分页
  /// @param {int} contractId 合约id
  /// @return {Future<TransactionFlowFunds>}
  @POST('/record/get_transaction_list')
  Future<TransactionFlowFunds> flowFundsList(
    @Field('limit') int limit,
    @Field('page') int page,
    @Field('symbol') String symbol, {
    @Field('type') num? type,
    @Field('beginTime') num? beginTime,
    @Field('endTime') num? endTime,
  });

  /// 汇率
  @POST('/common/symbol_rate_list')
  Future<SymbolRateListRes> getSymbolRateList();

  /// 深度
  @POST('/liquidity-market/market/depth')
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

  /// 查询合约订单
  /// @param {int} pageNum
  /// @param {int} pageSize
  /// @param {int} contractId 合约id
  /// @param {String} status 订单状态
  /// 普通委托订单(非条件单)状态包括：
  /// 0 (INIT 初始状态 未进撮合)
  /// 1(NEW 进撮合盘口)
  /// 2(FILLED 完全成交) 3(PART_FILLED 部分成交) 4(CANCELED 已取消)
  /// 5(PENDING_CANCEL 待取消) 6(EXPIRED 已过期) 7(PART_FILLED_CANCELED 无法自动处理的异常订单)
  @POST('/order/find_co_order')
  Future<OrderRes> findCoOrder(
      @Field('pageNum') num pageNum,
      @Field('pageSize') num pageSize,
      @Field('contractId') num? contractId,
      @Field('status') String? status,
      {@Field('type') num? type,
      @Field('createTimeStart') num? createTimeStart,
      @Field('createTimeEnd') num? createTimeEnd});

  /// 查询条件单
  /// @param {int} pageNumda
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
      @Field('status') String status,
      {@Field('type') num? type,
      @Field('createTimeStart') num? createTimeStart,
      @Field('createTimeEnd') num? createTimeEnd});

  /// 获取icon
  @POST('/common/get_icon_url')
  Future getIcon();

  ///
  @POST('/order/get_user_order_count')
  Future<UserOrderCount> getUserOrderCount();

  /// 资金费率
  @POST("/common/funding_rate_list")
  Future<CapitalListInfo> fundingRateList(@Field('contractId') num contractId,
      @Field('limit') num limit, @Field('page') num page);

  /// 价格列表
  @POST('/common/price_list')
  Future getPriceList();

  /// 查询变更保证金限制
  @POST('/position/query_change_position_margin')
  Future<ChangePositionAmountInfo> queryChangePositionAmount(
      @Field('positionId') String positionId, @Field('amount') String amount);

  /// 答题
  @GET('/common/surveys')
  Future contractAnswer();

  /// 开通合约交易（答题后开通）
  @POST('/user/open_trade')
  Future openTrade();

  /// 变更持仓保证金
  @POST('/position/change_position_margin')
  Future changePositionMargin(
      @Field('positionId') String positionId, @Field('amount') String amount);

  //后台的划转的补丁
  /// 获取钱包历史记录
  @POST('/record/ex_transfer_list_v4')
  Future<AssetsHistoryRecord?> getWalletHistoryList(
      @Field('transactionScene') String transactionScene,
      @Field('coinSymbol') String coinSymbol,
      @Field('pageSize') int pageSize,
      @Field('page') int page,
      @Field('status') dynamic status,
      @Field('startTime') String startTime,
      @Field('endTime') String endTime,
      @Field('account') String? account,
      {@Field('transferType') String? transferType});

  /// 获取阶梯配置
  @POST('/common/get_ladder_info')
  Future<ContractLeverage> getLadderInfo(@Field('contractId') String contractId);
}
