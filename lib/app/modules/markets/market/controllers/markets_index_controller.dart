import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_emum.dart';
import 'package:nt_app_flutter/app/modules/markets/market/model/markets_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/community_util.dart';

class MarketsIndexController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  List<MarketsFirstModel> marketFirstArray = [];
  int first = 0;
  bool? isError;
  bool isInit =false;
  @override
  void onInit() {
    super.onInit();
    MarketDataManager.instance.onchangeuser = getGroupList;
    MarketDataManager.instance.onUpdateEditSymbol = updatEditSymbol;
    MarketDataManager.instance.changeIndex = changeIndex;
  }

  @override
  void onReady() {
    super.onReady();
    getGroupList();
  }

  getGroupList() {
    Future.delayed(const Duration(seconds: 6), () {
      isError = MarketDataManager.instance.commodityGroudList?.isNotEmpty != true;
      if (isError!) update();
    });

    var commodityGroudList = MarketDataManager.instance.commodityGroudList;
    if (commodityGroudList != null) {
      observeCommodityGroudList(commodityGroudList);
    } else {
      MarketDataManager.instance.onObserveCommodityGroup = observeCommodityGroudList;
    }
  }

  List<List<String>> getTabNameArray(List<ContractGroupList>? array) {
    //    var thirdTabNameArray = array?.map((e) => e.kind ?? '').toList() ?? [];

    List<String> firstArr = [];
    List<String> lastArr = ['STOCK-ALL'];

    array?.forEach((e) {
      var kind = e.kind ?? '';
      firstArr.add(kind);
      if (kind == 'B_1') {
        var contractArr = e.contractList ?? [];
        for (var model in contractArr) {
          if (!lastArr.contains(model.market)) {
            lastArr.add(model.market);
          }
        }
      }
    });

    return [firstArr, lastArr];
  }

  observeCommodityGroudList(List<ContractGroupList>? array) {
    var thirdTabNameArray = getTabNameArray(array);

    marketFirstArray = [
      MarketsFirstModel(MarketFirstType.market, this, thirdTabNameArray, () => getData()),
      MarketsFirstModel(MarketFirstType.community, this, [], null)
    ];
    if (UserGetx.to.isLogin) {
      marketFirstArray = [
        MarketsFirstModel(MarketFirstType.optional, this, thirdTabNameArray, () => getData()),
        ...marketFirstArray
      ];
    }

    tabController = TabController(length: marketFirstArray.length, vsync: this);
    tabController.addListener(() {
      MyCommunityUtil.showSocialMenu.value = false;

      if (!tabController.indexIsChanging) {
        first = tabController.index;
        MyCommunityUtil.showSocialMenu.value = tabController.index == 2;
        if (first < 2) getData();
      }
    });
    isInit = true;
    tabController.index = MarketDataManager.instance.currentIndex == null
        ? 0
        : MarketDataManager.instance.currentIndex! == -1
            ? marketFirstArray.length - 1
            : MarketDataManager.instance.currentIndex!;

    first = tabController.index;
    getData();
    update();
  }

  getData() {
    int second = marketFirstArray[first].secondIndex;
    var firstType = marketFirstArray[first].firsttype;
    var secondType = marketFirstArray[first].marketSecondArray[second].secondType;

    if (secondType == MarketSecondType.standardContract) {
      getCommodityList();
    } else {
      getContractMarketData(firstType, second);
    }
  }

  getCommodityList() {
    var commodityGroudList = MarketDataManager.instance.commodityGroudList?.map((e) => e.contractList).toList();
    for (var j = 0; j < marketFirstArray.length; j++) {
      var firstType = marketFirstArray[j].firsttype;

      var thiredArr = marketFirstArray[j].marketSecondArray[0].marketThirdArray;
      for (var i = 0; i < thiredArr.length; i++) {
        var commoditArr = commodityGroudList![i];

        if (firstType == MarketFirstType.optional) {
          updateOptionCommodityList();
          // var optionArray = CommodityOptionController.to.optionContractList;
          // var coinIdArray = commoditArr?.map((e) => e.id).toList();

          // List<ContractInfo> filterRecomend = [];

          // // List<ContractInfo> resArray = commoditArr?.where((element) => optionArray.contains(element.id)).toList() ?? [];

          // List<ContractInfo> resArray = optionArray
          //     .where((id) => coinIdArray!.contains(id))
          //     .map((id) => commoditArr!.firstWhere(((element) => element.id == id)))
          //     .toList();

          // if (resArray.isEmpty) {
          //   var recomenndArray = CommodityOptionController.to.recommendContractList;
          //   filterRecomend = recomenndArray
          //       .where((id) => coinIdArray!.contains(id))
          //       .map((id) => commoditArr!.firstWhere(((element) => element.id == id)))
          //       .toList();
          //   filterRecomend = filterRecomend.isNotEmpty ? filterRecomend : commoditArr!;
          // }
          // // if (thiredArr[i].thirdType == MarketThirdType.all) {
          // // var aaa = recomenndArray.map((id) => commoditArr?.firstWhere((element) => element.id == id)).toList();

          // // filterRecomend = recomenndArray.map((id) => commoditArr!.firstWhere((element) => element.id == id)).toList();

          // // } else {
          // //   filterRecomend = commoditArr?.where((element) => recomenndArray.contains(element.id)).toList() ?? [];
          // // }
          // var thirdModel = thiredArr[i];
          // var commodityList = resArray.isNotEmpty ? resArray : filterRecomend;

          // if (thirdModel.thirdType == MarketThirdType.stocks) {
          //   for (var fourModel in thirdModel.marketFourArray) {
          //     if (fourModel.fourType == MarketFourType.stockAll) {
          //       fourModel.rxModel.commodityList = commodityList;
          //       fourModel.showOptional.value = resArray.isEmpty;
          //     } else {
          //       fourModel.rxModel.commodityList =
          //           commodityList.where((element) => element.market == fourModel.fourType.typeName).toList();
          //       fourModel.showOptional.value =
          //           resArray.where((element) => element.market == fourModel.fourType.typeName).toList().isEmpty;
          //     }
          //     fourModel.rxModel.update();
          //   }
          // } else {
          //   if (thirdModel.thirdType == MarketThirdType.all) {
          //     for (var i = 0; i < commodityList.length; i++) {
          //       var model = commodityList[i];
          //       model.index = i;
          //     }
          //   }

          //   thirdModel.rxModel.commodityList = commodityList;
          //   thirdModel.showOptional.value = resArray.isEmpty;
          //   thirdModel.rxModel.update();
          // }
        } else {
          var thirdModel = thiredArr[i];
          if (thirdModel.thirdType == MarketThirdType.stocks) {
            for (var fourModel in thirdModel.marketFourArray) {
              if (fourModel.fourType == MarketFourType.stockAll) {
                fourModel.rxModel.commodityList = commoditArr;
                fourModel.rxModel.update();
              } else {
                var array = commoditArr?.where((element) => element.market == fourModel.fourType.typeName).toList();
                fourModel.rxModel.commodityList = array;
                fourModel.rxModel.update();
              }
            }
          } else {
            thirdModel.rxModel.commodityList = commoditArr;
            thirdModel.rxModel.update();
          }
        }
      }
    }
  }

  updateOptionCommodityList() {
    for (var j = 0; j < marketFirstArray.length; j++) {
      if (marketFirstArray[j].firsttype == MarketFirstType.optional) {
        var thiredArr = marketFirstArray[j].marketSecondArray[0].marketThirdArray;
        var commodityGroudList = MarketDataManager.instance.commodityGroudList?.map((e) => e.contractList).toList();

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

          var thirdModel = thiredArr[i];
          var commodityList = resArray.isNotEmpty ? resArray : filterRecomend;

          if (thirdModel.thirdType == MarketThirdType.stocks) {
            for (var fourModel in thirdModel.marketFourArray) {
              if (fourModel.fourType == MarketFourType.stockAll) {
                fourModel.rxModel.commodityList = commodityList;
                fourModel.showOptional.value = resArray.isEmpty;
              } else {
                var usresArray = resArray.where((element) => element.market == fourModel.fourType.typeName).toList();
                List<ContractInfo> usfilterRecomend = [];

                if (usresArray.isEmpty) {
                  var recomenndArray = CommodityOptionController.to.recommendContractList;
                  usfilterRecomend = recomenndArray
                      .where((id) => coinIdArray!.contains(id))
                      .map((id) => commoditArr!.firstWhere(((element) => element.id == id)))
                      .where((element) => element.market == fourModel.fourType.typeName)
                      .toList();

                  usfilterRecomend = usfilterRecomend.isNotEmpty
                      ? usfilterRecomend
                      : commoditArr!.where((element) => element.market == fourModel.fourType.typeName).toList();
                }

                fourModel.rxModel.commodityList = usresArray.isNotEmpty ? usresArray : usfilterRecomend;

                fourModel.showOptional.value = usresArray.isEmpty;
              }
              fourModel.rxModel.update();
            }
          } else {
            if (thirdModel.thirdType == MarketThirdType.all) {
              for (var i = 0; i < commodityList.length; i++) {
                var model = commodityList[i];
                model.index = i;
              }
            }

            thirdModel.rxModel.commodityList = commodityList;
            thirdModel.showOptional.value = resArray.isEmpty;
            thirdModel.rxModel.update();
          }
        }
      }
    }
  }

  // updateOptionCommodityList() {
  //   var commodityGroudList = MarketDataManager.instance.commodityGroudList?.map((e) => e.contractList).toList();
  //   for (var j = 0; j < marketFirstArray.length; j++) {
  //     var firstType = marketFirstArray[j].firsttype;

  //     if (firstType == MarketFirstType.optional) {
  //       var thiredArr = marketFirstArray[j].marketSecondArray[0].marketThirdArray;
  //       for (var i = 0; i < thiredArr.length; i++) {
  //         var commoditArr = commodityGroudList![i];
  //         var optionArray = CommodityOptionController.to.optionContractList;
  //         var recomenndArray = CommodityOptionController.to.recommendContractList;
  //         List<ContractInfo> resArray = commoditArr?.where((element) => optionArray.contains(element.id)).toList() ?? [];
  //         var filterRecomend = commoditArr?.where((element) => recomenndArray.contains(element.id)).toList() ?? [];

  //         // var commodityList = resArray.isNotEmpty ? resArray : filterRecomend;

  //         var thirdModel = thiredArr[i];
  //         var commodityList = resArray.isNotEmpty ? resArray : filterRecomend;

  //         if (thirdModel.thirdType == MarketThirdType.stocks) {
  //           for (var fourModel in thirdModel.marketFourArray) {
  //             if (fourModel.fourType == MarketFourType.stockAll) {
  //               fourModel.rxModel.commodityList = commodityList;
  //               fourModel.showOptional.value = resArray.isEmpty;
  //             } else {
  //               fourModel.rxModel.commodityList =
  //                   commodityList.where((element) => element.market == fourModel.fourType.typeName).toList();
  //               fourModel.showOptional.value =
  //                   resArray.where((element) => element.market == fourModel.fourType.typeName).toList().isEmpty;
  //             }
  //             fourModel.rxModel.update();
  //           }
  //         } else {
  //           if (thirdModel.thirdType == MarketThirdType.all) {
  //             for (var i = 0; i < commodityList.length; i++) {
  //               var model = commodityList[i];
  //               model.index = i;
  //             }
  //           }

  //           // if (thiredArr[i].thirdType == MarketThirdType.all) {
  //           //   for (var i = 0; i < commodityList.length; i++) {
  //           //     var model = commodityList[i];
  //           //     model.index = i;
  //           //   }
  //           // }

  //           // thiredArr[i].rxModel.commodityList = commodityList;
  //           // thiredArr[i].showOptional.value = resArray.isEmpty;
  //           // thiredArr[i].rxModel.update();

  //           thirdModel.rxModel.commodityList = commodityList;
  //           thirdModel.showOptional.value = resArray.isEmpty;
  //           thirdModel.rxModel.update();
  //         }
  //       }
  //     }
  //   }
  // }

  getContractMarketData(MarketFirstType firstType, int second) {
    var model = marketFirstArray[first].marketSecondArray[second];
    if (model.secondType == MarketSecondType.perpetualContract) {
      if (model.rxModel.contractList != null) {
        model.rxModel.update();
      } else {
        MarketDataManager.instance.getPublicInfo((showOptional, value) {
          model.rxModel.contractList = value;
          model.secondShowOptional.value = showOptional;
          model.rxModel.update();
        }, isOptional: firstType == MarketFirstType.optional);
      }
    } else {
      if (model.rxModel.marketList != null) {
        model.rxModel.update();
      } else {
        MarketDataManager.instance.getPublicInfoMarket((showOptional, value) {
          model.rxModel.marketList = value;
          model.secondShowOptional.value = showOptional;
          model.rxModel.update();
        }, isOptional: firstType == MarketFirstType.optional);
      }
    }
  }

  addOptional(List<RxBool> array, MarketSecondType secondType) {
    if (secondType == MarketSecondType.perpetualContract) {
      List<ContractInfo> tempArray = [];
      // var list1 = MarketDataManager.instance.cellModel.contractList!;

      var model = marketFirstArray[0].marketSecondArray[1];
      var list = model.rxModel.contractList!;
      for (var i = 0; i < array.length; i++) {
        if (array[i].value) {
          tempArray.add(list[i]);
        }
      }

      MarketDataManager.instance
          .saveFavouriteTicker(tempArray.map((e) => e.id.toString()).toList(), type: MarketSecondType.perpetualContract)
          .then((value) {
        // var model = marketFirstArray[0].marketSecondArray[1];
        model.rxModel.contractList = tempArray;
        model.secondShowOptional.value = !value;
        for (var i = 0; i < array.length; i++) {
          array[i].value = true;
        }
      });
    } else if (secondType == MarketSecondType.spot) {
      List<MarketInfoModel> tempArray = [];
      // var list = MarketDataManager.instance.cellModel.marketList!;
      var model = marketFirstArray[0].marketSecondArray[2];
      var list = model.rxModel.marketList!;

      for (var i = 0; i < array.length; i++) {
        if (array[i].value) {
          tempArray.add(list[i]);
        }
      }

      MarketDataManager.instance
          .saveFavouriteTicker(tempArray.map((e) => e.symbol).toList(), type: MarketSecondType.spot)
          .then((value) {
        // var model = marketFirstArray[0].marketSecondArray[2];
        model.rxModel.marketList = tempArray;
        model.secondShowOptional.value = !value;
        for (var i = 0; i < array.length; i++) {
          array[i].value = true;
        }
      });
    } else {
      List<ContractInfo> tempArray = [];
      List<ContractInfo> list = [];

      int thirdIndex = marketFirstArray[0].thirdIndex;
      var model = marketFirstArray[0].marketSecondArray[0].marketThirdArray[thirdIndex];

      if (model.thirdType == MarketThirdType.stocks) {
        int fourIndex = marketFirstArray[0].fourIndex;
        var fourModel = model.marketFourArray[fourIndex];
        list = fourModel.rxModel.commodityList!;
      } else {
        list = model.rxModel.commodityList!;
      }
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
      });
    }
  }

  filterTicker(MarketsFirstModel firstModel, MarketsSecondModel secondModel, MarketsThirdModel? thiredModel,
      MarketsFourModel? fourModel, int index, MarketFourFilter type) {
    if (type == MarketFourFilter.defaultFilter) {
      if (firstModel.firsttype == MarketFirstType.optional) {
        if (fourModel != null) {
          fourModel.rxModel.commodityList?.sort((a, b) => a.index.compareTo(b.index));
          fourModel.rxModel.update();
        } else if (thiredModel != null) {
          thiredModel.rxModel.commodityList?.sort((a, b) => a.index.compareTo(b.index));
          thiredModel.rxModel.update();
        } else {
          if (secondModel.secondType == MarketSecondType.perpetualContract) {
            secondModel.rxModel.contractList?.sort((a, b) => a.index.compareTo(b.index));
          } else {
            secondModel.rxModel.marketList?.sort((a, b) => a.index.compareTo(b.index));
          }
          secondModel.rxModel.update();
        }
      } else {
        if (fourModel != null) {
          fourModel.rxModel.commodityList?.sort((a, b) => a.index.compareTo(b.index));
          fourModel.rxModel.update();
        } else if (thiredModel != null) {
          thiredModel.rxModel.commodityList?.sort((a, b) => a.sort.compareTo(b.sort));
          thiredModel.rxModel.update();
        } else {
          if (secondModel.secondType == MarketSecondType.perpetualContract) {
            secondModel.rxModel.contractList?.sort((a, b) => a.sort.compareTo(b.sort));
          } else {
            secondModel.rxModel.marketList?.sort((a, b) => a.sort.compareTo(b.sort));
          }
          secondModel.rxModel.update();
        }
      }
    } else {
      switch (index) {
        case 0:
          if (fourModel != null) {
            if (type == MarketFourFilter.upFilter) {
              fourModel.rxModel.commodityList?.sort((a, b) => a.contractOtherName.compareTo(b.contractOtherName));
            } else {
              fourModel.rxModel.commodityList?.sort((a, b) => b.contractOtherName.compareTo(a.contractOtherName));
            }
            fourModel.rxModel.update();
          } else if (thiredModel != null) {
            if (type == MarketFourFilter.upFilter) {
              thiredModel.rxModel.commodityList?.sort((a, b) => a.contractOtherName.compareTo(b.contractOtherName));
            } else {
              thiredModel.rxModel.commodityList?.sort((a, b) => b.contractOtherName.compareTo(a.contractOtherName));
            }
            thiredModel.rxModel.update();
          } else {
            if (secondModel.secondType == MarketSecondType.perpetualContract) {
              if (type == MarketFourFilter.upFilter) {
                secondModel.rxModel.contractList?.sort((a, b) => a.contractOtherName.compareTo(b.contractOtherName));
              } else {
                secondModel.rxModel.contractList?.sort((a, b) => b.contractOtherName.compareTo(a.contractOtherName));
              }
            } else {
              if (type == MarketFourFilter.upFilter) {
                secondModel.rxModel.marketList?.sort((a, b) => a.showName.compareTo(b.showName));
              } else {
                secondModel.rxModel.marketList?.sort((a, b) => b.showName.compareTo(a.showName));
              }
            }
            secondModel.rxModel.update();
          }
          break;
        case 1:
          if (fourModel != null) {
            if (type == MarketFourFilter.upFilter) {
              fourModel.rxModel.commodityList?.sort((a, b) => a.vol.toDouble().compareTo(b.vol.toDouble()));
            } else {
              fourModel.rxModel.commodityList?.sort((a, b) => b.vol.toDouble().compareTo(a.vol.toDouble()));
            }
            fourModel.rxModel.update();
          } else if (thiredModel != null) {
            if (type == MarketFourFilter.upFilter) {
              thiredModel.rxModel.commodityList?.sort((a, b) => a.vol.toDouble().compareTo(b.vol.toDouble()));
            } else {
              thiredModel.rxModel.commodityList?.sort((a, b) => b.vol.toDouble().compareTo(a.vol.toDouble()));
            }
            thiredModel.rxModel.update();
          } else {
            if (secondModel.secondType == MarketSecondType.perpetualContract) {
              if (type == MarketFourFilter.upFilter) {
                secondModel.rxModel.contractList?.sort((a, b) => a.vol.toDouble().compareTo(b.vol.toDouble()));
              } else {
                secondModel.rxModel.contractList?.sort((a, b) => b.vol.toDouble().compareTo(a.vol.toDouble()));
              }
            } else {
              if (type == MarketFourFilter.upFilter) {
                secondModel.rxModel.marketList?.sort((a, b) => a.vol.toDouble().compareTo(b.vol.toDouble()));
              } else {
                secondModel.rxModel.marketList?.sort((a, b) => b.vol.toDouble().compareTo(a.vol.toDouble()));
              }
            }
            secondModel.rxModel.update();
          }
          break;
        case 2:
          if (fourModel != null) {
            if (type == MarketFourFilter.upFilter) {
              fourModel.rxModel.commodityList?.sort((a, b) => a.close.toDouble().compareTo(b.close.toDouble()));
            } else {
              fourModel.rxModel.commodityList?.sort((a, b) => b.close.toDouble().compareTo(a.close.toDouble()));
            }

            fourModel.rxModel.update();
          } else if (thiredModel != null) {
            if (type == MarketFourFilter.upFilter) {
              thiredModel.rxModel.commodityList?.sort((a, b) => a.close.toDouble().compareTo(b.close.toDouble()));
            } else {
              thiredModel.rxModel.commodityList?.sort((a, b) => b.close.toDouble().compareTo(a.close.toDouble()));
            }

            thiredModel.rxModel.update();
          } else {
            if (secondModel.secondType == MarketSecondType.perpetualContract) {
              if (type == MarketFourFilter.upFilter) {
                secondModel.rxModel.contractList?.sort((a, b) => a.close.toDouble().compareTo(b.close.toDouble()));
              } else {
                secondModel.rxModel.contractList?.sort((a, b) => b.close.toDouble().compareTo(a.close.toDouble()));
              }
            } else {
              if (type == MarketFourFilter.upFilter) {
                secondModel.rxModel.marketList?.sort((a, b) => a.close.toDouble().compareTo(b.close.toDouble()));
              } else {
                secondModel.rxModel.marketList?.sort((a, b) => b.close.toDouble().compareTo(a.close.toDouble()));
              }
            }
            secondModel.rxModel.update();
          }
          break;

        default:
          if (fourModel != null) {
            if (type == MarketFourFilter.upFilter) {
              fourModel.rxModel.commodityList?.sort((a, b) => a.rose.toDouble().compareTo(b.rose.toDouble()));
            } else {
              fourModel.rxModel.commodityList?.sort((a, b) => b.rose.toDouble().compareTo(a.rose.toDouble()));
            }

            fourModel.rxModel.update();
          } else if (thiredModel != null) {
            if (type == MarketFourFilter.upFilter) {
              thiredModel.rxModel.commodityList?.sort((a, b) => a.rose.toDouble().compareTo(b.rose.toDouble()));
            } else {
              thiredModel.rxModel.commodityList?.sort((a, b) => b.rose.toDouble().compareTo(a.rose.toDouble()));
            }

            thiredModel.rxModel.update();
          } else {
            if (secondModel.secondType == MarketSecondType.perpetualContract) {
              if (type == MarketFourFilter.upFilter) {
                secondModel.rxModel.contractList?.sort((a, b) => a.rose.toDouble().compareTo(b.rose.toDouble()));
              } else {
                secondModel.rxModel.contractList?.sort((a, b) => b.rose.toDouble().compareTo(a.rose.toDouble()));
              }
            } else {
              if (type == MarketFourFilter.upFilter) {
                secondModel.rxModel.marketList?.sort((a, b) => a.rose.toDouble().compareTo(b.rose.toDouble()));
              } else {
                secondModel.rxModel.marketList?.sort((a, b) => b.rose.toDouble().compareTo(a.rose.toDouble()));
              }
            }
            secondModel.rxModel.update();
          }
      }
    }
  }

  void updatEditSymbol(MarketSecondType type, bool showOptional,
      {List<ContractInfo>? contract, List<MarketInfoModel>? market}) {
    if (type == MarketSecondType.perpetualContract) {
      var secondArr = marketFirstArray[0].marketSecondArray;

      for (var model in secondArr) {
        if (model.secondType == MarketSecondType.perpetualContract) {
          model.rxModel.contractList = contract;
          model.secondShowOptional.value = showOptional;
          model.rxModel.update();
          break;
        }
      }

      // var model = marketFirstArray[0].marketSecondArray[1];

      // model.rxModel.contractList = contract;
      // model.secondShowOptional.value = showOptional;
      // model.rxModel.update();
    } else if (type == MarketSecondType.spot) {
      var secondArr = marketFirstArray[0].marketSecondArray;

      for (var model in secondArr) {
        if (model.secondType == MarketSecondType.spot) {
          model.rxModel.marketList = market;
          model.secondShowOptional.value = showOptional;
          model.rxModel.update();
          break;
        }
      }

      // var model = marketFirstArray[0].marketSecondArray[2];
      // model.rxModel.marketList = market;
      // model.secondShowOptional.value = showOptional;
      // model.rxModel.update();
    } else {
      updateOptionCommodityList();
    }
  }

  changeIndex(String kindStr) {
    tabController.index = MarketDataManager.instance.currentIndex == null
        ? 0
        : MarketDataManager.instance.currentIndex! == -1
            ? marketFirstArray.length - 1
            : MarketDataManager.instance.currentIndex!;
    first = tabController.index;
    var fisrstModel = marketFirstArray[first];
    if (kindStr.isNotEmpty) {
      if (kindStr == 'feature') {
        fisrstModel.tabController.index = 1;
      } else if (kindStr == 'spot') {
        fisrstModel.tabController.index = 2;
      } else {
        fisrstModel.tabController.index = 0;
        fisrstModel.secondIndex = 0;
        var secondModel = fisrstModel.marketSecondArray[0];
        secondModel.changeIndex();
      }
    }
  }

  getMarketData() {
    if (MarketDataManager.instance.commodityGroudList != null) {
      MarketDataManager.instance.callbackData();
    } else {
      CommodityDataStoreController.to.fetchPublicInfo();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}


//  {amount: 347368841.8, close: 97.8, high: 100.31, low: 95.19, open: 97.99, rose: -0.00193897, vol: 3543116}
//  {amount: 37973018.626, close: 10.944, high: 11.011, low: 10.447, open: 10.921, rose: 0.00210603, vol: 3529074}
//  {amount: 117589066.975, close: 33.094, high: 34.09, low: 31.697, open: 33.154, rose: -0.00180974, vol: 3567003}
//  {amount: 3656 6054 2517.7, close: 67693.1, high: 68511.4, low: 66025.6, open: 67814, rose: -0.00178282, vol: 5431725}
//  {amount: 117589066.975, close: 33.099, high: 34.09, low: 31.697, open: 33.154, rose: -0.001658925, vol: 3567063}
//  {amount: 17644972295.97, close: 3322.53, high: 3350.07, low: 3214.25, open: 3319.64, rose: 0.0008705763, vol: 5365481}

//[e_etcusdt, e_solusdt, s_btcusdt, e_btcusdt, e_bnbusdt, e_ethusdt, e_bchusdt, e_uniusdt, e_ltcusdt, e_trxusdt, e_dogeusdt, e_filusdt]


//       'market_e_ethusdt_ticker',
//       'market_e_solusdt_ticker',
//       'market_e_etcusdt_ticker',
//       'market_e_ltcusdt_ticker',
//       'market_e_bnbusdt_ticker',
//       'market_e_bchusdt_ticker',
//       'market_s_btcusdt_ticker',
//       'market_e_dogeusdt_ticker',
//       'market_e_btcusdt_ticker',
//       'market_e_uniusdt_ticker',
//       'market_e_trxusdt_ticker',
//       'market_e_filusdt_ticker'

