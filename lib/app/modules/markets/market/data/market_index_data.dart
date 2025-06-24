import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/contract/contract_api.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/api/spot_goods/spot_goods_api.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/contract_favorite_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/spot_favorite_controller.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_cell_model.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_model.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_home/model/market_home_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

typedef FunUpdateSymbol = Function(MarketSecondType, bool, {List<ContractInfo>? contract, List<MarketInfoModel>? market})?;
typedef FunCommodityGroup = Function(List<ContractGroupList>? array)?;

class MarketDataManager {
  static MarketDataManager get instance => _singleton;
  static final MarketDataManager _singleton = MarketDataManager._();
  MarketDataManager._() {
    getIcon();
    getHotSymbol();
    Bus.getInstance().on(EventType.login, (data) {
      callbackData();
    });
    Bus.getInstance().on(EventType.signOut, (data) {
      callbackData(islogin: false);
    });
  }
  Map? _iconMap;
  bool _iconIsNotLoading = true;
  final List<FunUpdateSymbol> _updateEditSymbolArray = [];
  final List<FunCommodityGroup> _observeCommodityGroudList = [];
  final List<VoidCallback> _changeuserCallback = [];
  List<String>? _contractSymbol;
  List? _spotSymbol;
  MarketsCellModel cellModel = MarketsCellModel();
  List<ContractGroupList>? get commodityGroudList => cellModel.commodityGroudList;
  Function(MarketSecondType type)? refreshHome;
  List<String>? hotSymbolArray;
  int? currentIndex;
  String? marketType;
  Function(String type)? changeIndex;

  set onUpdateEditSymbol(FunUpdateSymbol f) {
    _updateEditSymbolArray.add(f);
  }

  set onchangeuser(VoidCallback f) {
    _changeuserCallback.add(f);
  }

  set onObserveCommodityGroup(FunCommodityGroup f) {
    _observeCommodityGroudList.add(f);
  }

  set spotInfo(PublicInfoMarket value) {
    cellModel.marketList = value.market?.uSDT;
    cellModel.marketList?.sort((a, b) => a.sort.compareTo(b.sort));
  }

//contractType == 'E'
  set contractInfo(PublicInfo value) {
    var array = value.contractList;
    cellModel.contractList = array.where((element) => element.contractType == 'E').toList();
    cellModel.contractList?.sort((a, b) => a.sort.compareTo(b.sort));
  }

  set commodityInfo(CommodityPublicInfo value) {
    List<ContractInfo> tempArr = [];
    value.contractGroupList?.forEach((element) {
      if (element.contractList != null) {
        cellModel.contractList?.sort((a, b) => a.sort.compareTo(b.sort));
        tempArr.addAll(element.contractList!);
      }
    });
    tempArr.sort((a, b) => a.sort.compareTo(b.sort));
    ContractGroupList all = ContractGroupList(kind: 'B_all', contractList: tempArr);
    value.contractGroupList?.insert(0, all);
    if (UserGetx.to.isLogin) {
      var array = CommodityOptionController.to.optionContractList;
      if (array.isEmpty) {
        CommodityOptionController.to.fetchOptionContractIdList().then((optionList) {
          cellModel.commodityGroudList = value.contractGroupList;
          for (var element in _observeCommodityGroudList) {
            element?.call(value.contractGroupList);
          }
        });
      } else {
        cellModel.commodityGroudList = value.contractGroupList;
        for (var element in _observeCommodityGroudList) {
          element?.call(value.contractGroupList);
        }
      }
    } else {
      cellModel.commodityGroudList = value.contractGroupList;
      for (var element in _observeCommodityGroudList) {
        element?.call(value.contractGroupList);
      }
    }
  }

  callbackData({bool islogin = true}) {
    if (islogin) {
      var array = CommodityOptionController.to.optionContractList;
      if (array.isEmpty) {
        CommodityOptionController.to.fetchOptionContractIdList().then((optionList) {
          for (var f in _changeuserCallback) {
            f();
          }
        });
      } else {
        for (var f in _changeuserCallback) {
          f();
        }
      }
    } else {
      for (var f in _changeuserCallback) {
        f();
      }
    }
  }

