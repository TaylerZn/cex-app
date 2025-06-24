import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/models/search/search_all.dart';
import 'package:nt_app_flutter/app/models/search/search_functions.dart';
import 'package:nt_app_flutter/app/models/search/search_futures.dart';
import 'package:nt_app_flutter/app/models/search/search_market.dart';
import 'package:nt_app_flutter/app/models/search/search_question.dart';
import 'package:nt_app_flutter/app/models/search/search_topics.dart';
import 'package:nt_app_flutter/app/models/search/search_trader.dart';
import 'package:nt_app_flutter/app/models/user/res/invite.dart';
import 'package:nt_app_flutter/app/models/user/res/user.dart';
import 'package:retrofit/retrofit.dart';
import '../../network/bika/bika_app_dio.dart';

part 'search.g.dart';

@RestApi()
abstract class SearchApi {
  factory SearchApi(Dio dio, {String baseUrl}) = _SearchApi;

  factory SearchApi.instance() => SearchApi(BikaAppDio.getInstance().dio);

  @POST('/search/prompt') //搜索关键字下拉
  Future searchPrompt(
    @Field('keyword') String? keyword,
    @Field('size') String? size,
  );

  @POST('/common/recommend_coin') //未输入关键字-推荐币种
  Future commonRecommendCoin();

  @POST('/search/hotwords') //热门搜索
  Future searchHotwords(
    @Field('type') String? type,
    @Field('size') String? size,
  );

  @POST('/search/all') //搜索所有
  Future searchAll(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/optionals') //自选搜索（现货）
  Future searchOptionals(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/futuresOptionals') //自选搜索(永续合约)
  Future searchFuturesOptionals(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/stdFuturesOptionals') //自选搜索(标准合约)
  Future searchStdFuturesOptionals(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/traders') //交易员搜索
  Future<SearchTradersModel?> searchTraders(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/markets') //现货搜索
  Future<SearchMarketModel?> searchMarkets(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/futures') //合约搜索（永续、标准）
  Future<SearchFuturesModel?> searchFutures(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/notices') //公告搜索
  Future searchNotices(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/topics') //社区搜索
  Future<SearchTopicsModel?> searchTopics(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/functions') //功能搜索
  Future<SearchFunctionsModel?> searchFunctions(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/questions') //常见问题
  Future<SearchQuestionsModel?> searchQuestions(
    @Field('page') String? page,
    @Field('pageSize') String? pageSize,
    @Field('keyword') String? keyword,
  );

  @POST('/search/getHotTrades') //热门交易(永续合约)
  Future<SearchHotTrades> getHotTrades(@Field('size') num size);
}
