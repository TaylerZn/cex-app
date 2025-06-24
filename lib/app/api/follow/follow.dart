import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_explore.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_kol_setting.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_history_order.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/follow_kol_apply.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_kol_cancel.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_detail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/model/follow_kol_profit.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_block/model/follow_kol_relation.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/follow_my_trader.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/model/follow_kol_set.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_kol_traderdetail.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_manage_list.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/model/follow_super_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_trader_position.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/follow_user_order.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_questionnaire/models/follow_risk_query_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_questionnaire/models/follow_trader_preference_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_setup_symbol.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_taker_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/my_follow_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take/model/my_take_list.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';
import 'package:nt_app_flutter/app/network/bika/bika_app_dio.dart';
import 'package:retrofit/retrofit.dart';
part 'follow.g.dart';

@RestApi()
abstract class FollowApi {
  factory FollowApi(Dio dio, {String baseUrl}) = _FollowApi;

  factory FollowApi.instance() => FollowApi(BikaAppDio.getInstance().dio, baseUrl: BestApi.getApi().followUrl);

  @POST('/v2/user/isKol') //是否是交易员
  @Extra({showLoading: false})
  Future<FollowKol> getIsKol();

  @POST('/v2/kol/symbol_info') //获取带单币对
  @Extra({showLoading: false})
  Future<FollowSetupSymbol> symbolInfo({@Field('uid') required num uid});

  // @POST('/v2/kol/list') //交易员列表
  // @Extra({showLoading: false})
  // Future<FollowListModel> getKolList({
  //   @Field('page') required int page,
  //   @Field('pageSize') required int pageSize,
  //   @Field('orderByType') required int orderByType,
  // });

  // @POST('/v2/kol/history_order') //交易员历史带单
  // Future<FollowTakerHistoryOrder> getkolHistoryOrder({
  //   @Field('uid') required num uid,
  //   @Field('page') required int page,
  //   @Field('pageSize') required int pageSize,
  // });

  @POST('/v2/user/income_info') //我的跟单信息
  @Extra({showLoading: false})
  Future<MyFollowIncomeInfo> getMyFollowUserIncomeInfo();

  @POST('/v3/kol/follow') //跟单操作
  @Extra({showLoading: true})
  Future postkolFollow({
    @Field('uid') required num uid,
    @Field('amount') required String amount,
    @Field('coin') required String coin,
    @Field('isStopDeficit') required num isStopDeficit,
    @Field('stopDeficit') required String stopDeficit,
    @Field('isStopProfit') required num isStopProfit,
    @Field('stopProfit') required String stopProfit,
    @Field('symbolRelationStr') required String symbolRelationStr,
    @Field('followType') required num followType,
    @Field('copyMode') required num copyMode,
    @Field('singleAmount') required num singleAmount,
  });

  @POST('/v2/kol/follow_users') //跟单用户
  Future<MyTakefollowUserList> getkolFollowUser({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
  });

  @POST('/v3/kol/traderProductCode') //交易员的带单币对
  Future getTraderProductCode({
    @Field('traderId') required num traderId,
  });

  @POST('/v3/user/followInfo') //跟单总览
  Future<FollowGeneralInfoModel?> getFollowInfo();

  @POST('/v3/kol/list') //交易员列表（首页）/搜索交易员
  Future<FollowKolListModel> getTraderList({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
    @Field('orderByType') required int orderByType,
    @Field('nickName') required String nickName,
    @Field('kolType') required int kolType, //0, 全部交易员1，热门交易员，2稳健交易员，3万倍交易员
  });

  @POST('/v2/kol/indexConfigList') //探索-首页(每日精选-原石待雕,超过大盘的投资者)
  Future<FollowExploreGridModel> getExploreTraderList({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
    @Field('orderByType') required int orderByType,
    @Field('nickName') required String nickName,
  });

  @POST('/v2/kol/leaderboardTop') //探索-首页排行榜
  Future<FollowExploreGridModel> getleaderboardTop();

  @POST('/v2/kol/pageTraderOpenPreference') //探索-交易员开仓偏好
  Future<FollowExploreGridModel?> getTraderOpenPreference({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
    @Field('type') required int type,
    @Field('collation') required int collation,
  });

  @POST('/v2/kol/commentTraderList') //探索-交易员开仓偏好
  Future<FollowExploreGridModel> getCommentTraderList({
    @Field('traderUid') required num traderUid,
  });

  @POST('/v2/kol/traderOpenPreference') //探索-交易员开仓偏好
  Future<List<FollowKolInfo>> getTraderOpenPreferenceNoPage({
    @Field('type') required int type,
  });

  @POST('/v2/kol/addRating') //评论交易员
  @Extra({showLoading: true})
  Future postAddRating({
    @Field('reviewer') required num reviewer,
    @Field('reviewedTrader') required num reviewedTrader,
    @Field('rating') required num rating,
    @Field('valueType') required num? valueType,
    @Field('comment') required String comment,
  });