  void getPublicInfo(Function(bool, List<ContractInfo>?) callback, {bool isOptional = false}) async {
    try {
      PublicInfo value;
      if (isOptional) {
        if (ContractOptionController.to.optionContractList.isEmpty) {
          _contractSymbol = await ContractOptionController.to.fetchOptionContractIdList();
        } else {
          _contractSymbol = ContractOptionController.to.optionContractList.map((e) => e.toString()).toList();
        }
      }

      if (cellModel.contractList == null) {
        value = await ContractApi.instance().getPublicInfo();
        var array = value.contractList;
        cellModel.contractList = array.where((element) => element.contractType == 'E').toList();
        cellModel.contractList?.sort((a, b) => a.sort.compareTo(b.sort));
      }
      if (isOptional) {
        var recommend = ContractOptionController.to.recommendContractList;
        var recommendArr = cellModel.contractList?.where((element) => recommend.contains(element.id)).toList();
        var contractOptionArr =
            cellModel.contractList?.where((element) => _contractSymbol!.contains(element.id.toString())).toList();

        var callbackList = _contractSymbol?.isNotEmpty == true
            ? (contractOptionArr?.isNotEmpty == true ? contractOptionArr : recommendArr ?? cellModel.contractList)
            : recommendArr ?? cellModel.contractList;
        if (callbackList != null) {
          for (var i = 0; i < callbackList.length; i++) {
            var model = callbackList[i];
            model.index = i;
          }
        }
        callback(_contractSymbol == null || _contractSymbol!.isEmpty || contractOptionArr == null || contractOptionArr.isEmpty,
            callbackList);
      } else {
        var callbackList = cellModel.contractList;
        callback(false, callbackList);
      }
    } catch (e) {
      print(e);
    }
  }

  void getPublicInfoMarket(Function(bool, List<MarketInfoModel>?) callBack, {bool isOptional = false}) async {
    try {
      PublicInfoMarket value;
      if (isOptional) {
        if (SpotOptionController.to.optionSpotSymbolList.isEmpty) {
          _spotSymbol = await SpotOptionController.to.fetchOptionSpotSymbolList();
        } else {
          _spotSymbol = SpotOptionController.to.optionSpotSymbolList;
        }
      }

      if (cellModel.marketList == null) {
        value = await PublicApi.instance().getPublicInfoMarket();
        cellModel.marketList = value.market?.uSDT;
        cellModel.marketList?.sort((a, b) => a.sort.compareTo(b.sort));
      }

      if (isOptional) {
        var recommend = SpotOptionController.to.recommendContractList;
        var recommendArr = cellModel.marketList?.where((element) => recommend.contains(element.symbol)).toList();

        var spotOptionArr = cellModel.marketList?.where((element) => _spotSymbol!.contains(element.symbol)).toList();

        var callbackList = _spotSymbol?.isNotEmpty == true
            ? (spotOptionArr?.isNotEmpty == true ? spotOptionArr : recommendArr ?? cellModel.marketList)
            : recommendArr ?? cellModel.marketList;
        if (callbackList != null) {
          for (var i = 0; i < callbackList.length; i++) {
            var model = callbackList[i];
            model.index = i;
          }
        }
        callBack(_spotSymbol == null || _spotSymbol!.isEmpty || spotOptionArr == null || spotOptionArr.isEmpty, callbackList);

        // var filterArr = cellModel.marketList?.where((element) => _spotSymbol!.contains(element.symbol)).toList();

        // var callbackList = _spotSymbol?.isNotEmpty == true
        //     ? filterArr?.isNotEmpty == true
        //         ? filterArr
        //         : cellModel.marketList
        //     : cellModel.marketList;
        // callBack(_spotSymbol == null || _spotSymbol!.isEmpty || filterArr == null || filterArr.isEmpty, callbackList);
      } else {
        var callbackList = cellModel.marketList;
        callBack(false, callbackList);
      }
    } catch (e) {
      print(e);
    }
  }

  Future getData({MarketSecondType type = MarketSecondType.spot}) async {
    if (type == MarketSecondType.spot) {
      await SpotDataStoreController.to.getPublicInfoMarket();
    } else if (type == MarketSecondType.spot) {
      await ContractDataStoreController.to.fetchPublicInfo();
    } else {
      await CommodityDataStoreController.to.fetchPublicInfo();
    }
  }

  Future<bool> saveFavouriteTicker(List<String> array, {required MarketSecondType type}) {
    if (type == MarketSecondType.perpetualContract) {
      return ContractOptionController.to.updateContractOption(array.map((e) => num.parse(e)).toList());
    } else if (type == MarketSecondType.spot) {
      return SpotOptionController.to.updateSpotOption(array);
    } else {
      return CommodityOptionController.to.updateContractOption(array.map((e) => num.parse(e)).toList());
    }
  }

