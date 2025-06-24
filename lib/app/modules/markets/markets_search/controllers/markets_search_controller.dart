import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/public/public.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_search/model/markets_search_enum.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_search/model/markets_search_model.dart';

class MarketsSearchController extends GetxController with GetSingleTickerProviderStateMixin {
  final tabs = <MarketSarchType>[
    // MarketSarchType.optional,
    MarketSarchType.contract,
    MarketSarchType.spot,
    // MarketSarchType.stocks,
    // MarketSarchType.bulk,
    // MarketSarchType.forex,
    // MarketSarchType.exponent
  ];
  List<List<MarketSearchResModel>> searchResArr = [];
  late TabController tabController;
  TextEditingController textEditVC = TextEditingController();

  int currentIndex = 0;
  var isSearch = 0.obs;
  var recommendList = <MarketInfoModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();

    final arg = Get.arguments;
    if (arg != null && arg['coinName'] != null) {
      textEditVC.text = arg['coinName'];
      searchTicker();
      isSearch.value++;
    } else {
      PublicApi.instance().recommendSymbol().then((model) {
        var array = model.recommendSymbolList?.map((e) {
          var marketInfo = null;
          if (marketInfo != null) {
            marketInfo.close = e.ticker?.close ?? '--';
            marketInfo.rose = e.ticker?.rose ?? '--';
            marketInfo.vol = e.ticker?.vol ?? '--';
          }
          return marketInfo;
        });

        List<MarketInfoModel> tempArr = [];
        if (array != null) {
          for (var element in array) {
            if (element != null) {
              tempArr.add(element);
            }
          }
        }
        recommendList.value = tempArr;
        // if (tempArr.isNotEmpty) {
        //   MarketDataManager.instance.onSpot(() {
        //     recommendList.value = List.from(tempArr);
        //   });
        // }
      }).catchError((e) {
        print(e);
      });
    }
  }

  searchTicker() {
    var text = textEditVC.text;
    searchResArr.clear();
    if (text.isNotEmpty) {
      var cellModel = MarketDataManager.instance.cellModel;

      List<MarketSearchResModel> tempContractArr = [];
      if (cellModel.contractList != null) {
        for (var element in cellModel.contractList!) {
          if (element.contractOtherName.contains(text.toUpperCase())) {
            MarketSearchResModel res = MarketSearchResModel();
            res.symbol = element.contractOtherName;
            res.price = element.priceStr;
            res.rate = element.roseStr;
            tempContractArr.add(res);
          }
        }
        // if (tempContractArr.isNotEmpty) {
        // tabs.add(MarketSarchType.contract);
        searchResArr.add(tempContractArr);
        // }
      }

      List<MarketSearchResModel> tempSpotArr = [];
      if (cellModel.marketList != null) {
        for (var element in cellModel.marketList!) {
          if (element.showName.contains(text.toUpperCase())) {
            MarketSearchResModel res = MarketSearchResModel();
            res.symbol = element.showName;
            res.price = element.priceStr;
            res.rate = element.roseStr;
            tempContractArr.add(res);
          }
        }
        // if (tempSpotArr.isNotEmpty) {
        // tabs.add(MarketSarchType.spot);
        searchResArr.add(tempSpotArr);
        // }
      }
    }

    isSearch.value++;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
