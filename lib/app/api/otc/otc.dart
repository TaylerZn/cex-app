import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_deposit_record.dart';
import 'package:nt_app_flutter/app/models/otc/b2c/crypto_quote.dart';
import 'package:nt_app_flutter/app/models/otc/b2c/order_currency_fiat.dart';
import 'package:nt_app_flutter/app/models/otc/b2c/order_history_res.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_apply_info.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_public_info.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_user_info.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/payment_info.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/c2c_detail_problem_res.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/c2c_message_tip.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/c2c_unread_message_count.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/model/assets_exchange_rate.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_advert.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/otc/c2c/advert_exchange_rate.dart';
import '../../models/otc/c2c/advert_model.dart';
import '../../models/otc/c2c/otc_record.dart';

part 'otc.g.dart';

@RestApi()
abstract class OtcApi {
  factory OtcApi(Dio dio, {String baseUrl}) = _OtcApi;

  factory OtcApi.instance() => OtcApi(
        BikaAppDio.getInstance().dio,
        baseUrl: BestApi.getApi().otcUrl,
      );

  /// 列出支持的法币
  @GET('/b2c/alchemy/fiat_list')
  Future<List<B2CCurrencyModel>?> b2cCurrencyFiat(
    @Query('type') String? type,
  );

  /// 列出支持的加密币-仅USDT
  @GET('/b2c/alchemy/crypto_list')
  Future<List<B2CCryptoModel>?> b2cCurrencyCrypto();

  /// 获取加密币限额
  @GET('/b2c/currencie/{currencyCode}/limits')
  Future b2cCurrencyCryptoLimits(@Path("currencyCode") String? currencyCode);

  /// 获取实时报价  ///b2c/alchemy/quote_price
  @POST('/b2c/alchemy/quote_price')
  Future<B2CCryptoQuote> b2cCurrencyCryptoBuyQuote(
    @Field('side') String? side,
    @Field('fiatAmount') String? fiatAmount,
    @Field('fiatCurrency') String? fiatCurrency,
    @Field('cryptoCurrency') String? cryptoCurrency,
    @Field('cryptoQuantity') String? cryptoQuantity,
    @Field('network') String? network,
  );

  /// 支付渠道列表
  @GET('/b2c/alchemy/channel_list')
  Future<List<B2CChannelModel>?> b2cChannelList(
    @Query('fiat') String? fiat,
    @Query('network') String? network,
    @Query('crypto') String? crypto,
  );

  /// 获取资金钱包余额-B2C
  @GET('/b2c/account')
  Future b2cAccount();

  /// 下单
  @POST("/b2c/alchemy/create_order")
  Future b2cOrderTransaction(
    @Field('side') String? side,
    @Field('amount') String? amount,
    @Field('fiatCurrency') String? fiatCurrency,
    @Field('cryptoCurrency') String? cryptoCurrency,
    @Field('network') String? network,
    @Field('payWayCode') String? payWayCode,
    @Field('cryptoQuantity') String? cryptoQuantity,
  );

  /// 出金-预下单-带签名
  @POST("/b2c/order/transaction/sell")
  Future b2cOrderTransactionSell(
    @Field('baseCurrency') String? baseCurrency,
    @Field('baseCurrencyAmount') num? baseCurrencyAmount,
    @Field('quoteCurrency') String? quoteCurrency,
    @Field('quoteCurrencyAmount') num? quoteCurrencyAmount,
  );

  /// 交易订单
  @GET('/b2c/alchemy/order_list')
  Future<B2COrderTransctionListModel?> b2cOrderTransctionList(
    @Query('orderType') num? orderType, // null 全部 0 进行 1 已完成
    @Query('pageSize') num? pageSize,
    @Query('currentPage') num? currentPage,
  );

  /// 聊天框消息接口
  /// orderId 订单id
  /// fromId 发送者id
  /// toId 接收者id
  @POST('/chatMsg/message')
  Future<List<C2CMessageTip>> chatMsgMessage(
    @Field('orderId') String? orderId,
    @Field('fromId') String? fromId,
    @Field('toId') String? toId,
  );

  /// 未读消息数
  /// id 订单id
  @GET('/api/v2/order/{id}/chat/history/')
  Future<C2CUnreadMessageCount> chatHistory(@Path('id') int id);

