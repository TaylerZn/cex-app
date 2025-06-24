import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/trade/trade.dart';
import 'package:nt_app_flutter/app/network/app_dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'trade.g.dart';

@RestApi()
abstract class TradeApi {
  factory TradeApi(Dio dio, {String baseUrl}) = _TradeApi;

  factory TradeApi.instance() => TradeApi(AppDio.getInstance().dio);

  @POST('/trader/info') //超级交易员详情_我的
  Future<TraderInfoModel> traderinfo(@Body() request);

  @POST('/noAuth/trader/info') //超级交易员详情
  Future<TraderInfoModel> noAuthtraderinfo(@Body() request);

  @POST('/traderFocus/upsert') //关注或取消关注交易员
  Future traderFocusupsert(@Body() request);

  @POST('/trader/invest/pageList') //我是_超级交易员投资列表
  Future<PublicListModel> traderinvestpageList(@Body() request);

  @POST('/noAuth/trader/invest/pageList') //超级交易员投资列表
  Future<PublicListModel> noAuthtraderinvestpageList(@Body() request);

  @POST('/trader/follower/pageList') //我是交易员_跟随者列表
  Future<PublicListModel> traderfollowerpageList(@Body() request);

  @POST('/noAuth/trader/follower/pageList') //跟随者列表
  Future<PublicListModel> noAuthtraderfollowerpageList(@Body() request);

  @POST('/noAuth/trader/assetDistribution') //资产分布
  Future<NoAuthtraderassetDistributionModel> noAuthtraderassetDistribution(
      @Body() request);

  @POST('/followOrderConfig/list') //跟单配置列表
  Future<List<FollowOrderConfiglistModel>> followOrderConfiglist(
      @Body() request);

  @POST('/noAuth/trader/summary/invest/list') //交易员投资简要信息列表
  Future<List<TraderinvestlistModel>> noAuthtraderinvestlist(@Body() request);

  @POST('/stock/mineInvest/followOrder') //交易员投资简要信息列表
  Future stockmineInvestfollowOrder(@Body() request);
}
