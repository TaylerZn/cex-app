// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _CommodityApi implements CommodityApi {
  _CommodityApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CommodityPublicInfo> getPublicInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommodityPublicInfo>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/public_info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommodityPublicInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OptionRecommendContractId> getContractOptionalList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OptionRecommendContractId>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/contract_optional_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OptionRecommendContractId.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> setContractOptionalList(contractOptionalList) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'contractOptionalList': contractOptionalList};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/contract_optional_set',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<UserConfigInfo> getUserConfig(contractId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'contractId': contractId};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UserConfigInfo>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/get_user_config',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserConfigInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> levelEdit(
    nowLevel,
    contractId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'nowLevel': nowLevel,
      'contractId': contractId,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/level_edit',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<OrderRes> currentOrderList(
    limit,
    page,
    contractId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'limit': limit,
      'page': page,
      'contractId': contractId,
    };
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<OrderRes>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/order/current_order_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderRes> triggerOrderList(
    limit,
    page,
    contractId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'limit': limit,
      'page': page,
      'contractId': contractId,
    };
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<OrderRes>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/order/trigger_order_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PositionRes> getAssetsList(
    onlyAccount,
    marginCoin,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'onlyAccount': onlyAccount,
      'marginCoin': marginCoin,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PositionRes>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/position/get_assets_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PositionRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CreateOrderRes> createOrder(req) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(req.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CreateOrderRes>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/order/order_create',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateOrderRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> cancelOrder(
    orderId,
    isConditionOrder,
    contractId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'orderId': orderId,
      'isConditionOrder': isConditionOrder,
      'contractId': contractId,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/order/order_cancel',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> cancelAllOrder() async {
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
          '/order/cancel_all',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<FundingRate> getMarketInfo(
    symbol,
    contractId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'symbol': symbol,
      'contractId': contractId,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<FundingRate>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/public_market_info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FundingRate.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TransactionHistoryEntrust> historyOrderList(
    limit,
    page,
    contractId,
    type,
    status,
    beginTime,
    endTime,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'limit': limit,
      'page': page,
      'contractId': contractId,
      'type': type,
      'status': status,
      'beginTime': beginTime,
      'endTime': endTime,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TransactionHistoryEntrust>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/order/history_order_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TransactionHistoryEntrust.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TransactionHistoryEntrust> historyTriggerOrderList(
    limit,
    page,
    contractId,
    type,
    status,
    beginTime,
    endTime,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'limit': limit,
      'page': page,
      'contractId': contractId,
      'type': type,
      'status': status,
      'beginTime': beginTime,
      'endTime': endTime,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TransactionHistoryEntrust>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/order/history_trigger_order_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TransactionHistoryEntrust.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TransactionHistoricalTrans> hisTradeList(
    limit,
    page,
    contractId,
    beginTime,
    endTime,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'limit': limit,
      'page': page,
      'contractId': contractId,
      'beginTime': beginTime,
      'endTime': endTime,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TransactionHistoricalTrans>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/order/his_trade_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TransactionHistoricalTrans.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TransactionFlowFunds> flowFundsList(
    limit,
    page,
    symbol,
    type,
    beginTime,
    endTime,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'limit': limit,
      'page': page,
      'symbol': symbol,
      'type': type,
      'beginTime': beginTime,
      'endTime': endTime,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TransactionFlowFunds>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/record/get_transaction_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TransactionFlowFunds.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SymbolRateListRes> getSymbolRateList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SymbolRateListRes>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/symbol_rate_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SymbolRateListRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DepthMap> getDepthMap(contractId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'contractId': contractId};
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<DepthMap>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/depth_map',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DepthMap.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> createCoId(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/create_co_id',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> closeAllPosition(contractId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {'contractId': contractId};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/order/close_all_position',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> marginModelEdit(
    contractId,
    marginModel,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'contractId': contractId,
      'marginModel': marginModel,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/margin_model_edit',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<CommodityOpenTime> getContractOpenTime(contractId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'contractId': contractId};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CommodityOpenTime>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/get_contract_open_time',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommodityOpenTime.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommodityOpenStatus> getContractOpenStatus(contractId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'contractId': contractId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommodityOpenStatus>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/get_contract_open_status',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommodityOpenStatus.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderRes> findCoOrder(
    pageNum,
    pageSize,
    contractId,
    status, [
    beginTime,
    endTime,
    type,
    sortType = 'CREATE_TIME',
  ]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'pageNum': pageNum,
      'pageSize': pageSize,
      'contractId': contractId,
      'status': status,
      'createTimeStart': beginTime,
      'createTimeEnd': endTime,
      'type': type,
      'sortType': sortType,
    };
    _data.removeWhere((k, v) => v == null);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<OrderRes>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/order/find_co_order',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderRes> findTriggerOrder(
    pageNum,
    pageSize,
    contractId,
    status, [
    beginTime,
    endTime,
    sortType = 'CREATE_TIME',
  ]) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'pageNum': pageNum,
      'pageSize': pageSize,
      'contractId': contractId,
      'status': status,
      'createTimeStart': beginTime,
      'createTimeEnd': endTime,
      'sortType': sortType,
    };
    _data.removeWhere((k, v) => v == null);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<OrderRes>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/order/find_trigger_order',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CapitalListInfo> fundingRateList(
    contractId,
    limit,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'contractId': contractId,
      'limit': limit,
      'page': page,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CapitalListInfo>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/funding_rate_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CapitalListInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getPriceList() async {
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
          '/common/price_list',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<ChangePositionAmountInfo> queryChangePositionAmount(
    positionId,
    amount,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'positionId': positionId,
      'amount': amount,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChangePositionAmountInfo>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/position/query_change_position_amount',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChangePositionAmountInfo.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> changePositionMargin(
    positionId,
    amount,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'positionId': positionId,
      'amount': amount,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/position/change_position_margin',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<ContractLeverage> getLadderInfo(contractId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'contractId': contractId};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ContractLeverage>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/common/get_ladder_info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ContractLeverage.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getCoinMarketInfo(
    coinSymbol,
    kind,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'kind': kind};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/common/coin_market_info/${coinSymbol}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
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