  String getTitleWithSymbol(String symbol, {required MarketSecondType type}) {
    bool have = true;
    if (type == MarketSecondType.perpetualContract) {
      have = ContractOptionController.to.isOption(num.parse(symbol));
    } else if (type == MarketSecondType.spot) {
      have = SpotOptionController.to.isOption(symbol);
    } else {
      have = CommodityOptionController.to.isOption(num.parse(symbol));
    }
    return have ? LocaleKeys.markets27.tr : LocaleKeys.markets26.tr;
  }

  void updateOptionSymbol({required MarketSecondType type}) {
    if (type == MarketSecondType.perpetualContract) {
      var contractFavorites = ContractOptionController.to.optionContractList;

      List<ContractInfo>? callbackList;
      bool showRecomed = false;
      if (contractFavorites.isEmpty) {
        var recommend = ContractOptionController.to.recommendContractList;
        var recommendArr = recommend.map((id) => cellModel.contractList!.firstWhere((element) => element.id == id)).toList();

        callbackList = recommendArr.isNotEmpty ? recommendArr : cellModel.contractList!;
        showRecomed = true;

        // var recommendArr = cellModel.contractList?.where((element) => recommend.contains(element.id)).toList();
        // var contractOptionArr =
        //     cellModel.contractList?.where((element) => _contractSymbol!.contains(element.id.toString())).toList();

        // callbackList = _contractSymbol?.isNotEmpty == true
        //     ? (contractOptionArr?.isNotEmpty == true ? contractOptionArr : recommendArr ?? cellModel.contractList)
        //     : recommendArr ?? cellModel.contractList;

        // showRecomed =
        //     _contractSymbol == null || _contractSymbol!.isEmpty || contractOptionArr == null || contractOptionArr.isEmpty;
      } else {
        var coinIdArray = cellModel.contractList!.map((e) => e.id).toList();

        callbackList = contractFavorites
            .where((id) => coinIdArray.contains(id))
            .map((id) => cellModel.contractList!.firstWhere(((element) => element.id == id)))
            .toList();

        showRecomed = false;
      }

      for (var i = 0; i < callbackList.length; i++) {
        var model = callbackList[i];
        model.index = i;
      }

      for (var updateEditSymbol in _updateEditSymbolArray) {
        updateEditSymbol?.call(type, showRecomed, contract: callbackList);
      }
    } else if (type == MarketSecondType.spot) {
      var spotFavorites = SpotOptionController.to.optionSpotSymbolList;

      List<MarketInfoModel>? callbackList;
      bool showRecomed = false;
      if (spotFavorites.isEmpty) {
        var recommend = SpotOptionController.to.recommendContractList;
        var recommendArr =
            recommend.map((symbol) => cellModel.marketList!.firstWhere((element) => element.symbol == symbol)).toList();
        callbackList = recommendArr.isNotEmpty ? recommendArr : cellModel.marketList!;
        showRecomed = true;

        // var recommendArr = cellModel.marketList?.where((element) => recommend.contains(element.symbol)).toList();
        // var spotOptionArr = recommendArr.isNotEmpty ? recommendArr : cellModel.marketList!;
        // callbackList = spotFavorites.isNotEmpty == true
        //     ? (spotOptionArr?.isNotEmpty == true ? spotOptionArr : recommendArr ?? cellModel.marketList)
        //     : recommendArr ?? cellModel.marketList;
        // showRecomed = true;
      } else {
        var coinIdArray = cellModel.marketList!.map((e) => e.symbol).toList();
        callbackList = spotFavorites
            .where((symbol) => coinIdArray.contains(symbol))
            .map((symbol) => cellModel.marketList!.firstWhere(((element) => element.symbol == symbol)))
            .toList();
        showRecomed = false;
      }

      for (var i = 0; i < callbackList.length; i++) {
        var model = callbackList[i];
        model.index = i;
      }

      for (var updateEditSymbol in _updateEditSymbolArray) {
        updateEditSymbol?.call(type, showRecomed, market: callbackList);
      }
    } else {
      for (var updateEditSymbol in _updateEditSymbolArray) {
        updateEditSymbol?.call(type, false);
      }
    }
  }