  @POST('/v2/kol/top2Rating') //交易员评论（进入交易员页面评论）
  Future<FollowComment> getTop2Rating({
    @Field('traderUid') required num traderUid,
  });

  @POST('/v2/kol/ratingPage') //交易员评论分页
  Future<FollowComment> getRatingPage({
    @Field('pageSize') required num pageSize,
    @Field('traderUid') required num traderUid,
    @Field('page') required num page,
  });

  @POST('/common/translate') //翻译
  Future<FollowTransLateModel> translate({
    @Field('content') required String content,
  });

  @POST('/v3/kol/historyCopyOrder') //交易员的历史带单
  Future<FollowHistoryOrderModel> getHistoryCopyOrder({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
    @Field('uid') required num uid,
  });
  @POST('/v3/kol/getTradePosition') //交易员当前带单
  Future<FollowTradePositionModel> getTradePosition({
    @Field('traderId') required num traderId,
  });
  @POST('/v3/kol/specialFollow') //智能跟单
  @Extra({showLoading: true})
  Future getSpecialFollow({@Field('traderId') required num traderId, @Field('amount') required num amount});

  @POST('/v3/user/myTrader') //我的交易员
  Future<FollowMyTraderModel> getMyTrader({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
    @Field('type') required int type,
  });

  @POST('/v3/user/followOrder') //跟随者当前跟单/跟随者历史跟单
  Future<FollowUserFollowOrderModel> getFollowOrder({
    @Field('pageNo') required int pageNo,
    @Field('pageSize') required int pageSize,
    @Field('type') required int type,
  });
  @POST('/v3/kol/traderInfo') //交易员总览
  Future<FollowKolTraderInfoModel?> getTraderInfo({
    @Field('traderId') required num traderId,
  });

  @POST('/v3/kol/getRato') //获取交易员分润比例
  Future<FollowKolRateModel> getRate({
    @Field('kolUid') required num kolUid,
  });

  @POST('/v3/kol/myFollowManageList') //带单管理-我的跟随者
  Future<FollowMyManageListModel> getMyFollowManageList({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
    @Field('listType') required int listType,
    @Field('traderId') required num traderId,
  });

  @POST('/v3/kol/getMyCopyTraderAccount') //获取跟单账户余额
  Future<FollowTraderAccountModel> getMyCopyTraderAccount();

  @POST('/v3/kol/updateRato') //设置分润比例
  Future postUpdateRato({
    @Field('rate') required num rate, //0：所有不可见，2：跟单可见，2，全部可见
  });
  @POST('/v3/kol/updateAgentProfitRatio') //设置分润比例
  Future postUpdateAgentProfitRatio({
    @Field('rate') required num rate, //0：所有不可见，2：跟单可见，2，全部可见
  });

  @POST('/v3/kol/copySetting') //抢单展示设置
  Future copySetting({
    @Field('copySetting') required int copySetting, //0全部不可见，1，跟单用户可见2，全部可见
  });

  @POST('/v3/kol/updateHisSetting') //历史设置
  Future updateHisSetting({
    @Field('copySetting') required int copySetting, //0全部不可见，1，跟单用户可见2，全部可见
  });

  @POST('/v3/kol/updateFollowSetting') //跟随者设置
  Future updateFollowSetting({
    @Field('copySetting') required int copySetting, //0全部不可见，1，跟单用户可见2，全部可见
  });

  @POST('/v3/kol/getCopySetting') //抢单展示查询
  Future<FollowKolSettingModel> getCopySetting({
    @Field('kolUid') required int kolUid, //0全部不可见，1，跟单用户可见2，全部可见
  });

  @POST('/v3/kol/isTraceUserRelation') //带单管理-查询标星/禁用，拉黑
  Future<FollowkolIsTraceModel> getIsTraceUserRelation({
    @Field('userId') required int userId,
    @Field('types') required int types,
  });

  @POST('/v3/kol/setTraceUserRelation') //带单管理-设置/取消 标星交易员,拉黑，禁用
  Future setTraceUserRelation({
    @Field('userId') required int userId,
    @Field('status') required int status,
    @Field('types') required int types,
  });

  @POST('/v3/kol/myTraceUserRelation') //带单管理-查询列表-标星/禁用/拉黑
  Future<FollowkolRelationListModel> getMyRelationList({
    @Field('pageNo') required int pageNo,
    @Field('pageSize') required int pageSize,
    @Field('types') required int types,
  });
  @POST('/v3/kol/followSettList') //我的分润-历史分润
  Future<FollowkolSetListModel> getFollowSettList({
    @Field('page') required int pageNo,
    @Field('pageSize') required int pageSize,
  });
  @POST('/v3/kol/followProfitList') //我的分润-预计待分润列表
  Future<FollowkolProfitListModel> getFollowProfitList({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
  });

