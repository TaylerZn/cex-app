import 'dart:collection';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/spot_goods/spot_goods_api.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/lang_cache/lang_cache_manager.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';

import '../../api/public/public.dart';
import '../../models/contract/res/price_ticker.dart';
import '../../models/contract/res/public_info.dart';
import '../../ws/spot_goods_socket_manager.dart';

class SpotDataStoreController extends GetxController {
  static SpotDataStoreController get to => Get.find();

  PublicInfoMarket? _infoMarket;

  PublicInfoMarket? get infoMarket => _infoMarket;

  final LinkedHashMap<String, MarketInfoModel> _linkedHashMap = LinkedHashMap();

  List<MarketInfoModel> _spotList = [];

  List<MarketInfoModel> get spotList => _spotList;

  @override
  void onInit() {
    super.onInit();
    SpotGoodsSocketManager.instance.connect();
  }

  Future getPublicInfoMarket() async {
    try {
      final value = await PublicApi.instance().getPublicInfoMarket();
      _spotList = value.market?.uSDT ?? [];
      _spotList.sort((a, b) => a.sort.compareTo(b.sort));
      for (var element in _spotList) {
        _linkedHashMap[element.symbol] = element;
      }

      if (value.rate != null) AssetsGetx.to.rateList = value.rate!;
      AssetsGetx.to.marketInfo = value; //JH: 这里缓存现货信息.
      AssetsGetx.to.update();
      MarketDataManager.instance.spotInfo = value;

      _reviewSpotTicker();
      subSpotTickerInfo(_spotList);
      _infoMarket = value;
      update();
    } on DioException catch (e) {
      // UIUtil.showError(e.error);
      bobLog('fetchPublicInfo error: $e');
    } catch (e) {
      bobLog('fetchPublicInfo error: $e');
    }
  }

  MarketInfoModel? getMarketInfoBySymbol(String symbol) {
    return _linkedHashMap[symbol];
  }

  getMarketInfoMap() {
    return _linkedHashMap;
  }
}

///////////////////////////////////////////////////////////////
////////////////          ws订阅      //////////////////
///////////////////////////////////////////////////////////////
extension SpotDataStoreControllerSub on SpotDataStoreController {
  void _reviewSpotTicker() {
    SpotGoodsSocketManager.instance.subReview((symbol, data) {
      if (data.data == null) return;
      Map<String, dynamic> spotTickers = data.data;
      spotTickers.forEach((key, value) {
        MarketInfoModel? marketInfoModel = _linkedHashMap[key];
        PriceTicker priceTicker = PriceTicker.fromJson(value);
        if (marketInfoModel != null) {
          marketInfoModel.close = priceTicker.close.toString();
          marketInfoModel.vol = priceTicker.vol.toString();
          marketInfoModel.rose = priceTicker.rose.toString();
          marketInfoModel.amount = priceTicker.amount.toString();
          marketInfoModel.high = priceTicker.high.toString();
          marketInfoModel.low = priceTicker.low.toString();
          marketInfoModel.open = priceTicker.open.toString();
          _linkedHashMap[key] = marketInfoModel;
        }
      });
      update();
    });
  }

  void subSpotTickerInfo(List<MarketInfoModel> arr) {
    if (arr.isEmpty) return;
    SpotGoodsSocketManager.instance
        .subBatchTicker(arr.map((e) => e.symbol).toList(), (symbol, data) {
      if (data.tick != null) {
        var priceTicker = PriceTicker.fromJson(data.tick!);
        MarketInfoModel? marketInfoModel = _linkedHashMap[symbol];
        if (marketInfoModel != null) {
          if (priceTicker.close.toDecimal() >
              marketInfoModel.close.toDecimal()) {
            marketInfoModel.priceColor = AppColor.upColor;
          } else if (priceTicker.close.toDecimal() <
              marketInfoModel.close.toDecimal()) {
            marketInfoModel.priceColor = AppColor.downColor;
          } else {
            marketInfoModel.priceColor = AppColor.colorBlack;
          }
          marketInfoModel.close = priceTicker.close.toString();
          marketInfoModel.vol = priceTicker.vol.toString();
          marketInfoModel.rose = priceTicker.rose.toString();
          marketInfoModel.amount = priceTicker.amount.toString();
          marketInfoModel.high = priceTicker.high.toString();
          marketInfoModel.low = priceTicker.low.toString();
          marketInfoModel.open = priceTicker.open.toString();
          _linkedHashMap[symbol] = marketInfoModel;
        }
        update([symbol]);
      }
    });
  }

  void unSubSpotTickerInfo(List<MarketInfoModel> arr) {
    if (arr.isEmpty) return;
    SpotGoodsSocketManager.instance
        .unSubBatchTicker(arr.map((e) => e.symbol).toList());
  }
}
