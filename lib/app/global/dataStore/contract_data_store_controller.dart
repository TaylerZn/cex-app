import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';

import '../../api/contract/contract_api.dart';
import '../../config/theme/app_color.dart';
import '../../models/contract/res/price_info.dart';
import '../../ws/contract_socket_manager.dart';
import '../../ws/future_socket_manager.dart';

class ContractDataStoreController extends GetxController {
  static ContractDataStoreController get to => Get.find();

  PublicInfo? _publicInfo;

  PublicInfo? get publicInfo => _publicInfo;
  final LinkedHashMap<String, ContractInfo> _linkedHashMap = LinkedHashMap();
  final LinkedHashMap<num, ContractInfo> _contractIdLinkedHashMap =
      LinkedHashMap();

  /// 合约价格
  Map<String, PriceInfo> priceMap = {};

  /// 合约列表
  List<ContractInfo> _contractList = [];

  List<ContractInfo> get contractList => _contractList;

  @override
  void onInit() {
    super.onInit();
    ContractSocketManager.instance.connect();
    FuturetSocketManager.instance.connect();
    _fetchPrice();
  }

  /// 合约列表
  Future fetchPublicInfo() async {
    bobLog('fetchPublicInfo');
    try {
      final res = await ContractApi.instance().getPublicInfo();
      _contractList = res.contractList
          .where((element) => element.contractType == 'E')
          .toList();
      _contractList.sort((a, b) => a.sort.compareTo(b.sort));
      for (var element in res.contractList) {
        _linkedHashMap[element.subSymbol] = element;
        _contractIdLinkedHashMap[element.id] = element;
      }

      MarketDataManager.instance.contractInfo = res;
      _subBatchContractTicker(res.contractList);
      _reqAllContractTicker();
      _publicInfo = res;
      update();
    } on DioException catch (e) {
      bobLog('fetchPublicInfo error: $e');
    } catch (e) {
      bobLog('fetchPublicInfo error: $e');
    }
  }

  /// 根据subSymbol获取合约信息
  ContractInfo? getContractInfoBySubSymbol(String subSymbol) {
    return _linkedHashMap[subSymbol];
  }

  getContractInfoMap() {
    return _linkedHashMap;
  }

  /// 根据contractId获取合约信息
  ContractInfo? getContractInfoByContractId(num contractId) {
    return _contractIdLinkedHashMap[contractId];
  }

  /// 根据subSymbol 获取合约价格
  PriceInfo? getPriceInfoBySubSymbol(String subSymbol) {
    return priceMap[subSymbol];
  }

  @override
  void onClose() {
    if (_publicInfo != null) {
      _unSubPriceTicker(_publicInfo!.contractList);
    }
    super.onClose();
  }
}

///////////////////////////////////////////////////////////////
////////////////          标记价和最新价      //////////////////
///////////////////////////////////////////////////////////////
extension ContractDataStoreControllerPrice on ContractDataStoreController {
  _fetchPrice() {
    getPriceList();
    FuturetSocketManager.instance.subPriceList(callback: (res) {
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
      final res = await ContractApi.instance().getPriceList();
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
extension ContractDataStoreControllerSub on ContractDataStoreController {
  /// 一次性返回所有币对的24小时行情数据
  _reqAllContractTicker() {
    ContractSocketManager.instance.subReview((symbol, data) {
      if (data.data == null) return;
      Map<String, dynamic> spotTickers = data.data!;
      spotTickers.forEach((key, value) {
        ContractInfo? contractInfo = _linkedHashMap[key];
        if (contractInfo != null) {
          _linkedHashMap[key] = _mergeContractInfo(contractInfo, value);
          update([key]);
        }
      });
    });
  }

  /// 批量订阅合约行情
  _subBatchContractTicker(List<ContractInfo> contractList) {
    ContractSocketManager.instance.subBatchTicker(
        contractList.map((e) => e.subSymbol).toList(), (subSymbol, data) {
      if (data.tick != null) {
        ContractInfo? contractInfo = _linkedHashMap[subSymbol];
        if (contractInfo == null) return;
        _linkedHashMap[subSymbol] =
            _mergeContractInfo(contractInfo, data.tick!);
        update([subSymbol]);
      }
    });
  }

  _unSubPriceTicker(List<ContractInfo> contractList) {
    ContractSocketManager()
        .unSubBatchTicker(contractList.map((e) => e.subSymbol).toList());
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
