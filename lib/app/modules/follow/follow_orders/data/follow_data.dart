import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/follow/follow.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/notice/notice.dart';
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
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_setup_symbol.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_taker_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/model/my_follow_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take/model/my_take_list.dart';
import 'package:nt_app_flutter/app/modules/my/coupons/model/coupons_model.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_log_event_name.dart';
import 'package:nt_app_flutter/app/utils/appsflyer/apps_flyer_manager.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowDataManager {
  static FollowDataManager get instance => _singleton;
  static final FollowDataManager _singleton = FollowDataManager._();
  FollowDataManager._() {
    Bus.getInstance().on(EventType.login, (data) {
      callbackData();
    });
    Bus.getInstance().on(EventType.signOut, (data) {
      callbackData(islogin: false);
    });
    Bus.getInstance().on(EventType.changeLang, (data) {
      _cmsAdvert?.call();
    });

    Bus.getInstance().on(EventType.followAnswerDone, (data) {
      _followAnswer?.call();
    });
  }

  final List<Function(bool)> _changeuserCallback = [];
  Function()? _cmsAdvert;
  Function()? _followAnswer;

  set onchangeuser(Function(bool) f) {
    _changeuserCallback.add(f);
  }

  set onCmsAdvertList(Function() f) {
    _cmsAdvert = f;
  }

  set onFollowAnswer(Function() f) {
    _followAnswer = f;
  }

  callbackData({bool islogin = true, Function(bool)? callback}) {
    if (UserGetx.to.isLogin) {
      var isKol = UserGetx.to.user?.info?.isKol;
      if (isKol != null) {
        if (callback != null) {
          callback.call(isKol);
        } else {
          for (var f in _changeuserCallback) {
            f(isKol);
          }
        }
      } else {
        AFFollow.getIsKol().then((value) {
          UserGetx.to.user?.info?.isKol = value.isKol;

          if (callback != null) {
            callback.call(value.isKol);
          } else {
            for (var f in _changeuserCallback) {
              f(value.isKol);
            }
          }
        });
      }
    } else {
      if (callback != null) {
        callback.call(false);
      } else {
        for (var f in _changeuserCallback) {
          f(false);
        }
      }
    }
  }
}

extension AFFollow on FollowApi {
  ///是否是交易员
  static Future<FollowKol> getIsKol() async {
    try {
      return await FollowApi.instance().getIsKol();
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowKol();
    }
  }

  // //交易员信息
  // static Future<FollowTraderInfo> getKolInfo({
  //   num? uid,
  // }) async {
  //   try {
  //     return await FollowApi.instance().getKolInfo(uid: uid ?? -1);
  //   } on dio.DioException catch (e) {
  //     print(e.error);
  //     return FollowTraderInfo(info: Info());
  //   }
  // }

  // ///交易员列表
  // static Future<FollowListModel> getKolList({int page = 1, int orderByType = 1, int pageSize = 50}) async {
  //   try {
  //     return await FollowApi.instance().getKolList(page: page, orderByType: orderByType, pageSize: pageSize);
  //   } on dio.DioException catch (e) {
  //     print(e.error);
  //     return FollowListModel();
  //   }
  // }

  // ///交易员历史带单
  // static Future<FollowTakerHistoryOrder> getkolHistoryOrder({num? uid, int page = 1, int pageSize = 50}) async {
  //   try {
  //     return await FollowApi.instance().getkolHistoryOrder(uid: uid ?? -1, page: page, pageSize: pageSize);
  //   } on dio.DioException catch (e) {
  //     print(e.error);
  //     return FollowTakerHistoryOrder();
  //   }
  // }

  ///我的跟单信息
  static Future<MyFollowIncomeInfo> getMyFollowUserIncomeInfo() async {
    try {
      return await FollowApi.instance().getMyFollowUserIncomeInfo();
    } on dio.DioException catch (e) {
      print(e.error);
      return MyFollowIncomeInfo();
    }
  }

