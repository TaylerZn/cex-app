import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/assets/asset_account_balance.dart';
import 'package:nt_app_flutter/app/models/assets/assets_charge_address.dart';
import 'package:nt_app_flutter/app/models/assets/assets_convert_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_coupon_card_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_currency.dart';
import 'package:nt_app_flutter/app/models/assets/assets_deposit_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_funds.dart';
import 'package:nt_app_flutter/app/models/assets/assets_overview.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spot_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spot_trade_history.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/models/assets/assets_transfer_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_withdraw_config.dart';
import 'package:nt_app_flutter/app/models/assets/assets_withdraw_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_withdraw_result.dart';
import 'package:nt_app_flutter/app/models/trade/convert_create_order.dart';
import 'package:nt_app_flutter/app/models/trade/convert_currencies_model.dart';
import 'package:nt_app_flutter/app/models/trade/convert_quick_quote_rate.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/model/assets_exchange_rate.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../../network/bika/bika_app_dio.dart';

part 'assets_api.g.dart';

@RestApi()
abstract class AssetsApi {
  factory AssetsApi(Dio dio, {String baseUrl}) = _AssetsApi;

  factory AssetsApi.instance() => AssetsApi(BikaAppDio.getInstance().dio);

  /// 获取总览账户余额
  @POST('/finance/features/total_account_balance')
  Future<AssetsOverView?> getTotalAccountBalance();

  /// 获取现货资产
  @POST('/finance/v4/account_balance')
  Future<AssetsSpots?> getSpotsAccountBalance();

  /// 拥有的资产
  // @POST('/finance/v4/account_balance')
  // Future<AssetAccountBalance> getSpotsAccountBalance();

  /// 划转
  @POST('/app/co_transfer')
  Future transfer(
      @Field('amount') String amount, @Field('coinSymbol') String coinSymbol, @Field('transferType') String transferType);

  /// 划转 (现货 和 永续合约、标准合约、跟单账户 相互划转)
  @Extra({showLoading: true})
  @POST('/exchange/account_transfer')
  Future spotsTransfer(
      @Field('amount') String amount, @Field('coinSymbol') String coinSymbol, @Field('transferType') String transferType);

  /// 资产划转（现货 和 资金 相互划转）
  @POST("/finance/otc_transfer")
  Future financeOtcTransfer(
    @Field('fromAccount') String fromAccount,
    @Field('toAccount') String toAccount,
    @Field('amount') String amount,
    @Field('coinSymbol') String coinSymbol,
  );

  /// 获取资金账户-资产
  @POST('/finance/v4/otc_account_list')
  Future<AssetsFunds?> getOtcAccountBalance();

  /// 获取币种列表
  @POST('/finance/symbol_list')
  Future<AssetsCurrency> getCurrencyList();

  /// 获取充值地址
  @POST('/finance/get_charge_address')
  Future<AssetsChargeAddress?> getChargeAddress(
    @Field('symbol') String symbol,
    @Field('mainnet') String mainnet,
  );

  /// 获取充值网络
  @POST('/finance/symbol_support_nets')
  Future symbolsupportnets(
    @Field('symbol') String mainnet,
  );

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

  /// 获取闪兑订单的历史记录
  @POST('/v1/quick/order_list')
  Future<AssetsConvertRecord?> getQuickOrderList(
    @Field('pageSize') int pageSize,
    @Field('page') int page,
    @Field('startTime') int? startTime,
    @Field('endTime') int? endTime,
    @Field('symbol') String symbol,
  );

  @POST('/v1/quick/create_order') //闪兑下单接口
  Future<ConvertCreateOrder?> quickCreateOrder(@Field('base') String base, @Field('quote') String quote,
      {@Field('baseAmount') String? baseAmount, @Field('quoteAmount') String? quoteAmount});

  @GET('/v1/quick/quote') //获取闪兑汇率
  Future<ConvertQuickQuoteRate?> getQuickQuote(
    @Query('base') String base,
    @Query('quote') String quote,
  );
  @GET('/v1/quick/currencies') //获取闪兑支持的币种
  Future<ConvertCurrenciesModel?> getQuickCurrencies();

  /// 获取赠金券接口
  @POST('/record/coupon_card_list')
  Future<AssetsCouponCardRecord?> getCouponCardList(
    @Field('status') dynamic status, //0已领取 1已失效（包含已完成） 不传返回全部
  );

  /// 获取现货交易(历史成交)
  @POST('/trade/new')
  Future<SpotsTradeHistoryModel?> getSpotsTradeListHistory(
    @Field('symbol') String? symbol,
    @Field('side') String? side,
    @Field('pageSize') int pageSize,
    @Field('page') int page,
    @Field('startTime') String startTime,
    @Field('endTime') String endTime,
  );

  /// 获取划转历史
  @POST('/record/otc_transfer_list')
  @Extra({showLoading: true})
  Future<AssetsTransferRecord> getTransferList(
      @Field('coinSymbol') String coinSymbol, @Field('pageSize') int pageSize, @Field('page') int page);

  /// 获取现货历史委托
  @POST('/order/entrust_history')
  @Extra({showLoading: true})
  Future<AssetsSpotRecord> getSpotList(
      @Field('symbol') String symbol, @Field('pageSize') int pageSize, @Field('page') int page);

  /// 获取提币配置
  @POST('/cost/Getcost')
  Future<AssetsWithdrawConfig> getWithdrawConfig(@Field('symbol') String symbol);

  /// 提币
  @POST('/finance/do_withdraw')
  Future<AssetsWithdrawResult> doWithdraw(
    @Field('symbol') String symbol,
    @Field('amount') String amount,
    @Field('addressId') String addressId,
    @Field('smsAuthCode') String smsAuthCode,
    @Field('googleCode') String googleCode,
    @Field('emailCode') String emailCode,
    @Field('mainnet') String mainnet,
  );

  /// 28、资产统计（日、周、月、年）
  @POST('/stats/assetsSearch')
  Future<List<AssetsKLIneModel>?> assetsSearch(@Field('statsTime') String statsTime);
}
