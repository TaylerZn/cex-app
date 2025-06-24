import 'dart:collection';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class SpotOptionController extends GetxController {
  static SpotOptionController get to => Get.find();

  List<String>? _optionSpotSymbolList;
  List<String> recommendContractList = [];

  List<String> get optionSpotSymbolList {
    if (_optionSpotSymbolList == null) {
      if (UserGetx.to.isLogin) {
        _optionSpotSymbolList = [];
      } else {
        List? arr = MarketKV.favoritesSpot.get();
        _optionSpotSymbolList = arr?.cast<String>() ?? [];
      }
    }
    return _optionSpotSymbolList!;
  }

  bool isOption(String symbol) => optionSpotSymbolList.contains(symbol);

  Future<List<String>> fetchOptionSpotSymbolList() async {
    try {
      if (UserGetx.to.isLogin) {
        final res = await PublicApi.instance().getOptionalListSymbol();
        _optionSpotSymbolList = res.symbols;
        recommendContractList = res.recommendIds;
        update();
        return res.symbols;
      } else {
        return optionSpotSymbolList;
      }
    } catch (e) {
      Get.log('error when fetchContractOptionalList: $e');
      return [];
    }
  }

  bool _isupdating = false;
  Future<bool> updateSpotOption(List<String> arr) async {
    if (_isupdating) {
      return false;
    }
    _isupdating = true;

    String str = '';
    List<String> tempArr = List.from(optionSpotSymbolList);

    for (var item in arr.reversed) {
      final index = tempArr.indexWhere((e) => e == item);
      if (index >= 0) {
        tempArr.removeAt(index);
        str = LocaleKeys.markets28.tr;
      } else {
        tempArr.insert(0, item);
        str = LocaleKeys.markets29.tr;
      }
    }
    // _optionSpotSymbolList = optionSpotSymbolList.toSet().toList();
    if (UserGetx.to.isLogin) {
      try {
        await PublicApi.instance().setOptionalListSymbol(tempArr.toSet().toList().join(','));
        // update();
        _optionSpotSymbolList = tempArr;
        if (str.isNotEmpty) UIUtil.showSuccess('$str${LocaleKeys.markets30.tr}');
        update();
        MarketDataManager.instance.updateOptionSymbol(type: MarketSecondType.spot);
        _isupdating = false;
        return true;
      } catch (e) {
        if (str.isNotEmpty) UIUtil.showError('$str${LocaleKeys.markets31.tr}');
        Get.log('error when addOptionalSpotSymbol: $e');
        update();
        _isupdating = false;
        return false;
      }
    } else {
      MarketKV.favoritesSpot.set(_optionSpotSymbolList!);
      MarketDataManager.instance.updateOptionSymbol(type: MarketSecondType.spot);
      update();
      if (str.isNotEmpty) UIUtil.showSuccess('$str${LocaleKeys.markets30.tr}');
      update();
      _isupdating = false;
      return true;
    }
  }

  clear() {
    _optionSpotSymbolList?.clear();
    update();
  }
}