  /// 公共配置
  @POST('/otc/public_info')
  Future<OtcPublicInfo?> public_info();

  ////获取申请状态
  @GET('/c2c/merchant/apply/info')
  Future<OtcApplyInfo?> applyInfo();

  ///个人中心
  @GET('/c2c/person/info')
  Future<OtcUserInfo?> personInfo(@Query('uid') int uid);

  ////查询用户所有支付方式
  @GET('/c2c/payment/list')
  Future<List<PaymentInfo?>?> paymentList();

  /// 获取加密币种下拉列表
  @GET('/api/v2/advert/obtain/coins')
  Future<CustomerCoinListModel> getObtainCoins();

  /// 获取商户广告数据
  @POST('/api/v2/advert/page')
  Future<CustomerAdvertListModel> getAdvert({
    @Field('current') required int page,
    @Field('size') required int pageSize,
    @Field('side') required String side,
    @Field('coin') required String coin,
    @Field('tradeValue') required num? tradeValue,
    @Field('tradeType') required int tradeType,
    @Field('payments') required List payments,
    @Field('paycoin') required String paycoin,
    @Field('isBlockTrade') required int isBlockTrade,
  });

  /// 获取当前用户是否有完成的c2c订单
  @GET('/api/v2/order/obtain/protect/t1')
  @Extra({showLoading: true})
  Future getObtainProtect();

  /// 根据广告id获取详情信息
  @GET('/api/v2/advert/{id}')
  @Extra({showLoading: true})
  Future<CustomerAdvertDetailModel> getAdertWithId({
    @Path("id") required String id,
  });

  ///手动刷新广告最新信息(限频5s)
  @GET('/api/v2/advert/refresh/{id}/{coin}')
  Future<CustomerAdvertRefreshModel> getAdertRefreshWithId({
    @Path("id") required String id,
    @Path("coin") required String coin,
  });

  /// 购买广告(我要买)
  @POST('/api/v2/advert/purchase')
  @Extra({showLoading: true})
  Future<CustomerAdvertTradeModel> postAdvertPurchase({
    @Field('advertId') required num advertId,
    @Field('totalPrice') required num totalPrice,
    @Field('payment') required String payment,
    @Field('price') required num price,
    @Field('volume') required num volume,
  });

  ///出售广告(我要卖)
  @POST('/api/v2/advert/sell')
  @Extra({showLoading: true})
  Future<CustomerAdvertTradeModel> postAdvertSell({
    @Field('advertId') required num advertId,
    @Field('payment') required String payment,
    @Field('price') required num price,
    @Field('volume') required num volume,
  });

  ///获取交易中的订单(当前登录人)
  @GET('/api/v2/order/trading/me')
  Future<CustomerOrderTradeModel> getObtainTrading();

  /// 根据订单id查询订单详情
  @GET('/api/v2/order/{id}')
  Future<CustomerOrderDetailModel> getOrderhWithId({
    @Path("id") required String id,
  });

  /// 订单最新的聊天记录及聊天未读条数
  @GET('/api/v2/order/{id}/chat/history/')
  Future<CustomerOrderChartModel> getAdvertChatWithId({
    @Path("id") required String id,
  });

  /// 买家取消订单
  @POST('/api/v2/order/cancel')
  @Extra({showLoading: true})
  Future postOrderCancel({
    @Field("sequence") required String sequence,
  });

  /// 确定支付
  @POST('/api/v2/order/order/payed')
  @Extra({showLoading: true})
  Future postOrderPayed({
    @Field("payment") required String payment,
    @Field('sequence') required String sequence,
  });

  /// 确定转账
  @POST('/api/v2/order/confirm_order')
  @Extra({showLoading: true})
  Future postOrderConfirm({
    @Field("sequence") required String sequence,
    @Field('checkType') required int checkType,
    @Field('code') required String code,
  });

  /// 订单申述
  @POST('/api/v2/order/{id}/complaint/{complaintId}')
  // @Extra({showLoading: true})
  Future getOrderComplaintWithId({
    @Path("id") required String id,
    @Path("complaintId") required String complaintId,
  });

  ///订单申述取消
  @POST('/api/v2/order/{id}/complain/cancel')
  @Extra({showLoading: true})
  Future postOrderComplainCancel({@Path("id") required String id});

