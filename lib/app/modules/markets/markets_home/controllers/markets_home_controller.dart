import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_home/model/market_home_model.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class MarketsHomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  List<MarketsHomeFirstModel> marketFirstArray = [];
  int first = 0;
  double height = 0;

  @override
  void onInit() {
    super.onInit();
    MarketDataManager.instance.onchangeuser = getGroupList;
    MarketDataManager.instance.onUpdateEditSymbol = updatEditSymbol;
    // MarketDataManager.instance.refreshHome = refreshMarket;
  }

  @override
  void onReady() {
    super.onReady();
    getGroupList();
  }

  getGroupList() {
    var commodityGroudList = MarketDataManager.instance.commodityGroudList;
    if (commodityGroudList != null) {
      observeCommodityGroudList(commodityGroudList);
    } else {
      MarketDataManager.instance.onObserveCommodityGroup = observeCommodityGroudList;
    }
  }

  observeCommodityGroudList(List<ContractGroupList>? array) {
    first = 0;
    height = 0;
    marketFirstArray = getMarketFirstArray(array?.map((e) => e.kind ?? '').toList() ?? []);
    tabController = TabController(length: marketFirstArray.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        first = tabController.index;
        chanageHeight();
      }
    });
    getData();
  }

  List<MarketsHomeFirstModel> getMarketFirstArray(List<String> array) {
    List<MarketsHomeFirstModel> firstArr = [];
    for (var i = 1; i < array.length; i++) {
      var type = array[i];
      for (MarketHomeFirstType firstType in MarketHomeFirstType.values) {
        if (firstType.typeName == type) {
          firstArr.add(MarketsHomeFirstModel(firstType, this, array, () => chanageHeight()));
          break;
        }
      }
    }
    if (UserGetx.to.isLogin) {
      firstArr.insert(0, MarketsHomeFirstModel(MarketHomeFirstType.optional, this, array, () => chanageHeight()));
    }
    return firstArr;
  }

  getData() {
    var commodityGroudList = MarketDataManager.instance.commodityGroudList?.map((e) => e.contractList).toList();
    for (var j = 0; j < marketFirstArray.length; j++) {
      if (marketFirstArray[j].firsttype == MarketHomeFirstType.optional) {
        getOptionList();
      } else {
        var secondModel = marketFirstArray[j].marketSecondArray[0];
        var index = marketFirstArray.length == commodityGroudList!.length - 1 ? j + 1 : j;
        var commoditArr = commodityGroudList[index];
        List<ContractInfo> array = List.from(commoditArr!);
        secondModel.rxModel.commodityList = getSubArray(array, marketFirstArray[j].firsttype);
      }
    }
    chanageHeight();
  }

  chanageHeight() {
    var firstType = marketFirstArray[first].firsttype;
    if (firstType == MarketHomeFirstType.optional) {
      var thiredArr = marketFirstArray[0].marketSecondArray[0].marketThirdArray;
      var thirdIndex = marketFirstArray[0].marketSecondArray[0].thiredCurrentIndex.value;
      var show = thiredArr[thirdIndex].showOptional.value;
      int length = thiredArr[thirdIndex].rxModel.commodityList!.length;
      height = show ? (length / 2.0).ceil() * 98.w + 220.w : (length * 54.w + (length > 3 ? 116.w : 60.w));

      // print(
      // 'hhhhhhh------ show:$show---${(thiredArr[thirdIndex].rxModel.commodityList!.length / 2.0).ceil()}------height:$height-----${thiredArr[thirdIndex].rxModel.commodityList!.isEmpty}');
    } else {
      var model = marketFirstArray[first].marketSecondArray[0];
      // var thirdIndex = marketFirstArray[first].marketSecondArray[0].thiredCurrentIndex.value;
      var array = model.rxModel.commodityList;
      height = array?.isNotEmpty == true ? array!.length * 54.w + (array.length > 3 ? 116.w : 70.w) : 220.w;
    }
    update();
  }

  getOptionList({bool canUpdate = false}) {
    var commodityGroudList = MarketDataManager.instance.commodityGroudList?.map((e) => e.contractList).toList();
    var thiredArr = marketFirstArray[0].marketSecondArray[0].marketThirdArray;
    for (var i = 0; i < thiredArr.length; i++) {
      var commoditArr = commodityGroudList![i];

      var optionArray = CommodityOptionController.to.optionContractList;
      var coinIdArray = commoditArr?.map((e) => e.id).toList();

      List<ContractInfo> filterRecomend = [];
      List<ContractInfo> resArray = optionArray
          .where((id) => coinIdArray!.contains(id))
          .map((id) => commoditArr!.firstWhere(((element) => element.id == id)))
          .toList();

      if (resArray.isEmpty) {
        var recomenndArray = CommodityOptionController.to.recommendContractList;
        filterRecomend = recomenndArray
            .where((id) => coinIdArray!.contains(id))
            .map((id) => commoditArr!.firstWhere(((element) => element.id == id)))
            .toList();
        filterRecomend = filterRecomend.isNotEmpty ? filterRecomend : commoditArr!;
      }

      // var optionArray = CommodityOptionController.to.optionContractList;
      // var recomenndArray = CommodityOptionController.to.recommendContractList;
      // List<ContractInfo> resArray = commoditArr?.where((element) => optionArray.contains(element.id)).toList() ?? [];

      // List<ContractInfo> filterRecomend = [];

      // if (thiredArr[i].thirdType == MarketHomeThirdType.all) {
      //   filterRecomend = recomenndArray.map((id) => commoditArr!.firstWhere((element) => element.id == id)).toList();
      // } else {
      //   filterRecomend = commoditArr?.where((element) => recomenndArray.contains(element.id)).toList() ?? [];
      // }

      thiredArr[i].rxModel.commodityList = resArray.isNotEmpty
          ? getSubArray(resArray, MarketHomeFirstType.optional)
          : getSubArray(filterRecomend, MarketHomeFirstType.optional);
      thiredArr[i].showOptional.value = resArray.isEmpty;
    }
    if (canUpdate) chanageHeight();
  }

  List<ContractInfo> getSubArray(List<ContractInfo>? array, MarketHomeFirstType firstType) {
    // switch (firstType) {
    //   case MarketHomeFirstType.hot:
    //     array?.sort((a, b) => a.sort.compareTo(b.sort));

    //     break;
    //   case MarketHomeFirstType.riseList:
    //     array?.sort((a, b) => double.parse(b.rose).compareTo(double.parse(a.rose)));

    //     break;
    //   case MarketHomeFirstType.fallList:
    //     array?.sort((a, b) => double.parse(a.rose).compareTo(double.parse(b.rose)));

    //     break;
    //   case MarketHomeFirstType.volume:
    //     array?.sort((a, b) => double.parse(a.vol).compareTo(double.parse(b.vol)));

    //     break;

    //   default:
    // }

    return array != null
        ? array.length > 6
            ? array.sublist(0, 6)
            : array
        : [];
  }

  addOptional(List<RxBool> array, MarketSecondType secondType) {
    List<ContractInfo> tempArray = [];
    var secondModel = marketFirstArray[0].marketSecondArray[0];
    var index = secondModel.thiredCurrentIndex.value;
    var model = secondModel.marketThirdArray[index];
    var list = model.rxModel.commodityList!;
    for (var i = 0; i < array.length; i++) {
      if (array[i].value) {
        tempArray.add(list[i]);
      }
    }

    MarketDataManager.instance
        .saveFavouriteTicker(tempArray.map((e) => e.id.toString()).toList(), type: MarketSecondType.standardContract)
        .then((value) {
      model.rxModel.commodityList = tempArray;
      model.showOptional.value = !value;
      for (var i = 0; i < array.length; i++) {
        array[i].value = true;
      }
      chanageHeight();
    });
    // }
  }

  void updatEditSymbol(MarketSecondType type, bool showOptional,
      {List<ContractInfo>? contract, List<MarketInfoModel>? market}) {
    // if (type == MarketSecondType.perpetualContract) {
    //   var model = marketFirstArray[0].marketSecondArray[1];
    //   model.rxModel.contractList = contract;
    //   model.secondShowOptional.value = showOptional;
    //   model.rxModel.update();
    // } else if (type == MarketSecondType.spot) {
    //   var model = marketFirstArray[0].marketSecondArray[2];
    //   model.rxModel.marketList = market;
    //   model.secondShowOptional.value = showOptional;
    //   model.rxModel.update();
    // } else {
    getOptionList(canUpdate: true);
    // }
  }

  filterTicker(MarketsHomeFirstModel firstModel, MarketsHomeSecondModel secondModel, MarketsHomeThirdModel? thiredModel,
      int index, MarketFourFilter type) {
    if (type == MarketFourFilter.defaultFilter) {
      if (firstModel.firsttype == MarketHomeFirstType.optional) {
        secondModel.rxModel.commodityList?.sort((a, b) => a.index.compareTo(b.index));
        secondModel.rxModel.update();
      } else {
        secondModel.rxModel.commodityList?.sort((a, b) => a.sort.compareTo(b.sort));
        secondModel.rxModel.update();
      }
    } else {
      switch (index) {
        case 0:
          if (type == MarketFourFilter.upFilter) {
            secondModel.rxModel.commodityList?.sort((a, b) => a.contractOtherName.compareTo(b.contractOtherName));
          } else {
            secondModel.rxModel.commodityList?.sort((a, b) => b.contractOtherName.compareTo(a.contractOtherName));
          }
          secondModel.rxModel.update();

          break;
        case 1:
          if (type == MarketFourFilter.upFilter) {
            secondModel.rxModel.commodityList?.sort((a, b) => double.parse(a.vol).compareTo(double.parse(b.vol)));
          } else {
            secondModel.rxModel.commodityList?.sort((a, b) => double.parse(b.vol).compareTo(double.parse(a.vol)));
          }
          secondModel.rxModel.update();

          break;
        case 2:
          if (type == MarketFourFilter.upFilter) {
            secondModel.rxModel.commodityList?.sort((a, b) => double.parse(a.close).compareTo(double.parse(b.close)));
          } else {
            secondModel.rxModel.commodityList?.sort((a, b) => double.parse(b.close).compareTo(double.parse(a.close)));
          }
          secondModel.rxModel.update();

          break;

        default:
          if (type == MarketFourFilter.upFilter) {
            secondModel.rxModel.commodityList?.sort((a, b) => double.parse(a.rose).compareTo(double.parse(b.rose)));
          } else {
            secondModel.rxModel.commodityList?.sort((a, b) => double.parse(b.rose).compareTo(double.parse(a.rose)));
          }
          secondModel.rxModel.update();
      }
    }
  }
  // void refreshMarket(MarketSecondType type) {
  //   var commodityGroudList = MarketDataManager.instance.commodityGroudList?.map((e) => e.contractList).toList();
  //   for (var i = 0; i < marketFirstArray.length; i++) {
  //     var firstType = marketFirstArray[i].firsttype;
  //     if (firstType == MarketHomeFirstType.hot) {
  //       getHotList(i, canUpdate: true);
  //     } else
  //     {
  //       if (firstType != MarketHomeFirstType.optional) {
  //         var thiredArr = marketFirstArray[i].marketSecondArray[0].marketThirdArray;
  //         var thirdIndex = marketFirstArray[i].marketSecondArray[0].thiredCurrentIndex.value;
  //         if (thirdIndex < thiredArr.length) {
  //           List<ContractInfo> commoditArr = List.from(commodityGroudList![thirdIndex]!);
  //           thiredArr[thirdIndex].rxModel.commodityList = getSubArray(commoditArr, firstType);
  //           thiredArr[thirdIndex].rxModel.update();
  //         }
  //       }
  //     }
  //   }
  // }

  // getHotList(int j, {bool canUpdate = false}) {
  //   var commodityGroudList = MarketDataManager.instance.commodityGroudList?.map((e) => e.contractList).toList();
  //   var thiredArr = marketFirstArray[j].marketSecondArray[0].marketThirdArray;
  //   for (var i = 0; i < thiredArr.length; i++) {
  //     var commoditArr = commodityGroudList![i];
  //     List<String>? recomenndArray = MarketDataManager.instance.hotSymbolArray;

  //     List<ContractInfo>? resArray = recomenndArray == null
  //         ? null
  //         : commoditArr?.where((element) => recomenndArray.contains(element.contractName)).toList();

  //     print('hhhhhhhhhh---------type:${thiredArr[i].thirdType}----->个数:${resArray.length}');
  //     thiredArr[i].rxModel.commodityList = resArray == null
  //         ? null
  //         : resArray.isNotEmpty
  //             ? getSubArray(resArray, MarketHomeFirstType.hot)
  //             : [];
  //     if (canUpdate) thiredArr[i].rxModel.update();
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
  }
}
