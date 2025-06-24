import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_advert.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

extension AFCustomer on OtcApi {
  /// 获取加密币种下拉列表
  static Future getObtainCoins() async {
    try {
      return await OtcApi.instance().getObtainCoins();
    } on dio.DioException catch (e) {
      print('${e.error}');
    }
  }

  /// 获取商户广告数据
  static Future<CustomerAdvertListModel> getAdvert({
    int page = 1,
    int pageSize = 10,
    int side = 0,
    String coin = 'USDT',
    String tradeValue = '',
    int tradeType = 0,
    List? payments,
    String paycoin = 'USD',
    int isBlockTrade = 0,
  }) async {
    try {
      return await OtcApi.instance().getAdvert(
          page: page,
          pageSize: pageSize,
          side: side == 0 ? 'SELL' : 'BUY',
          coin: coin,
          tradeType: tradeType,
          tradeValue: tradeValue.isEmpty ? null : tradeValue.toDouble(),
          payments: payments ?? [],
          paycoin: paycoin,
          isBlockTrade: isBlockTrade)
        ..isError = false;
    } on dio.DioException catch (e) {
      print('${e.error}');
      return CustomerAdvertListModel()
        ..isError = true
        ..exception = e;
    }
  }

  /// 获取当前用户是否有完成的c2c订单

  static Future getObtainProtect() async {
    try {
      return await OtcApi.instance().getObtainProtect();
    } on dio.DioException catch (e) {
      print('${e.error}');
    }
  }

  /// 根据广告id获取详情信息

  static Future<CustomerAdvertDetailModel> getAdertWithId({String? id}) async {
    try {
      return await OtcApi.instance().getAdertWithId(id: id ?? '-1')
        ..isError = false;
    } on dio.DioException catch (e) {
      print('${e.error}');
      return CustomerAdvertDetailModel()
        ..isError = true
        ..exception = e;
    }
  }

  /// 根据广告id获取详情信息

  static Future<CustomerAdvertRefreshModel> getAdertRefreshWithId({
    String? id,
    String? coin,
  }) async {
    try {
      return await OtcApi.instance().getAdertRefreshWithId(id: id ?? '-1', coin: coin ?? '');
    } on dio.DioException catch (e) {
      print('${e.error}');
      return CustomerAdvertRefreshModel();
    }
  }

  /// 购买广告(我要买)
  static Future<CustomerAdvertTradeModel> postAdvertPurchase({
    num? advertId,
    num totalPrice = 0,
    String? payment,
    num price = 0,
    num volume = 0,
  }) async {
    try {
      return await OtcApi.instance().postAdvertPurchase(
        advertId: advertId ?? 0,
        totalPrice: totalPrice,
        payment: payment ?? '',
        price: price,
        volume: volume,
      );
    } on dio.DioException catch (e) {
      UIUtil.showToast(e.error);
      return CustomerAdvertTradeModel();
    }
  }

  ///出售广告(我要卖)

  static Future postAdvertSell({
    num? advertId,
    String? payment,
    num price = 0,
    num volume = 0,
  }) async {
    try {
      return await OtcApi.instance().postAdvertSell(
        advertId: advertId ?? 0,
        payment: payment ?? '',
        price: price,
        volume: volume,
      );
    } on dio.DioException catch (e) {
      UIUtil.showToast(e.error);
      return CustomerAdvertTradeModel();
    }
  }

  ///获取交易中的订单(当前登录人)
  static Future getObtainTrading() async {
    try {
      return await OtcApi.instance().getObtainTrading();
    } on dio.DioException catch (e) {
      print('${e.error}');
    }
  }

  /// 根据订单id查询订单详情

  static Future<CustomerOrderDetailModel> getOrderhWithId({
    num? id,
  }) async {
    try {
      return await OtcApi.instance().getOrderhWithId(id: (id ?? -1).toString());
    } on dio.DioException catch (e) {
      print('${e.error}');
      return CustomerOrderDetailModel();
    }
  }

  /// 订单最新的聊天记录及聊天未读条数

  static Future<CustomerOrderChartModel> getAdvertChatWithId({
    num? id,
  }) async {
    try {
      return await OtcApi.instance().getAdvertChatWithId(id: (id ?? -1).toString());
    } on dio.DioException catch (e) {
      print('${e.error}');
      return CustomerOrderChartModel();
    }
  }

  /// 买家取消订单

  static Future postOrderCancel({
    String sequence = '',
  }) async {
    try {
      return await OtcApi.instance().postOrderCancel(sequence: sequence);
    } on dio.DioException catch (e) {
      UIUtil.showToast(e.error);
      return {};
    }
  }

  /// 确定支付
  static Future postOrderPayed({
    String sequence = '',
    String? payment,
  }) async {
    try {
      return await OtcApi.instance().postOrderPayed(sequence: sequence, payment: payment ?? '');
    } on dio.DioException catch (e) {
      UIUtil.showToast(e.error);
      return {};
    }
  }

  /// 确定转账
  static Future postOrderConfirm({
    String sequence = '',
    int checkType = 0,
    String code = '',
  }) async {
    try {
      return await OtcApi.instance().postOrderConfirm(sequence: sequence, checkType: checkType, code: code);
    } on dio.DioException catch (e) {
      UIUtil.showToast(e.error);
      return {};
    }
  }

  /// 订单申述
  static Future getOrderComplaintWithId({
    num? id,
    num? complaintId,
  }) async {
    try {
      return await OtcApi.instance()
          .getOrderComplaintWithId(id: (id ?? -1).toString(), complaintId: (complaintId ?? 0).toString());
    } on dio.DioException catch (e) {
      UIUtil.showToast(e.error);
      return {};
    }
  }

  ///订单申述取消
  static Future postOrderComplainCancel({num? id}) async {
    try {
      return await OtcApi.instance().postOrderComplainCancel(id: (id ?? -1).toString());
    } on dio.DioException catch (e) {
      print('${e.error}');
      UIUtil.showToast(e.error);
      return {};
    }
  }

  /// 非申诉者订单申述
  static Future getOrderToComplaint({
    num? orderId,
    num? toComplaint,
  }) async {
    try {
      return await OtcApi.instance().orderToComplaint(orderId ?? -1, toComplaint ?? 0);
    } on dio.DioException catch (e) {
      UIUtil.showToast(e.error);
      return {};
    }
  }

  /// 非申诉者订单申述
  static Future advertMaxVolme({
    String? source,
  }) async {
    try {
      return await OtcApi.instance().advertMaxVolme(source);
    } on dio.DioException catch (e) {
      UIUtil.showToast(e.error);
      return {};
    }
  }
}
