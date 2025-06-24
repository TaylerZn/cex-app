import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_cell_model.dart';
import 'package:nt_app_flutter/app/utils/utilities/platform_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MarketsFirstModel {
  MarketFirstType firsttype;
  late TabController tabController;
  Function()? callBack;
  List<List<String>> thirdTabNameArray;

  int secondIndex = 0;
  int thirdIndex = 0;
  int fourIndex = 0;

  List<MarketsSecondModel> marketSecondArray = [];
  MarketsFirstModel(this.firsttype, TickerProvider vsync,
      this.thirdTabNameArray, this.callBack) {
    marketSecondArray = MyPlatFormUtil.isIOS()
        ? [
            MarketsSecondModel(firsttype, MarketSecondType.perpetualContract,
                firsttype.tag, vsync, thirdTabNameArray, (i, j) {
              thirdIndex = i;
              fourIndex = j;
              callBack?.call();
            }),
          ]
        : [
            MarketsSecondModel(firsttype, MarketSecondType.standardContract,
                firsttype.tag, vsync, thirdTabNameArray, (i, j) {
              thirdIndex = i;
              fourIndex = j;
              callBack?.call();
            }),
            MarketsSecondModel(firsttype, MarketSecondType.perpetualContract,
                firsttype.tag, vsync, thirdTabNameArray, (i, j) {
              thirdIndex = i;
              fourIndex = j;
              callBack?.call();
            }),
            // MarketsSecondModel(firsttype, MarketSecondType.spot, firsttype.tag, vsync, thirdTabNameArray, (i, j) {
            //   thirdIndex = i;
            //   fourIndex = j;
            //   callBack?.call();
            // }),
          ];
    tabController =
        TabController(length: marketSecondArray.length, vsync: vsync);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        secondIndex = tabController.index;
        callBack?.call();
      }
    });
  }
}

class MarketsCellBaseModel extends GetxController {
  MarketsCellModel rxModel = MarketsCellModel();
}

class MarketsSecondModel extends MarketsCellBaseModel {
  MarketFirstType firsttype;

  MarketSecondType secondType;
  var secondShowOptional = false.obs;
  MarketsFiveModel fourModel = MarketsFiveModel();

  TabController? tabController;
  Function(int, int)? callBack;
  List<MarketsThirdModel> marketThirdArray = [];
  String secondTag = '';
  List<List<String>> thirdTabNameArray;
  int fourIndex = 0;
  RefreshController refreshVC = RefreshController();

  MarketsSecondModel(this.firsttype, this.secondType, String tag,
      TickerProvider vsync, this.thirdTabNameArray, this.callBack) {
    secondTag = tag + secondType.tag;
    switch (secondType) {
      case MarketSecondType.standardContract:
        marketThirdArray = thirdTabNameArray.isEmpty
            ? []
            : thirdTabNameArray.first
                .map((e) => MarketsThirdModel(getThirdType(e),
                        thirdTabNameArray.last, vsync, secondTag, (i) {
                      fourIndex = i;
                      callBack?.call(tabController!.index, fourIndex);
                    }))
                .toList();

        tabController =
            TabController(length: marketThirdArray.length, vsync: vsync);
        changeIndex();

        tabController!.addListener(() {
          if (!tabController!.indexIsChanging) {
            callBack?.call(tabController!.index, fourIndex);
          }
        });
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
  MarketThirdType getThirdType(String str) {
    for (MarketThirdType type in MarketThirdType.values) {
      if (type.typeName == str) {
        return type;
      }
    }
    return MarketThirdType.other;
  }

  changeIndex() {
    if (firsttype == MarketFirstType.market) {
      var index = MarketDataManager.instance.marketType?.isNotEmpty == true
          ? thirdTabNameArray.first
              .indexOf(MarketDataManager.instance.marketType!)
          : 0;
      tabController?.index = index;
    }
  }
}

class MarketsThirdModel extends MarketsCellBaseModel {
  MarketThirdType thirdType;
  String thridTag = '';
  var showOptional = false.obs;
  RefreshController refreshVC = RefreshController();
  TabController? tabController;
  Function(int)? callBack;
  List<String> fourTabNameArray;

  List<MarketsFourModel> marketFourArray = [];

  MarketsThirdModel(this.thirdType, this.fourTabNameArray, TickerProvider vsync,
      String tag, this.callBack) {
    thridTag = tag + thirdType.tag;

    switch (thirdType) {
      case MarketThirdType.stocks:
        marketFourArray = fourTabNameArray
            .map((e) => MarketsFourModel(getFourType(e), thridTag))
            .toList();
        tabController =
            TabController(length: marketFourArray.length, vsync: vsync);
        tabController!.addListener(() {
          if (!tabController!.indexIsChanging) {
            callBack?.call(tabController!.index);
          }
        });
        break;
      default:
        bool isRegistered = Get.isRegistered<MarketsCellModel>(tag: thridTag);
        if (isRegistered) {
          Get.replace(rxModel, tag: thridTag);
        } else {
          Get.put(rxModel, tag: thridTag, permanent: true);
        }
    }
  }

  MarketFourType getFourType(String str) {
    for (MarketFourType type in MarketFourType.values) {
      if (type.typeName == str) {
        return type;
      }
    }
    return MarketFourType.stockOther;
  }
}

class MarketsFourModel extends MarketsCellBaseModel {
  MarketFourType fourType;
  String fourTag = '';
  var showOptional = false.obs;
  RefreshController refreshVC = RefreshController();
  MarketsFourModel(this.fourType, String tag) {
    fourTag = tag + fourType.tag;
    bool isRegistered = Get.isRegistered<MarketsCellModel>(tag: fourTag);
    if (isRegistered) {
      Get.replace(rxModel, tag: fourTag);
    } else {
      Get.put(rxModel, tag: fourTag, permanent: true);
    }
  }
}

class MarketsFiveModel {
  List<String> array = [
    LocaleKeys.markets16,
    LocaleKeys.markets17,
    LocaleKeys.markets18,
    LocaleKeys.markets19
  ];

  List<Rx<MarketFourFilter>> filterArray = [
    MarketFourFilter.defaultFilter.obs,
    MarketFourFilter.defaultFilter.obs,
    MarketFourFilter.defaultFilter.obs,
    MarketFourFilter.defaultFilter.obs,
  ];
}
