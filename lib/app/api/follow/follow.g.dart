// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _FollowApi implements FollowApi {
  _FollowApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<FollowKol> getIsKol() async {
    const _extra = <String, dynamic>{'showLoading': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FollowKol>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/user/isKol',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowKol.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowSetupSymbol> symbolInfo({required uid}) async {
    const _extra = <String, dynamic>{'showLoading': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'uid': uid};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FollowSetupSymbol>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/symbol_info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowSetupSymbol.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MyFollowIncomeInfo> getMyFollowUserIncomeInfo() async {
    const _extra = <String, dynamic>{'showLoading': false};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MyFollowIncomeInfo>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/user/income_info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyFollowIncomeInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> postkolFollow({
    required uid,
    required amount,
    required coin,
    required isStopDeficit,
    required stopDeficit,
    required isStopProfit,
    required stopProfit,
    required symbolRelationStr,
    required followType,
    required copyMode,
    required singleAmount,
  }) async {
    const _extra = <String, dynamic>{'showLoading': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'uid': uid,
      'amount': amount,
      'coin': coin,
      'isStopDeficit': isStopDeficit,
      'stopDeficit': stopDeficit,
      'isStopProfit': isStopProfit,
      'stopProfit': stopProfit,
      'symbolRelationStr': symbolRelationStr,
      'followType': followType,
      'copyMode': copyMode,
      'singleAmount': singleAmount,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/follow',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<MyTakefollowUserList> getkolFollowUser({
    required page,
    required pageSize,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MyTakefollowUserList>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/follow_users',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyTakefollowUserList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getTraderProductCode({required traderId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'traderId': traderId};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/traderProductCode',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowGeneralInfoModel?> getFollowInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<FollowGeneralInfoModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/user/followInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : FollowGeneralInfoModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowKolListModel> getTraderList({
    required page,
    required pageSize,
    required orderByType,
    required nickName,
    required kolType,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
      'orderByType': orderByType,
      'nickName': nickName,
      'kolType': kolType,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FollowKolListModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowKolListModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowExploreGridModel> getExploreTraderList({
    required page,
    required pageSize,
    required orderByType,
    required nickName,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
      'orderByType': orderByType,
      'nickName': nickName,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowExploreGridModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/indexConfigList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowExploreGridModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowExploreGridModel> getleaderboardTop() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowExploreGridModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/leaderboardTop',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowExploreGridModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowExploreGridModel?> getTraderOpenPreference({
    required page,
    required pageSize,
    required type,
    required collation,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
      'type': type,
      'collation': collation,
    };
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<FollowExploreGridModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/pageTraderOpenPreference',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : FollowExploreGridModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowExploreGridModel> getCommentTraderList(
      {required traderUid}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'traderUid': traderUid};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowExploreGridModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/commentTraderList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowExploreGridModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<FollowKolInfo>> getTraderOpenPreferenceNoPage(
      {required type}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'type': type};
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<FollowKolInfo>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/traderOpenPreference',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => FollowKolInfo.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<dynamic> postAddRating({
    required reviewer,
    required reviewedTrader,
    required rating,
    valueType,
    required comment,
  }) async {
    const _extra = <String, dynamic>{'showLoading': true};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'reviewer': reviewer,
      'reviewedTrader': reviewedTrader,
      'rating': rating,
      'valueType': valueType,
      'comment': comment,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v2/kol/addRating',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowComment> getTop2Rating({required traderUid}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'traderUid': traderUid};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FollowComment>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/top2Rating',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowComment.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowComment> getRatingPage({
    required pageSize,
    required traderUid,
    required page,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'pageSize': pageSize,
      'traderUid': traderUid,
      'page': page,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FollowComment>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/ratingPage',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowComment.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowTransLateModel> translate({required content}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'content': content};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowTransLateModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/translate',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowTransLateModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowHistoryOrderModel> getHistoryCopyOrder({
    required page,
    required pageSize,
    required uid,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
      'uid': uid,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowHistoryOrderModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/historyCopyOrder',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowHistoryOrderModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowTradePositionModel> getTradePosition({required traderId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'traderId': traderId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowTradePositionModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/getTradePosition',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowTradePositionModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getSpecialFollow({
    required traderId,
    required amount,
  }) async {
    const _extra = <String, dynamic>{'showLoading': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'traderId': traderId,
      'amount': amount,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/specialFollow',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowMyTraderModel> getMyTrader({
    required page,
    required pageSize,
    required type,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowMyTraderModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/user/myTrader',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowMyTraderModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowUserFollowOrderModel> getFollowOrder({
    required pageNo,
    required pageSize,
    required type,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'pageNo': pageNo,
      'pageSize': pageSize,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowUserFollowOrderModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/user/followOrder',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowUserFollowOrderModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowKolTraderInfoModel?> getTraderInfo({required traderId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'traderId': traderId};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<FollowKolTraderInfoModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/traderInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : FollowKolTraderInfoModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowKolRateModel> getRate({required kolUid}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'kolUid': kolUid};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FollowKolRateModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/getRato',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowKolRateModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowMyManageListModel> getMyFollowManageList({
    required page,
    required pageSize,
    required listType,
    required traderId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
      'listType': listType,
      'traderId': traderId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowMyManageListModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/myFollowManageList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowMyManageListModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowTraderAccountModel> getMyCopyTraderAccount() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowTraderAccountModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/getMyCopyTraderAccount',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowTraderAccountModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> postUpdateRato({required rate}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'rate': rate};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/updateRato',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> postUpdateAgentProfitRatio({required rate}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'rate': rate};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/updateAgentProfitRatio',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> copySetting({required copySetting}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'copySetting': copySetting};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/copySetting',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> updateHisSetting({required copySetting}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'copySetting': copySetting};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/updateHisSetting',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> updateFollowSetting({required copySetting}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'copySetting': copySetting};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/updateFollowSetting',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowKolSettingModel> getCopySetting({required kolUid}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'kolUid': kolUid};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowKolSettingModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/getCopySetting',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowKolSettingModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowkolIsTraceModel> getIsTraceUserRelation({
    required userId,
    required types,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'userId': userId,
      'types': types,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowkolIsTraceModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/isTraceUserRelation',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowkolIsTraceModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> setTraceUserRelation({
    required userId,
    required status,
    required types,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'userId': userId,
      'status': status,
      'types': types,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/setTraceUserRelation',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowkolRelationListModel> getMyRelationList({
    required pageNo,
    required pageSize,
    required types,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'pageNo': pageNo,
      'pageSize': pageSize,
      'types': types,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowkolRelationListModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/myTraceUserRelation',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowkolRelationListModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowkolSetListModel> getFollowSettList({
    required pageNo,
    required pageSize,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': pageNo,
      'pageSize': pageSize,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowkolSetListModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/followSettList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowkolSetListModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowkolProfitListModel> getFollowProfitList({
    required page,
    required pageSize,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowkolProfitListModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/followProfitList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowkolProfitListModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> copySwitch({required copySwitch}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'copySwitch': copySwitch};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/copySwitch',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowkoSwitchModel> getCopySwitch({required traderId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'traderId': traderId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowkoSwitchModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/getCopySwitch',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowkoSwitchModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> postFollowApply({required traderId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'traderId': traderId};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/user/followApply',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowkolApplyModel> getMyFollowApply({
    required traderId,
    required page,
    required pageSize,
    required orderByType,
    required nickName,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'traderId': traderId,
      'page': page,
      'pageSize': pageSize,
      'orderByType': orderByType,
      'nickName': nickName,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowkolApplyModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/myFollowApply',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowkolApplyModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowkolTraderDetailModel> copyTraderDetail(
      {required traderId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'traderId': traderId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowkolTraderDetailModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/copyTraderDetail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowkolTraderDetailModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowkolSettingInfoModel> traceSettingInfo({required uid}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'uid': uid};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowkolSettingInfoModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/traceSettingInfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowkolSettingInfoModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> positionSetting({
    required positionRate,
    required uids,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'positionRate': positionRate,
      'uids': uids,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/positionSetting',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowkolUserDetailModel> getUserDetailById({required uid}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'uid': uid};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowkolUserDetailModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/getUserDetailById',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowkolUserDetailModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> cancelFollow({required kolUid}) async {
    const _extra = <String, dynamic>{'showLoading': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'kolUid': kolUid};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/cancelFollow',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowCancelDetail> cancelDetail({required kolUid}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'kolUid': kolUid};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FollowCancelDetail>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/cancelDetail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowCancelDetail.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> setFollowApply({
    required userId,
    required followStatus,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'userId': userId,
      'followStatus': followStatus,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/setFollowApply',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowMyTraderModel> myHistoryTrader({
    required page,
    required pageSize,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowMyTraderModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/myHistoryTrader',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowMyTraderModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowSuperListModel> supperList({
    required page,
    required pageSize,
    required orderByType,
    required nickName,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'page': page,
      'pageSize': pageSize,
      'orderByType': orderByType,
      'nickName': nickName,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowSuperListModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/supperList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowSuperListModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FollowCheckTraderModel> checkApplyTrader({required traderId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'traderId': traderId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FollowCheckTraderModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v3/kol/checkApplyTrader',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FollowCheckTraderModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> applyStatus() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/getApplyStatus',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> traderApply() async {
    const _extra = <String, dynamic>{'showLoading': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v3/kol/traderApply',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowRiskQueryModel?> queryFollowRisk(uid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'uid': uid};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<FollowRiskQueryModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/user/queryFollowRisk',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : FollowRiskQueryModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> sumbmitRiskAssessment(
    basicSupport,
    liquidity,
    riskTolerance,
    investmentKnowledge,
    investmentPreference,
    totalScore,
    investorType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'basicSupport': basicSupport,
      'liquidity': liquidity,
      'riskTolerance': riskTolerance,
      'investmentKnowledge': investmentKnowledge,
      'investmentPreference': investmentPreference,
      'totalScore': totalScore,
      'investorType': investorType,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/v2/kol/addRiskAssessment',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FollowTradePreferenceModel?> flowTradePreference(
    type,
    page,
    pageSize,
    collation,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'type': type,
      'page': page,
      'pageSize': pageSize,
      'collation': collation,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<FollowTradePreferenceModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v2/kol/pageTraderOpenPreference',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : FollowTradePreferenceModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
