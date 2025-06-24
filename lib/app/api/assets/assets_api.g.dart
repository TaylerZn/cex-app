// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AssetsApi implements AssetsApi {
  _AssetsApi(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AssetsOverView?> getTotalAccountBalance() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<AssetsOverView>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/finance/features/total_account_balance',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : AssetsOverView.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetsSpots?> getSpotsAccountBalance() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<AssetsSpots>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/finance/v4/account_balance',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : AssetsSpots.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> transfer(
    amount,
    coinSymbol,
    transferType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'amount': amount,
      'coinSymbol': coinSymbol,
      'transferType': transferType,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/app/co_transfer',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> spotsTransfer(
    amount,
    coinSymbol,
    transferType,
  ) async {
    const _extra = <String, dynamic>{'showLoading': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'amount': amount,
      'coinSymbol': coinSymbol,
      'transferType': transferType,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/exchange/account_transfer',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<dynamic> financeOtcTransfer(
    fromAccount,
    toAccount,
    amount,
    coinSymbol,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'fromAccount': fromAccount,
      'toAccount': toAccount,
      'amount': amount,
      'coinSymbol': coinSymbol,
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/finance/otc_transfer',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<AssetsFunds?> getOtcAccountBalance() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>?>(_setStreamType<AssetsFunds>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/finance/v4/otc_account_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : AssetsFunds.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetsCurrency> getCurrencyList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AssetsCurrency>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/finance/symbol_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetsCurrency.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetsChargeAddress?> getChargeAddress(
    symbol,
    mainnet,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'symbol': symbol,
      'mainnet': mainnet,
    };
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<AssetsChargeAddress>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/finance/get_charge_address',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : AssetsChargeAddress.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> symbolsupportnets(mainnet) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'symbol': mainnet};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/finance/symbol_support_nets',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  @override
  Future<AssetsHistoryRecord?> getWalletHistoryList(
    transactionScene,
    coinSymbol,
    pageSize,
    page,
    status,
    startTime,
    endTime,
    account, {
    transferType,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'transactionScene': transactionScene,
      'coinSymbol': coinSymbol,
      'pageSize': pageSize,
      'page': page,
      'status': status,
      'startTime': startTime,
      'endTime': endTime,
      'account': account,
      'transferType': transferType,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<AssetsHistoryRecord>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/record/ex_transfer_list_v4',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : AssetsHistoryRecord.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetsConvertRecord?> getQuickOrderList(
    pageSize,
    page,
    startTime,
    endTime,
    symbol,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'pageSize': pageSize,
      'page': page,
      'startTime': startTime,
      'endTime': endTime,
      'symbol': symbol,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<AssetsConvertRecord>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/quick/order_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : AssetsConvertRecord.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ConvertCreateOrder?> quickCreateOrder(
    base,
    quote, {
    baseAmount,
    quoteAmount,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'base': base,
      'quote': quote,
      'baseAmount': baseAmount,
      'quoteAmount': quoteAmount,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<ConvertCreateOrder>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/quick/create_order',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : ConvertCreateOrder.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ConvertQuickQuoteRate?> getQuickQuote(
    base,
    quote,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'base': base,
      r'quote': quote,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<ConvertQuickQuoteRate>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/quick/quote',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : ConvertQuickQuoteRate.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ConvertCurrenciesModel?> getQuickCurrencies() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<ConvertCurrenciesModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/v1/quick/currencies',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : ConvertCurrenciesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetsCouponCardRecord?> getCouponCardList(status) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'status': status};
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<AssetsCouponCardRecord>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/record/coupon_card_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : AssetsCouponCardRecord.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SpotsTradeHistoryModel?> getSpotsTradeListHistory(
    symbol,
    side,
    pageSize,
    page,
    startTime,
    endTime,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'symbol': symbol,
      'side': side,
      'pageSize': pageSize,
      'page': page,
      'startTime': startTime,
      'endTime': endTime,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<SpotsTradeHistoryModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/trade/new',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data == null
        ? null
        : SpotsTradeHistoryModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetsTransferRecord> getTransferList(
    coinSymbol,
    pageSize,
    page,
  ) async {
    const _extra = <String, dynamic>{'showLoading': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'coinSymbol': coinSymbol,
      'pageSize': pageSize,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetsTransferRecord>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/record/otc_transfer_list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetsTransferRecord.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetsSpotRecord> getSpotList(
    symbol,
    pageSize,
    page,
  ) async {
    const _extra = <String, dynamic>{'showLoading': true};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'symbol': symbol,
      'pageSize': pageSize,
      'page': page,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AssetsSpotRecord>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/order/entrust_history',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetsSpotRecord.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetsWithdrawConfig> getWithdrawConfig(symbol) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'symbol': symbol};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetsWithdrawConfig>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/cost/Getcost',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetsWithdrawConfig.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AssetsWithdrawResult> doWithdraw(
    symbol,
    amount,
    addressId,
    smsAuthCode,
    googleCode,
    emailCode,
    mainnet,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'symbol': symbol,
      'amount': amount,
      'addressId': addressId,
      'smsAuthCode': smsAuthCode,
      'googleCode': googleCode,
      'emailCode': emailCode,
      'mainnet': mainnet,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetsWithdrawResult>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/finance/do_withdraw',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetsWithdrawResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<AssetsKLIneModel>?> assetsSearch(statsTime) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'statsTime': statsTime};
    final _result = await _dio
        .fetch<List<dynamic>>(_setStreamType<List<AssetsKLIneModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/stats/assetsSearch',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data
        ?.map(
            (dynamic i) => AssetsKLIneModel.fromJson(i as Map<String, dynamic>))
        .toList();
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
