import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/search/search.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/enums/search.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/search/search/widget/search_top.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ontap_util.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/models/search/search_functions.dart';
import 'package:nt_app_flutter/app/models/search/search_futures.dart';
import 'package:nt_app_flutter/app/models/search/search_market.dart';
import 'package:nt_app_flutter/app/models/search/search_topics.dart';
import 'package:nt_app_flutter/app/models/search/search_trader.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/search/search/model/search_enum.dart';

class SearchIndexController extends GetxController with GetSingleTickerProviderStateMixin implements SearchTopController {
  int currentIndex = 0;

  String searchText = "";

  List<SearchResultsType>? argumentTabs;

  SearchIndexController({this.currentIndex = 0, this.searchText = "", this.argumentTabs});

  //是否已经进行了搜索
  RxBool isSearchOntap = false.obs;
  RxList promptList = [].obs;
  var recommendList = <ContractInfo>[].obs;

  List<SearchResultsType> tabs = <SearchResultsType>[
    SearchResultsType.all,
    SearchResultsType.contract,
    // SearchResultsType.spot,
    SearchResultsType.community,
    SearchResultsType.trader,
    SearchResultsType.functiontype,
  ];

  List<SearchResultsModel> modelList = <SearchResultsModel>[];

  SearchResultsType get currentType => tabs[currentIndex];

  var dataList = [];
  late TabController tabController;

  Rx<TextEditingController> textEditVC = TextEditingController().obs;

  var spotsList = <MarketInfoModel>[].obs;
  var contractList = <ContractInfo>[].obs;
  var topicsList = <TopicdetailModel>[].obs;
  var traderList = <FollowKolInfo>[].obs;
  var functionsList = <FunctionsPageListModel>[].obs;