  ////申请成为商家
  @POST('/c2c/merchant/apply')
  Future applyC2C({
    @Field('isOtherPlatformMerchant') required num isOtherPlatformMerchant,
    @Field('applyMerchantType') required num applyMerchantType,
    @Field('phone') required String phone,
    @Field('email') required String email,
    @Field('otherPlatformName') required String otherPlatformName,
    @Field('otherPlatformAccountImages') List<String>? otherPlatformAccountImages,
    @Field('tgAccount') required String? tgAccount,
    @Field('twitterAccount') required String? twitterAccount,
    @Field('discordAccount') String? discordAccount,
  });

  ////缴纳保证金
  @POST('/c2c/merchant/bond')
  Future bondDeposit(
      {@Field('smsCode') String? smsCode, @Field('emailCode') String? emailCode, @Field('googleCode') String? googleCode});

  ////取回保证金
  @POST('/c2c/merchant/unbond')
  Future refundDeposit(
      {@Field('smsCode') String? smsCode, @Field('emailCode') String? emailCode, @Field('googleCode') String? googleCode});

  ////添加收款方式
  @POST('/c2c/payment/add')
  Future paymentAdd({
    @Field('payment') required String payment,
    @Field('userName') required String userName,
    @Field('account') required String account,
    @Field('bankName') required String bankName,
  });

  ////修改收款方
  @POST('/c2c/payment/update')
  Future paymentEdit({
    @Field('id') required int id,
    @Field('payment') required String payment,
    @Field('userName') required String userName,
    @Field('account') required String account,
    @Field('bankName') required String bankName,
  });

  ////添加收款方式
  @DELETE('/c2c/payment/{id}/delete')
  Future<dynamic> paymentDelete(@Path("id") int id);

  ////添加委托
  @POST('/c2c/advert/add')
  Future advertAdd({
    @Field('side') required String side,
    @Field('coin') required String coin,
    @Field('volume') required String volume,
    @Field('price') required String price,
    @Field('minTrade') required String minTrade,
    @Field('maxTrade') required String maxTrade,
    @Field('paycoin') required String paycoin,
    @Field('payments') required List<dynamic> payments,
    @Field('transUserLimit') required List<dynamic> transUserLimit,
    @Field('transDescription') required String? transDescription,
    @Field('chatAuto') required int chatAuto,
    @Field('chatAutoReply') required String? chatAutoReply,
  });

  ////取消委托
  @DELETE('/c2c/advert/{advertId}/cancel')
  Future<bool?> advertCancel(@Path('advertId') String? id);
  ////添加委托

  ////参考价汇率
  @POST('/c2c/exchange/rate')
  Future<AdvertExchangeRate?> exchangeRate({
    @Field('fiatCoin') required String fiatCoin,
    @Field('cryptoCoin') required String cryptoCoin,
  });

  ////商家委托列表
  @POST('/c2c/advert/list')
  Future<AdvertModel?> advertList(
      {@Field('currentPage') required int currentPage,
      @Field('pageSize') required int pageSize,
      @Field('uid') required int uid});

  ////我的订单列表
  @POST('/api/v2/order/page/me')
  Future<OtcRecord?> orderPage({
    @Field('current') required int currentPage,
    @Field('size') required int size,
    @Field('tab') required String tab,
    @Field('status') required int? status,
    @Field('side') String? side,
    @Field('startTime') String? startTime,
    @Field('endTime') String? endTime,
  });

  /// C2C资产账户流水
  @POST('/c2c/finance/transaction/list')
  Future<AssetsHistoryRecord?> c2cFinanceTransactionList(
    @Field('source') String? source, //来源 0全部 1划转 2 快捷买币 3 c2c交易
    @Field('coinSymbol') String coinSymbol, //数字币
    @Field('pageSize') int pageSize, //分页大小
    @Field('currentPage') int currentPage, //分页
  );

  /// 发布广告-最大值
  @POST('/c2c/advert/maxVolume')
  Future advertMaxVolme(
    @Field('side') String? source,
  );

  /// 订单-非订单申诉者保存工单id
  @POST('/api/v2/order/toComplaint')
  Future orderToComplaint(
    @Field('orderId') num? orderId,
    @Field('toComplaint') num? toComplaint,
  );

  /// 法币信息接口
  @GET('/b2c/alchemy/fiat_info')
  Future<List<AssetsFiat>?> fiatInfo();
}