  refreshHomeMarket({required MarketSecondType type}) {
    refreshHome?.call(type);
  }

  String getIconWithName(String name) {
    getIcon();
    String? iconUrl = _iconMap?[name];
    return iconUrl ?? 'assets/images/default/icon_default.png';
  }

  getIcon() {
    if (_iconMap == null && _iconIsNotLoading) {
      _iconIsNotLoading = false;
      ObjectKV.icons.get((v) => _iconMap = v);
      return SpotGoodsApi.instance().getIcon().then((value) {
        _iconMap = value;
        ObjectKV.icons.set(_iconMap);
      }).catchError((e) {
        _iconIsNotLoading = true;
      });
    }
  }

  getHotSymbol() {
    PublicApi.instance().getIndexSymbolConfig('b.market.header.all').then((value) {
      var b0 = value['b.market.header.symbol'] != null ? value['b.market.header.symbol'].cast<String>() : [];
      var b1 = value['b.market.header.stock'] != null ? value['b.market.header.stock'].cast<String>() : [];
      var b2 = value['b.market.header.indice'] != null ? value['b.market.header.indice'].cast<String>() : [];
      var b3 = value['b.market.header.forex'] != null ? value['b.market.header.forex'].cast<String>() : [];
      var b4 = value['b.market.header.commodity'] != null ? value['b.market.header.commodity'].cast<String>() : [];
      var b5 = value['b.market.header.etf'] != null ? value['b.market.header.etf'].cast<String>() : [];

      hotSymbolArray = [...b0, ...b1, ...b2, ...b3, ...b4, ...b5];
    });
  }

  changeMarketIndex({int marketIndex = -1, String kindStr = ''}) {
    currentIndex = UserGetx.to.isLogin ?  marketIndex : 0;
    marketType = kindStr;
    if (changeIndex != null) {
      Get.untilNamed(Routes.MAIN_TAB);
      MarketDataManager.instance.changeIndex?.call(kindStr);
      MainTabController.to.changeTabIndex(1);
    } else {
      Get.untilNamed(Routes.MAIN_TAB);
      MainTabController.to.changeTabIndex(1);
    }
  }
}

// mixin MarketProcotol {
//   filterTicker(MarketsFirstModel firstModel, MarketsSecondModel secondModel, MarketsThirdModel? thiredModel, int index,
//       MarketFourFilter type) {
//     if (type == MarketFourFilter.defaultFilter) {
//       if (firstModel.firsttype == MarketFirstType.optional) {
//         if (thiredModel != null) {
//           thiredModel.rxModel.commodityList?.sort((a, b) => a.index.compareTo(b.index));
//           thiredModel.rxModel.update();
//         } else {
//           if (secondModel.secondType == MarketSecondType.perpetualContract) {
//             secondModel.rxModel.contractList?.sort((a, b) => a.index.compareTo(b.index));
//           } else {
//             secondModel.rxModel.marketList?.sort((a, b) => a.index.compareTo(b.index));
//           }
//           secondModel.rxModel.update();
//         }
//       } else {
//         if (thiredModel != null) {
//           thiredModel.rxModel.commodityList?.sort((a, b) => a.sort.compareTo(b.sort));
//           thiredModel.rxModel.update();
//         } else {
//           if (secondModel.secondType == MarketSecondType.perpetualContract) {
//             secondModel.rxModel.contractList?.sort((a, b) => a.sort.compareTo(b.sort));
//           } else {
//             secondModel.rxModel.marketList?.sort((a, b) => a.sort.compareTo(b.sort));
//           }
//           secondModel.rxModel.update();
//         }
//       }
//     } else {
//       switch (index) {
//         case 0:
//           if (thiredModel != null) {
//             if (type == MarketFourFilter.upFilter) {
//               thiredModel.rxModel.commodityList?.sort((a, b) => a.contractOtherName.compareTo(b.contractOtherName));
//             } else {
//               thiredModel.rxModel.commodityList?.sort((a, b) => b.contractOtherName.compareTo(a.contractOtherName));
//             }
//             thiredModel.rxModel.update();
//           } else {
//             if (secondModel.secondType == MarketSecondType.perpetualContract) {
//               if (type == MarketFourFilter.upFilter) {
//                 secondModel.rxModel.contractList?.sort((a, b) => a.contractOtherName.compareTo(b.contractOtherName));
//               } else {
//                 secondModel.rxModel.contractList?.sort((a, b) => b.contractOtherName.compareTo(a.contractOtherName));
//               }
//             } else {
//               if (type == MarketFourFilter.upFilter) {
//                 secondModel.rxModel.marketList?.sort((a, b) => a.showName.compareTo(b.showName));
//               } else {
//                 secondModel.rxModel.marketList?.sort((a, b) => b.showName.compareTo(a.showName));
//               }
//             }
//             secondModel.rxModel.update();
//           }
//           break;
//         case 1:
//           if (thiredModel != null) {
//             if (type == MarketFourFilter.upFilter) {
//               thiredModel.rxModel.commodityList?.sort((a, b) => double.parse(a.vol).compareTo(double.parse(b.vol)));
//             } else {
//               thiredModel.rxModel.commodityList?.sort((a, b) => double.parse(b.vol).compareTo(double.parse(a.vol)));
//             }
//             thiredModel.rxModel.update();
//           } else {
//             if (secondModel.secondType == MarketSecondType.perpetualContract) {
//               if (type == MarketFourFilter.upFilter) {
//                 secondModel.rxModel.contractList?.sort((a, b) => double.parse(a.vol).compareTo(double.parse(b.vol)));
//               } else {
//                 secondModel.rxModel.contractList?.sort((a, b) => double.parse(b.vol).compareTo(double.parse(a.vol)));
//               }
//             } else {
//               if (type == MarketFourFilter.upFilter) {
//                 secondModel.rxModel.marketList?.sort((a, b) => double.parse(a.vol).compareTo(double.parse(b.vol)));
//               } else {
//                 secondModel.rxModel.marketList?.sort((a, b) => double.parse(b.vol).compareTo(double.parse(a.vol)));
//               }
//             }
//             secondModel.rxModel.update();
//           }
//           break;
//         case 2:
//           if (thiredModel != null) {
//             if (type == MarketFourFilter.upFilter) {
//               thiredModel.rxModel.commodityList?.sort((a, b) => double.parse(a.close).compareTo(double.parse(b.close)));
//             } else {
//               thiredModel.rxModel.commodityList?.sort((a, b) => double.parse(b.close).compareTo(double.parse(a.close)));
//             }