  @POST('/v3/kol/copySwitch') //允许用户跟单设置
  Future copySwitch({
    @Field('copySwitch') required int copySwitch,
  });
  @POST('/v3/kol/getCopySwitch') //交易员-查询跟单设置状态
  Future<FollowkoSwitchModel> getCopySwitch({
    @Field('traderId') required int traderId,
  });
  @POST('/v3/user/followApply') //跟随者-申请跟单
  Future postFollowApply({
    @Field('traderId') required int traderId,
  });
  @POST('/v3/kol/myFollowApply') //交易员-申请跟单-我的申请列表
  Future<FollowkolApplyModel> getMyFollowApply({
    @Field('traderId') required int traderId,
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
    @Field('orderByType') required int orderByType,
    @Field('nickName') required String nickName,
  });

  @POST('/v3/kol/copyTraderDetail') //交易员-带单表现
  Future<FollowkolTraderDetailModel> copyTraderDetail({
    @Field('traderId') required num traderId,
  });

  @POST('/v3/kol/traceSettingInfo') //跟随者-查询跟单设置
  Future<FollowkolSettingInfoModel> traceSettingInfo({
    @Field('uid') required num uid,
  });

  @POST('/v3/kol/positionSetting') //跟单用户管理-持仓比例设置（批量和单个）
  Future positionSetting({
    @Field('positionRate') required num positionRate,
    @Field('uids') required String uids,
  });

  @POST('/v3/kol/getUserDetailById') //获取跟单用户信息
  Future<FollowkolUserDetailModel> getUserDetailById({
    @Field('uid') required num uid,
  });
  @POST('/v3/kol/cancelFollow') //跟随者-取消跟单
  @Extra({showLoading: true})
  Future cancelFollow({
    @Field('kolUid') required num kolUid,
  });

  @POST('/v3/kol/cancelDetail') //取消跟单获取信息
  Future<FollowCancelDetail> cancelDetail({
    @Field('kolUid') required num kolUid,
  });

  @POST('/v3/kol/setFollowApply') //交易员操作请求-申请或者拒绝
  Future setFollowApply({
    @Field('userId') required num userId,
    @Field('followStatus') required num followStatus,
  });

  @POST('/v3/kol/myHistoryTrader') //我的历史交易员
  Future<FollowMyTraderModel> myHistoryTrader({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
  });

  @POST('/v3/kol/supperList') //明星交易员列表
  Future<FollowSuperListModel> supperList({
    @Field('page') required int page,
    @Field('pageSize') required int pageSize,
    @Field('orderByType') required int orderByType,
    @Field('nickName') required String nickName,
  });

  @POST('/v3/kol/checkApplyTrader') //获取交易员得评估条件
  Future<FollowCheckTraderModel> checkApplyTrader({
    @Field('traderId') required num traderId,
  });

  @POST('/v3/kol/getApplyStatus') //申请交易员审核状态
  Future applyStatus();

  @POST('/v3/kol/traderApply') //申请交易员
  @Extra({showLoading: true})
  Future traderApply();

  @POST('/v2/user/queryFollowRisk') //查询是否填写风险报告
  Future<FollowRiskQueryModel?> queryFollowRisk(
    @Field('uid') int uid,
  );

  @POST('/v2/kol/addRiskAssessment') //提交风险报告
  Future sumbmitRiskAssessment(
    @Field('basicSupport') num basicSupport, // 基础支持分
    @Field('liquidity') num liquidity, // 流动性分
    @Field('riskTolerance') num riskTolerance, // 风险承受能力分
    @Field('investmentKnowledge') num investmentKnowledge, // 投资经验分 -> 投资知识
    @Field('investmentPreference') num investmentPreference, // 投资偏好
    @Field('totalScore') num totalScore, // 总分
    /*
    "Conservative", "保守型投资者"),
    "Moderate", "稳健型投资者"),
     "Aggressive", "激进型投资者");
     */
    @Field('investorType') String investorType,
  );

  @POST('/v2/kol/pageTraderOpenPreference') // 探索-交易员开仓偏好
  Future<FollowTradePreferenceModel?> flowTradePreference(
    /*
           全部 -1
          高风险高回报 8
          中风险中回报 9
          极低风险低回报 10
          超过大盘   7
          原石待雕  6
          加密货币  0
          股票 1
          外汇  2
          大宗 3
          指数 4
          ETF 5
      */
    @Field('type') int type,
    @Field('page') int page,
    @Field('pageSize') int pageSize,
    /*
        0 综合评分
        1收益率
        2胜率
        3带单天数
        4最多关注着
        5交易次数

       */
    @Field('collation') int? collation,
  );
}