  @override
  void onInit() {
    if (argumentTabs != null) {
      tabs = argumentTabs!;
    }

    for (var i = 0; i < tabs.length; i++) {
      modelList.add(tabs[0].model);
    }

    super.onInit();
    getCommonRecommendCoin();

    Bus.getInstance().on(EventType.blockUser, (data) {
      topicsList.removeWhere((item) => item.memberId == data);
      update();
    });

    Bus.getInstance().on(EventType.delPost, (data) {
      topicsList.removeWhere((item) => item.id == data);
      update();
    });

    textEditVC.value.addListener(myDebounce(() {
      if (textEditVC.value.text.isNotEmpty) {
        // searchTicker();
        update();
      } else {
        isSearchOntap.value = false;
        searchText = "";
        update();
      }
    }));
    if (searchText.isNotEmpty) {
      textEditVC.value.text = searchText;
      searchText = "";
      onSubmit(textEditVC.value.text);
    }
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.index = currentIndex;
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  //获取热门交易
  getCommonRecommendCoin() {
    ObjectKV.recommend.get((v) {
      var list = <ContractInfo>[];
      v['list'].forEach((v) {
        list.add(ContractInfo.fromJson(v));
      });
      recommendList.value = list;
    });
    SearchApi.instance().getHotTrades(10).then((value) {
      recommendList.value = value.list ?? [];
    });
  }

  //搜索快捷词
  searchTicker() async {
    var text = textEditVC.value.text;
    if (text.isNotEmpty) {
      try {
        var res = await SearchApi.instance().searchPrompt(text, '10');
        if (res != null) {
          promptList.value = res;
        }
      } on DioException catch (e) {
        Get.log('getSymbolsupportnets error: $e');
      }
    } else {
      promptList.clear();
    }
  }

  // 输入框确认
  onSubmit(String text) {
    if (text.isNotEmpty && text != searchText) {
      isSearchOntap.value = true;
      searchText = text;

      for (var model in modelList) {
        model.reset();
      }
      getAllData();
    } else {
      isSearchOntap.value = false;
      searchText = "";
    }
  }

  // 获取全部数据 不查全部接口，一步一步来
  getAllData() async {
    List<Future<void>> futures = [];

    if (tabs.contains(SearchResultsType.contract)) {
      futures.add(getSearchFutures());
    }
    // if (tabs.contains(SearchResultsType.spot)) {
    //   futures.add(getSearchMarkets());
    // }
    if (tabs.contains(SearchResultsType.community)) {
      futures.add(getSearchCommunity());
    }
    if (tabs.contains(SearchResultsType.trader)) {
      futures.add(getSearchTraders());
    }
    if (tabs.contains(SearchResultsType.functiontype)) {
      futures.add(getSearchFunctions());
    }

    await Future.wait(futures);
    checkAllHasData();
  }

  //检查All页是否有值
  checkAllHasData() {
    if (spotsList.isNotEmpty) {
      setAllSuccess();
      return;
    }

    if (contractList.isNotEmpty) {
      setAllSuccess();
      return;
    }

    if (topicsList.isNotEmpty) {
      setAllSuccess();
      return;
    }

    if (traderList.isNotEmpty) {
      setAllSuccess();
      return;
    }
    if (functionsList.isNotEmpty) {
      setAllSuccess();
      return;
    }
    modelList[0].loadingController.setEmpty();
    update();
  }

  //设置 All页 成功
  setAllSuccess() {
    modelList[0].loadingController.setSuccess();
    update();
    ListKV.mainSearchHistory
        .add(textEditVC.value.text, checkExisting: true, bringOldToFront: true, isInsert0: true, maxLength: 30);
    Bus.getInstance().emit(EventType.searchHistory, SearchHistoryEnumn.main);
  }

  //获取数据
  getListData() async {
    switch (currentType) {
      case SearchResultsType.all:
        await getAllData();
      case SearchResultsType.contract:
        await getSearchFutures();
      // case SearchResultsType.spot:
      //   await getSearchMarkets();
      case SearchResultsType.community:
        await getSearchCommunity();
      case SearchResultsType.trader:
        await getSearchTraders();
      case SearchResultsType.functiontype:
        await getSearchFunctions();

      default:
        return [];
    }
  }

  //搜索合约
  getSearchFutures() async {
    if (tabs.contains(SearchResultsType.contract)) {
      int index = tabs.indexOf(SearchResultsType.contract);
      SearchResultsModel currentModel = modelList[index];

      if (currentModel.page == 1) {
        contractList.clear();
      }
      try {
        SearchFuturesModel? res =
            await SearchApi.instance().searchFutures('${currentModel.page}', '${currentModel.pageSize}', textEditVC.value.text);
        if (res != null) {
          for (ContractInfo item in res.futures?.list ?? []) {
            contractList.add(item);
          }

          currentModel.haveMore = currentModel.page == res.futures?.pageSize;
          currentModel.loadingController.setSuccess();
          if (contractList.isNotEmpty) {
            currentModel.loadingController.setSuccess();
          } else {
            currentModel.loadingController.setEmpty();
          }
        } else {
          currentModel.loadingController.setEmpty();
        }
      } catch (e) {
        Get.log('getSearchFutures error: $e');
        currentModel.loadingController.setEmpty();
      }
    }
  }

  //搜索现货
  getSearchMarkets() async {
    if (tabs.contains(SearchResultsType.spot)) {
      int index = tabs.indexOf(SearchResultsType.spot);
      SearchResultsModel currentModel = modelList[index];
      if (currentModel.page == 1) {
        spotsList.clear();
      }
      try {
        SearchMarketModel? res =
            await SearchApi.instance().searchMarkets('${currentModel.page}', '${currentModel.pageSize}', textEditVC.value.text);
        if (res != null) {
          for (MarketInfoModel item in res.markets?.list ?? []) {
            spotsList.add(item);
          }

          currentModel.haveMore = currentModel.page == res.markets?.pageSize;
          if (spotsList.isNotEmpty) {
            currentModel.loadingController.setSuccess();
          } else {
            currentModel.loadingController.setEmpty();
          }
        } else {
          currentModel.loadingController.setEmpty();
        }
      } catch (e) {
        Get.log('getSearchMarkets error: $e');
        currentModel.loadingController.setEmpty();
      }
    }
  }

  //搜索社区
  getSearchCommunity() async {
    if (tabs.contains(SearchResultsType.community)) {
      int index = tabs.indexOf(SearchResultsType.community);
      SearchResultsModel currentModel = modelList[index];
      if (currentModel.page == 1) {
        topicsList.clear();
      }
      try {
        SearchTopicsModel? res =
            await SearchApi.instance().searchTopics('${currentModel.page}', '${currentModel.pageSize}', textEditVC.value.text);
        if (res != null) {
          for (TopicdetailModel item in res.topics?.list ?? []) {
            topicsList.add(item);
          }

          currentModel.haveMore = currentModel.page == res.topics?.pageSize;
          currentModel.loadingController.setSuccess();
          if (topicsList.isNotEmpty) {
            currentModel.loadingController.setSuccess();
          } else {
            currentModel.loadingController.setEmpty();
          }
        } else {
          currentModel.loadingController.setEmpty();
        }
      } catch (e) {
        Get.log('getSearchFutures error: $e');
        currentModel.loadingController.setEmpty();
      }
    }
  }

  //搜索交易员
  getSearchTraders() async {
    if (tabs.contains(SearchResultsType.trader)) {
      int index = tabs.indexOf(SearchResultsType.trader);
      SearchResultsModel currentModel = modelList[index];
      if (currentModel.page == 1) {
        traderList.clear();
      }
      try {
        SearchTradersModel? res =
            await SearchApi.instance().searchTraders('${currentModel.page}', '${currentModel.pageSize}', textEditVC.value.text);
        if (res != null) {
          for (FollowKolInfo item in res.traders?.list ?? []) {
            traderList.add(item);
          }

          currentModel.haveMore = currentModel.page == res.traders?.pageSize;
          currentModel.loadingController.setSuccess();
          if (traderList.isNotEmpty) {
            currentModel.loadingController.setSuccess();
          } else {
            currentModel.loadingController.setEmpty();
          }
        } else {
          currentModel.loadingController.setEmpty();
        }
      } catch (e) {
        Get.log('getSearchFutures error: $e');
        currentModel.loadingController.setEmpty();
      }
    }
  }

  //功能搜索
  getSearchFunctions() async {
    if (tabs.contains(SearchResultsType.functiontype)) {
      int index = tabs.indexOf(SearchResultsType.functiontype);
      SearchResultsModel currentModel = modelList[index];
      if (currentModel.page == 1) {
        functionsList.clear();
      }
      try {
        SearchFunctionsModel? res = await SearchApi.instance()
            .searchFunctions('${currentModel.page}', '${currentModel.pageSize}', textEditVC.value.text);
        if (res != null) {
          for (FunctionsPageListModel item in res.functions?.list ?? []) {
            functionsList.add(item);
          }

          currentModel.haveMore = currentModel.page == res.functions?.pageSize;
          currentModel.loadingController.setSuccess();
          if (functionsList.isNotEmpty) {
            currentModel.loadingController.setSuccess();
          } else {
            currentModel.loadingController.setEmpty();
          }
        } else {
          currentModel.loadingController.setEmpty();
        }
      } catch (e) {
        Get.log('getSearchFutures error: $e');
        currentModel.loadingController.setEmpty();
      }
    }
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.blockUser, (data) {});
    Bus.getInstance().off(EventType.delPost, (data) {});
    super.onClose();
  }
}