//             thiredModel.rxModel.update();
//           } else {
//             if (secondModel.secondType == MarketSecondType.perpetualContract) {
//               if (type == MarketFourFilter.upFilter) {
//                 secondModel.rxModel.contractList?.sort((a, b) => double.parse(a.close).compareTo(double.parse(b.close)));
//               } else {
//                 secondModel.rxModel.contractList?.sort((a, b) => double.parse(b.close).compareTo(double.parse(a.close)));
//               }
//             } else {
//               if (type == MarketFourFilter.upFilter) {
//                 secondModel.rxModel.marketList?.sort((a, b) => double.parse(a.close).compareTo(double.parse(b.close)));
//               } else {
//                 secondModel.rxModel.marketList?.sort((a, b) => double.parse(b.close).compareTo(double.parse(a.close)));
//               }
//             }
//             secondModel.rxModel.update();
//           }
//           break;

//         default:
//           if (thiredModel != null) {
//             if (type == MarketFourFilter.upFilter) {
//               thiredModel.rxModel.commodityList?.sort((a, b) => double.parse(a.rose).compareTo(double.parse(b.rose)));
//             } else {
//               thiredModel.rxModel.commodityList?.sort((a, b) => double.parse(b.rose).compareTo(double.parse(a.rose)));
//             }

//             thiredModel.rxModel.update();
//           } else {
//             if (secondModel.secondType == MarketSecondType.perpetualContract) {
//               if (type == MarketFourFilter.upFilter) {
//                 secondModel.rxModel.contractList?.sort((a, b) => double.parse(a.rose).compareTo(double.parse(b.rose)));
//               } else {
//                 secondModel.rxModel.contractList?.sort((a, b) => double.parse(b.rose).compareTo(double.parse(a.rose)));
//               }
//             } else {
//               if (type == MarketFourFilter.upFilter) {
//                 secondModel.rxModel.marketList?.sort((a, b) => double.parse(a.rose).compareTo(double.parse(b.rose)));
//               } else {
//                 secondModel.rxModel.marketList?.sort((a, b) => double.parse(b.rose).compareTo(double.parse(a.rose)));
//               }
//             }
//             secondModel.rxModel.update();
//           }
//       }
//     }
//   }

// }
