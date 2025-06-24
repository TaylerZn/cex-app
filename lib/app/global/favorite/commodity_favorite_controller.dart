import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../getX/user_Getx.dart';

class CommodityOptionController extends GetxController {
  static CommodityOptionController get to => Get.find();

  /// 自选合约列表
  List<num>? _optionContractList;
  List<num> _recommendContractList = [];

  List<num> get recommendContractList => _recommendContractList;

  List<num> get optionContractList {
    if (_optionContractList == null) {
      if (UserGetx.to.isLogin) {
        _optionContractList = [];
      } else {
        List? arr = MarketKV.favoritesContract.get();
        _optionContractList = arr?.cast<num>() ?? [];
      }
    }
    return _optionContractList!;
  }

  /// 是否是自选
  bool isOption(num contractId) => optionContractList.contains(contractId);

  /// 获取自选合约列表
  Future<List<String>> fetchOptionContractIdList() async {
    try {
      if (UserGetx.to.isLogin) {
        final res = await CommodityApi.instance().getContractOptionalList();
        List<String> contractList =
            res.collectIds.isNotEmpty ? res.collectIds.split(',') : [];
        _optionContractList = contractList.map((e) => num.parse(e)).toList();
        _recommendContractList =
            res.recommendIds.split(',').map((e) => num.parse(e)).toList();

        update();
        return contractList;
      } else {
        return optionContractList.map((e) => e.toString()).toList();
      }
    } catch (e) {
      Get.log('error when fetchContractOptionalList: $e');
      return [];
    }
  }

  bool _isupdating = false;

  /// 添加自选合约
  Future<bool> updateContractOption(List<num> arr) async {
    if (!UserGetx.to.goIsLogin()) {
      return false;
    }
    if (_isupdating) {
      return false;
    }
    _isupdating = true;

    String str = '';

    List<num> tempArr = List.from(optionContractList);
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
    // _optionContractList = optionContractList.toSet().toList();
    if (UserGetx.to.isLogin) {
      try {
        await CommodityApi.instance()
            .setContractOptionalList(tempArr.toSet().toList().join(','));
        _optionContractList = tempArr;
        if (str.isNotEmpty) {
          UIUtil.showSuccess('$str${LocaleKeys.markets30.tr}');
        }
        update();
        MarketDataManager.instance
            .updateOptionSymbol(type: MarketSecondType.standardContract);
        _isupdating = false;
        return true;
      } catch (e) {
        if (str.isNotEmpty) UIUtil.showError('$str${LocaleKeys.markets31.tr}');
        Get.log('error when addOptionalContract: $e');
        update();
        _isupdating = false;
        return false;
      }
    } else {
      MarketKV.favoritesContract.set(_optionContractList!);
      MarketDataManager.instance
          .updateOptionSymbol(type: MarketSecondType.standardContract);
      update();
      if (str.isNotEmpty) UIUtil.showSuccess('$str${LocaleKeys.markets30.tr}');
      update();
      _isupdating = false;
      return true;
    }
  }

  //清空自选合约
  clear() {
    _optionContractList?.clear();
    update();
  }
}