  ///跟单操作
  static Future postkolFollow({
    num uid = -1,
    num singleAmount = 0,
    String amount = '0',
    String coin = 'USDT',
    num isStopDeficit = 0,
    String stopDeficit = '',
    num isStopProfit = 0,
    String stopProfit = '',
    String symbolRelationStr = "[{\"symbol\":\"BTC/USDT\",\"instrumentId\":2},{\"symbol\":\"ETH/USDT\",\"instrumentId\":3}]",
    num followType = 1,
    num timeType = 0,
  }) async {
    // var str = [
    //   {"symbol": "BTC/USDT", "instrumentId": 2},
    //   {"symbol": "ETH/USDT", "instrumentId": 3},
    //   {"symbol": "BCH/USDT", "instrumentId": 4},
    //   {"symbol": "LTC/USDT", "instrumentId": 5},
    //   {"symbol": "ETC/USDT", "instrumentId": 6},
    //   {"symbol": "DOGE/USDT", "instrumentId": 7}
    // ];
    AppsFlyerManager().logEvent(AFLogEventName.copy_order);

    try {
      return await FollowApi.instance().postkolFollow(
          uid: uid,
          amount: amount,
          coin: coin,
          stopDeficit: stopDeficit,
          isStopDeficit: isStopDeficit,
          stopProfit: stopProfit,
          isStopProfit: isStopProfit,
          symbolRelationStr: '[]',
          followType: followType,
          copyMode: timeType,
          singleAmount: singleAmount);
    } on dio.DioException catch (e) {
      Get.back();
      var error = e.error as String?;
      UIUtil.showError(error?.isNotEmpty == true ? error : LocaleKeys.follow58.tr);
      return {};
    }
  }

  ///跟单用户
  static Future<MyTakefollowUserList> getkolFollowUser({int page = 1, int pageSize = 10}) async {
    try {
      return await FollowApi.instance().getkolFollowUser(page: page, pageSize: pageSize);
    } on dio.DioException catch (e) {
      print(e.error);
      return MyTakefollowUserList();
    }
  }

  ///交易员的带单币对
  static Future getTraderProductCode({num traderId = -1}) async {
    try {
      return await FollowApi.instance().getTraderProductCode(traderId: traderId);
    } on dio.DioException catch (e) {
      print(e.error);
      return [];
    }
  }

  ///跟单总览
  static Future<FollowGeneralInfoModel?> getFollowGeneralInfo({num traderId = -1}) async {
    try {
      return await FollowApi.instance().getFollowInfo();
    } on dio.DioException catch (e) {
      print(e.error);
      return null;
    }
  }

