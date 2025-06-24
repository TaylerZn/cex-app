import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/app/ws/standard_future_socket_manager.dart';
import 'package:nt_app_flutter/app/ws/standard_socket_manager.dart';

import '../../models/contract/res/price_info.dart';
import '../../network/best_api/best_api.dart';
import '../../ws/future_socket_manager.dart';

class CommodityDataStoreController extends GetxController {
  static CommodityDataStoreController get to => Get.find();

  CommodityPublicInfo? _publicInfo;

  CommodityPublicInfo? get publicInfo => _publicInfo;

  final LinkedHashMap<String, ContractInfo> _contractSymbolHashMap =
      LinkedHashMap();
  LinkedHashMap<String, ContractInfo> get contractSymbolHashMap =>
      _contractSymbolHashMap;

  final LinkedHashMap<num, ContractInfo> _contractIdHashMap = LinkedHashMap();
  final LinkedHashMap<String, ContractInfo> _contractNameHashMap = LinkedHashMap();

  Timer? _timer;

  /// 合约价格
  Map<String, PriceInfo> priceMap = {};

  /// 合约列表
  List<ContractGroupList> _contractGroupList = [];
  List<ContractGroupList> get contractGroupList => _contractGroupList;

  @override
  void onInit() {
    super.onInit();
    StandardSocketManager.instance.connect();
    StandardFutureSocketManager.instance.connect();
    _fetchPrice();
  }

  Future fetchPublicInfo() async {
    try {
      final res = await CommodityApi.instance().getPublicInfo();
      _contractGroupList = res.contractGroupList ?? [];

      for (var element in _contractGroupList) {
        bobLog('Processing element: $element');

        element.contractList?.sort((a, b) => a.sort.compareTo(b.sort));
        for (var contractInfo in element.contractList!) {
          contractInfo.kind = element.kindInt;
          _contractSymbolHashMap[contractInfo.subSymbol] = contractInfo;
          _contractIdHashMap[contractInfo.id] = contractInfo;
          _contractNameHashMap[contractInfo.symbol] = contractInfo;
        }
      }
      MarketDataManager.instance.commodityInfo = res;
      _subContractPriceTicker(_contractGroupList);
      _subContractReview();
      _publicInfo = res;
      update();
    } on DioException catch (e) {
      // UIUtil.showError(e.error);
      bobLog('fetchPublicInfo error: $e');
    } catch (e) {
      bobLog('fetchPublicInfo error: $e');
    }
  }

  ContractInfo? getContractInfoBySubSymbol(String subSymbol) {
    return _contractSymbolHashMap[subSymbol];
  }

  ContractInfo? getContractInfoByContractId(num contractId) {
    return _contractIdHashMap[contractId];
  }
  ContractInfo? getContractInfoBySymbol(String symbol) {
    return _contractNameHashMap[symbol];
  }

  PriceInfo? getPriceInfoBySubSymbol(String subSymbol) {
    return priceMap[subSymbol];
  }

  getContractInfoMap() {
    return _contractIdHashMap;
  }

  @override
  void onClose() {
    if (_publicInfo != null) {
      _unSubPriceTicker(_contractGroupList);
    }
    _timer?.cancel();
    super.onClose();
  }
}

extension CommodityDataStoreControllerPrice on CommodityDataStoreController {
  _fetchPrice() {
    getPriceList();
    StandardFutureSocketManager.instance.subPriceList(callback: (res) {
      List list = res as List;
      for (var element in list) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        PriceInfo priceInfo = PriceInfo.fromJson(map.values.first);
        priceMap[map.keys.first] = priceInfo;
      }
    });
  }

  getPriceList() async {
    try {
      final res = await CommodityApi.instance().getPriceList();
      if (res != null) {
        List list = res as List;
        for (var element in list) {
          Map<String, dynamic> map = element as Map<String, dynamic>;
          PriceInfo priceInfo = PriceInfo.fromJson(map.values.first);
          priceMap[map.keys.first] = priceInfo;
        }
      }
    } catch (e) {
      bobLog('priceList ${e.toString()}');
    }
  }
}

///////////////////////////////////////////////////////////////
////////////////          ws订阅      //////////////////
///////////////////////////////////////////////////////////////
extension ContractDataStoreControllerSub on CommodityDataStoreController {
  _subContractReview() {
    StandardSocketManager.instance.subReview((symbol, data) {
      if (data.data == null) return;
      Map<String, dynamic> spotTickers = data.data!;
      spotTickers.forEach((key, value) {
        ContractInfo? contractInfo = _contractSymbolHashMap[key];
        if (contractInfo != null) {
          _contractSymbolHashMap[key] = _mergeContractInfo(contractInfo, value);
          update([key]);
        }
      });
    });
  }

  _subContractPriceTicker(List<ContractGroupList> contractList) {
    for (var element in contractGroupList) {
      List<String> subSymbolList =
          element.contractList!.map((e) => e.subSymbol).toList();
      _subBatchTicker(subSymbolList);
    }
  }

  _subBatchTicker(List<String> subSymbolList) {
    StandardSocketManager.instance.subBatchTicker(subSymbolList,
        (subSymbol, data) {
      if (data.tick != null) {
        ContractInfo? contractInfo = _contractSymbolHashMap[subSymbol];
        if (contractInfo == null) return;
        _contractSymbolHashMap[subSymbol] =
            _mergeContractInfo(contractInfo, data.tick!);
        update([subSymbol]);
        MarketDataManager.instance
            .refreshHomeMarket(type: MarketSecondType.standardContract);
      }
    });
  }

  _unSubPriceTicker(List<ContractGroupList> contractList) {
    List<String> subSymbolList = contractList
        .map((e) => e.contractList!)
        .expand((element) => element.map((e) => e.subSymbol))
        .toList();
    StandardSocketManager.instance.unSubBatchTicker(subSymbolList);
  }

  _mergeContractInfo(ContractInfo contractInfo, Map<String, dynamic> ticker) {
    if (ticker.isEmpty) return contractInfo;
    if (ticker['close'] == contractInfo.close &&
        ticker['vol'] == contractInfo.vol &&
        ticker['rose'] == contractInfo.rose &&
        ticker['amount'] == contractInfo.amount &&
        ticker['high'] == contractInfo.high &&
        ticker['low'] == contractInfo.low &&
        ticker['open'] == contractInfo.open) return contractInfo;
    String close = ticker['close'].toString();
    if (close.toNum() > contractInfo.close.toNum()) {
      contractInfo.priceColor = AppColor.upColor;
    } else if (close.toNum() < contractInfo.close.toNum()) {
      contractInfo.priceColor = AppColor.downColor;
    } else {
      contractInfo.priceColor = AppColor.colorBlack;
    }
    contractInfo.close = ticker['close'].toString();
    contractInfo.esPrice = ticker['es_price'] == null
        ? contractInfo.close
        : ticker['es_price'].toString();
    contractInfo.vol = ticker['vol'].toString();
    contractInfo.rose = ticker['rose'].toString();
    contractInfo.amount = ticker['amount'].toString();
    contractInfo.high = ticker['high'].toString();
    contractInfo.low = ticker['low'].toString();
    contractInfo.open = ticker['open'].toString();
    return contractInfo;
  }
}
