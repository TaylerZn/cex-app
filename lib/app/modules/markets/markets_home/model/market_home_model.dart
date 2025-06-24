import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_cell_model.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_model.dart';

class MarketsHomeFirstModel {
  MarketHomeFirstType firsttype;
  late TabController tabController;
  Function()? callBack;
  List<String> thirdTabNameArray;
  int secondIndex = 0;
  int thirdIndex = 0;

  List<MarketsHomeSecondModel> marketSecondArray = [];
  MarketsHomeFirstModel(this.firsttype, TickerProvider vsync, this.thirdTabNameArray, this.callBack) {
    marketSecondArray = [
      MarketsHomeSecondModel(
          firsttype == MarketHomeFirstType.optional ? MarketSecondType.standardContract : MarketSecondType.standardContractOnly,
          firsttype.tag,
          vsync,
          thirdTabNameArray, (i) {
        thirdIndex = i;
        callBack?.call();
      }),
    ];

    tabController = TabController(length: marketSecondArray.length, vsync: vsync);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        secondIndex = tabController.index;
        callBack?.call();
      }
    });
  }
}

class MarketsHomeSecondModel extends MarketsCellBaseModel {
  MarketSecondType secondType;
  var secondShowOptional = false.obs;
  MarketsFiveModel fourModel = MarketsFiveModel();

  // TabController? tabController;
  Function(int)? callBack;
  List<MarketsHomeThirdModel> marketThirdArray = [];
  String secondTag = '';
  var thiredCurrentIndex = 0.obs;
  List<String> thirdTabNameArray;

  MarketsHomeSecondModel(this.secondType, String tag, TickerProvider vsync, this.thirdTabNameArray, this.callBack) {
    secondTag = tag + secondType.tag;
    switch (secondType) {
      case MarketSecondType.standardContract:
        marketThirdArray = thirdTabNameArray.map((e) => MarketsHomeThirdModel(getThirdType(e), secondTag)).toList();
        break;
      default:
        bool isRegistered = Get.isRegistered<MarketsCellModel>(tag: secondTag);
        if (isRegistered) {
          Get.replace(rxModel, tag: secondTag);
        } else {
          Get.put(rxModel, tag: secondTag, permanent: true);
        }
    }
  }

  MarketHomeThirdType getThirdType(String str) {
    for (MarketHomeThirdType type in MarketHomeThirdType.values) {
      if (type.typeName == str) {
        return type;
      }
    }
    return MarketHomeThirdType.other;
  }

  List<String> array = [
    MarketHomeFourType.coinName.value,
    MarketHomeFourType.latestPrice.value,
    MarketHomeFourType.riseAndFall.value
  ];
}

class MarketsHomeThirdModel extends MarketsCellBaseModel {
  MarketHomeThirdType thirdType;
  String thridTag = '';
  // List? optionalArr = [];
  var showOptional = false.obs;
  // MarketsFourModel fourModel = MarketsFourModel();
  MarketsHomeThirdModel(this.thirdType, String tag) {
    thridTag = tag + thirdType.tag;
    bool isRegistered = Get.isRegistered<MarketsCellModel>(tag: thridTag);
    if (isRegistered) {
      Get.replace(rxModel, tag: thridTag);
    } else {
      Get.put(rxModel, tag: thridTag, permanent: true);
    }
    if (thirdType == MarketHomeThirdType.stocks) {
      // optionalArr = MarketDataManager.instance.getFavouriteTicker();
      // showOptional = optionalArr == null ? true.obs : false.obs;
    } else {
      // optionalArr = MarketDataManager.instance.getFavouriteTicker(isContract: false);
      // showOptional = optionalArr == null ? true.obs : false.obs;
    }
  }
}

// class MarketsHomeFourModel {
//   List<String> array = [
//     MarketHomeFourType.coinName.value,
//     MarketHomeFourType.latestPrice.value,
//     MarketHomeFourType.riseAndFall.value
//   ];

//   List<Rx<MarketHomeFourFilter>> filterArray = [
//     MarketHomeFourFilter.defaultFilter.obs,
//     MarketHomeFourFilter.defaultFilter.obs,
//     MarketHomeFourFilter.defaultFilter.obs,
//     MarketHomeFourFilter.defaultFilter.obs,
//   ];
// }