  ///交易员列表（首页）/搜索交易员 1,收益额排序，2收益率排序，3胜率排序，4跟单人数
  static Future<FollowKolListModel> getTraderList(
      {int page = 1, int pageSize = 10, int orderByType = 0, String nickNam = '', int kolType = 0}) async {
    try {
      return await FollowApi.instance()
          .getTraderList(page: page, pageSize: pageSize, orderByType: orderByType, nickName: nickNam, kolType: kolType)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowKolListModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///交易员列表（首页）/搜索交易员 1,收益额排序，2收益率排序，3胜率排序，4跟单人数
  static Future<FollowExploreGridModel> getExploreTraderList(
      {int page = 1, int pageSize = 10, int orderByType = 0, String nickNam = ''}) async {
    try {
      return await FollowApi.instance()
          .getExploreTraderList(page: page, pageSize: pageSize, orderByType: orderByType, nickName: nickNam)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowExploreGridModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///交易员列表（首页）/搜索交易员 1,收益额排序，2收益率排序，3胜率排序，4跟单人数
  static Future<FollowExploreGridModel> getleaderboardTop(
      {int page = 1, int pageSize = 10, int orderByType = 0, String nickNam = ''}) async {
    try {
      return await FollowApi.instance().getleaderboardTop()
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowExploreGridModel()
        ..isError = true
        ..exception = e;
    }
  }

  static Future<FollowExploreGridModel?> getTraderOpenPreference(
      {int page = 1, int pageSize = 10, int type = 0, int collation = 0}) async {
    try {
      var model =
          await FollowApi.instance().getTraderOpenPreference(page: page, pageSize: pageSize, type: type, collation: collation);
      if (model != null) {
        return model..isError = false;
      } else {
        return FollowExploreGridModel()..isError = false;
      }
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowExploreGridModel()
        ..isError = true
        ..exception = e;
    }
  }

  static Future<FollowExploreGridModel> getCommentTraderList(num? traderUid) async {
    try {
      return await FollowApi.instance().getCommentTraderList(traderUid: traderUid ?? -1)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowExploreGridModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///我的交易员
  static Future<FollowMyTraderModel> getMyTrader({int page = 1, int pageSize = 10, int type = 1}) async {
    try {
      return await FollowApi.instance().getMyTrader(page: page, pageSize: pageSize, type: type)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowMyTraderModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///交易员的历史带单
  static Future<FollowHistoryOrderModel> getHistoryCopyOrder({int page = 1, int pageSize = 10, num? uid = 0}) async {
    try {
      return await FollowApi.instance().getHistoryCopyOrder(page: page, pageSize: pageSize, uid: uid ?? 0)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowHistoryOrderModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///交易员当前带单
  static Future<FollowTradePositionModel> getTradePosition({int page = 1, int pageSize = 10, num traderId = 0}) async {
    try {
      return await FollowApi.instance().getTradePosition(traderId: traderId)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowTradePositionModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///智能跟单
  static Future getSpecialFollow({num traderId = 0, num amount = 0}) async {
    AppsFlyerManager().logEvent(AFLogEventName.copy_intelligent_order);

    try {
      return await FollowApi.instance().getSpecialFollow(traderId: traderId, amount: amount);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  ///跟随者当前跟单/跟随者历史跟单
  static Future<FollowUserFollowOrderModel> getFollowOrder({int pageNo = 1, int pageSize = 10, int type = 0}) async {
    try {
      return await FollowApi.instance().getFollowOrder(pageNo: pageNo, pageSize: pageSize, type: type)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowUserFollowOrderModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///交易员总览
  static Future<FollowKolTraderInfoModel?> getTraderInfo({num? traderId}) async {
    try {
      var uid = traderId ?? (UserGetx.to.uid ?? 0);
      return await FollowApi.instance().getTraderInfo(traderId: uid);
    } on dio.DioException catch (e) {
      print(e.error);
      return null;
    }
  }

  ///获取交易员分润比例
  static Future<FollowKolRateModel> getRate({num kolUid = -1}) async {
    try {
      return await FollowApi.instance().getRate(kolUid: kolUid);
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowKolRateModel();
    }
  }

  ///带单管理-跟单用户管理列表
  static Future<FollowMyManageListModel> getMyFollowManageList(
      {int page = 1, int pageSize = 10, int listType = 0, num traderId = -1}) async {
    try {
      return await FollowApi.instance()
          .getMyFollowManageList(page: page, pageSize: pageSize, listType: listType, traderId: traderId)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowMyManageListModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///获取跟单账户余额
  static Future<FollowTraderAccountModel> getMyCopyTraderAccount() async {
    try {
      return await FollowApi.instance().getMyCopyTraderAccount();
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowTraderAccountModel();
    }
  }

  ///设置分润比例
  static Future postUpdateRato({num rate = 1}) async {
    try {
      return await FollowApi.instance().postUpdateRato(rate: rate);
    } on dio.DioException catch (e) {
      print('${e.message}');
      return {};
    }
  }

  ///设置代理分润比例
  static Future postUpdateAgentProfitRatio({num rate = 1}) async {
    try {
      return await FollowApi.instance().postUpdateAgentProfitRatio(rate: rate);
    } on dio.DioException catch (e) {
      print('${e.message}');
      return {};
    }
  }

  ///抢单展示设置  0全部不可见，1，跟单用户可见2，全部可见
  static Future copySetting({int copySetting = 1}) async {
    try {
      return await FollowApi.instance().copySetting(copySetting: copySetting);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  ///抢单展示设置  0全部不可见，1，跟单用户可见2，全部可见
  static Future updateHisSetting({int copySetting = 1}) async {
    try {
      return await FollowApi.instance().updateHisSetting(copySetting: copySetting);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  ///抢单展示设置  0全部不可见，1，跟单用户可见2，全部可见
  static Future updateFollowSetting({int copySetting = 1}) async {
    try {
      return await FollowApi.instance().updateFollowSetting(copySetting: copySetting);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  ///抢单展示设置  0全部不可见，1，跟单用户可见2，全部可见
  static Future<FollowKolSettingModel> getCopySetting({int kolUid = 0}) async {
    try {
      return await FollowApi.instance().getCopySetting(kolUid: kolUid);
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowKolSettingModel();
    }
  }

  ///带单管理-查询标星/禁用，拉黑
  static Future<FollowkolIsTraceModel> getIsTraceUserRelation({int userId = 1, int types = 0}) async {
    try {
      return await FollowApi.instance().getIsTraceUserRelation(userId: userId, types: types);
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowkolIsTraceModel();
    }
  }

  ///带单管理-设置/取消 标星交易员,拉黑，禁用
  static Future setTraceUserRelation({num userId = 1, int status = 0, int types = 0}) async {
    try {
      return await FollowApi.instance().setTraceUserRelation(userId: userId.toInt(), status: status, types: types);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  ///带单管理-查询列表-标星/禁用/拉黑
  static Future<FollowkolRelationListModel> getMyRelationList({int pageNo = 1, int pageSize = 0, int types = 0}) async {
    try {
      return await FollowApi.instance().getMyRelationList(pageNo: pageNo, pageSize: pageSize, types: types)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowkolRelationListModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///我的分润-历史分润
  static Future<FollowkolSetListModel> getFollowSettList({int pageNo = 1, int pageSize = 0}) async {
    try {
      return await FollowApi.instance().getFollowSettList(pageNo: pageNo, pageSize: pageSize)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowkolSetListModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///我的分润-预计待分润列表
  static Future<FollowkolProfitListModel> getFollowProfitList({int page = 1, int pageSize = 0}) async {
    try {
      return await FollowApi.instance().getFollowProfitList(page: page, pageSize: pageSize)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowkolProfitListModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///用户跟单设置
  static Future copySwitch({int copySwitch = 1}) async {
    try {
      return await FollowApi.instance().copySwitch(copySwitch: copySwitch);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  ///查询用户跟单设置
  static Future<FollowkoSwitchModel> getCopySwitch({int traderId = 1}) async {
    try {
      return await FollowApi.instance().getCopySwitch(traderId: traderId);
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowkoSwitchModel();
    }
  }

  ///跟随者-申请跟单
  static Future postFollowApply({num traderId = 1}) async {
    try {
      return await FollowApi.instance().postFollowApply(traderId: traderId.toInt());
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  ///交易员-申请跟单-我的申请列表
  static Future<FollowkolApplyModel> getMyFollowApply(
      {int page = 1, int pageSize = 10, int orderByType = 0, String nickNam = '', int traderId = 0}) async {
    try {
      return await FollowApi.instance()
          .getMyFollowApply(page: page, pageSize: pageSize, orderByType: orderByType, nickName: nickNam, traderId: traderId)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowkolApplyModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///交易员-带单表现
  static Future<FollowkolTraderDetailModel> copyTraderDetail({num traderId = 0}) async {
    try {
      return await FollowApi.instance().copyTraderDetail(traderId: traderId)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowkolTraderDetailModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///跟随者-查询跟单设置
  static Future<FollowkolSettingInfoModel> traceSettingInfo({num uid = 0}) async {
    try {
      return await FollowApi.instance().traceSettingInfo(uid: uid)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowkolSettingInfoModel()
        ..isError = true
        ..exception = e;
    }
  }

  ///取消跟单获取信息
  static Future<FollowCancelDetail> cancelDetail({num uid = 0}) async {
    try {
      return await FollowApi.instance().cancelDetail(kolUid: uid);
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowCancelDetail();
    }
  }

  ///取消跟单
  static Future cancelFollow({num uid = 0}) async {
    try {
      return await FollowApi.instance().cancelFollow(kolUid: uid);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  //跟单用户管理-持仓比例设置（批量和单个）
  static Future positionSetting({required String uids, required num positionRate}) async {
    try {
      return await FollowApi.instance().positionSetting(uids: uids, positionRate: positionRate);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  //交易员操作请求-申请或者拒绝
  static Future setFollowApply({required num userId, required int followStatus}) async {
    try {
      return await FollowApi.instance().setFollowApply(userId: userId, followStatus: followStatus);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  //获取带单币对
  static Future<FollowSetupSymbol> symbolInfo({required num uid}) async {
    try {
      return await FollowApi.instance().symbolInfo(uid: uid);
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowSetupSymbol();
    }
  }

  //获取跟单用户信息
  static Future<FollowkolUserDetailModel> getUserDetailById({required num uid}) async {
    try {
      return await FollowApi.instance().getUserDetailById(uid: uid);
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowkolUserDetailModel();
    }
  }

  //我的历史交易员
  static Future<FollowMyTraderModel> getMyHistoryTrader({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      return await FollowApi.instance().myHistoryTrader(page: page, pageSize: pageSize)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowMyTraderModel()
        ..isError = true
        ..exception = e;
    }
  }

  //明星交易员列表
  static Future<FollowSuperListModel> supperList(
      {int page = 1, int pageSize = 10, int orderByType = 0, String nickNam = ''}) async {
    try {
      return await FollowApi.instance().supperList(page: page, pageSize: pageSize, orderByType: orderByType, nickName: nickNam);
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowSuperListModel();
    }
  }

  //获取交易员得评估条件
  static Future<FollowCheckTraderModel> checkApplyTrader({num traderId = -1}) async {
    try {
      return await FollowApi.instance().checkApplyTrader(traderId: traderId);
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowCheckTraderModel();
    }
  }

  //申请交易员审核状态
  static Future applyStatus() async {
    try {
      return await FollowApi.instance().applyStatus();
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  ///申请交易员
  static Future traderApply() async {
    try {
      return await FollowApi.instance().traderApply();
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

  static Future<CouponsListModel> getCouponCardList(num status) async {
    try {
      return await PublicApi.instance().getCouponCardList(status)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return CouponsListModel()..isError = true;
    }
  }

  static Future<FollowRiskQueryModel?> queryFollowRisk({num? uid}) async {
    try {
      int userId = uid != null ? uid.toInt() : UserGetx.to.uid ?? 0;
      return await FollowApi.instance().queryFollowRisk(userId);
    } on dio.DioException catch (e) {
      print(e.error);
      return null;
    }
  }

  static Future<NoticeModel?> getNoticeList() async {
    try {
      return await PublicApi.instance().getNoticeInfoList(page: 1, pageSize: 1, type: 1, position: 2);
    } on dio.DioException catch (e) {
      print(e.error);
      return null;
    }
  }

  //评论交易员
  static Future postAddRating(
      {num reviewer = 0, num reviewedTrader = 0, num rating = 0, num? sortValue, String comment = ''}) async {
    try {
      return await FollowApi.instance().postAddRating(
          reviewer: reviewer, reviewedTrader: reviewedTrader, rating: rating, valueType: sortValue, comment: comment);
    } on dio.DioException catch (e) {
      print(e.error);
      return {};
    }
  }

//交易员评论（进入交易员页面评论）
  static Future<FollowComment> getTop2Rating({num traderUid = 1}) async {
    try {
      return await FollowApi.instance().getTop2Rating(traderUid: traderUid)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowComment()
        ..isError = true
        ..exception = e;
    }
  }

//交易员评论分页
  static Future<FollowComment> getRatingPage({
    num traderUid = 1,
    num page = 1,
    num pageSize = 10,
  }) async {
    try {
      return await FollowApi.instance().getRatingPage(traderUid: traderUid, page: page, pageSize: pageSize)
        ..isError = false;
    } on dio.DioException catch (e) {
      print(e.error);
      return FollowComment()
        ..isError = true
        ..exception = e;
    }
  }

  static Future<FollowTransLateModel> translate({String content = ''}) async {
    try {
      return await FollowApi.instance().translate(content: content);
    } on dio.DioException catch (e) {
      return FollowTransLateModel();
    }
  }

  static Future getReceiveExpCoupon(String? cardSn) async {
    try {
      return await PublicApi.instance().getReceiveExpCoupon(cardSn ?? '');
    } on dio.DioException catch (e) {
      print(e.error);

      return null;
    }
  }
}
