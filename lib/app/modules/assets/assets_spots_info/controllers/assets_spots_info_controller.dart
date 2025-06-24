import 'dart:collection';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/public_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/assets/assets_deposit_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spot_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/models/assets/assets_transfer_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_withdraw_record.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots_info/model/asset_trade_model.dart';

import 'package:nt_app_flutter/app/modules/assets/assets_spots_info/model/assets_spots_info_model.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:nt_app_flutter/app/api/community/community.dart';
import 'package:nt_app_flutter/app/models/community/activity.dart';
import 'package:nt_app_flutter/app/models/community/community.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';

class AssetsSpotsHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int currentIndex = 0;
  AssetSpotsAllCoinMapModel data = Get.arguments['data'];
  int spotsIndex = Get.arguments['index'];

  late TabController tabController;
  final RefreshController refreshController = RefreshController();
  final List<String> tabList = [
    LocaleKeys.assets52.tr,
    LocaleKeys.assets64.tr,
    LocaleKeys.assets65.tr,
    LocaleKeys.assets7.tr
  ];
  final List<Rx<AssetsSpotsDetailModel>> dataList =
      List<Rx<AssetsSpotsDetailModel>>.generate(
          4, (index) => AssetsSpotsDetailModel().obs);
  final List<bool> haveMoreLit = List<bool>.generate(4, (index) => false);
  var haveAd = false.obs;
  final RxList<AssetsTradeModel> recommendList = <AssetsTradeModel>[].obs;

  RxList<CmsAdvertListModel?> aDlist = <CmsAdvertListModel?>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
        getListData();
      }
    });
    //广告位接口暂无
    Future.delayed(const Duration(seconds: 2), () {
      haveAd.value = true;
    });

    Bus.getInstance().on(EventType.withdraw, (data) {
      dataList[currentIndex].value.data?.clear();
      getListData();
    });
    Bus.getInstance().on(EventType.changeLang, (data) {
      getCmsAdvertList();
    });
    //获取活动列表
    getCmsAdvertList();
  }

  //获取活动
  getCmsAdvertList() async {
    try {
      CmsAdvertModel? res = await CommunityApi.instance()
          .getCmsAdvertList(ActivityEnumn.assetsSpotsInfo.position, '0');
      if (res != null) {
        aDlist = res.list!.obs;
      }
      update();
    } catch (e) {
      Get.log('error when getCmsAdvertList: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
    getListData();
    getRcomendList();
  }

  getRcomendList() {
    String? coin = data.coinName;
    if (TextUtil.isEmpty(coin)) {
      return;
    }

    LinkedHashMap commodityContractInfoMap =
        CommodityDataStoreController.to.getContractInfoMap();
    for (int key in commodityContractInfoMap.keys) {
      if (commodityContractInfoMap[key]
          ?.contractName
          .toLowerCase()
          .contains(coin!.toLowerCase())) {
        ContractInfo contractInfoModel = commodityContractInfoMap[key];
        recommendList.add(
            AssetsTradeModel(tradetype: 0, contractInfo: contractInfoModel));
        break;
      }
    }
    LinkedHashMap contractInfoMap =
        ContractDataStoreController.to.getContractInfoMap();
    for (String key in contractInfoMap.keys) {
      if (contractInfoMap[key]
          ?.contractName
          .toLowerCase()
          .contains(coin!.toLowerCase())) {
        ContractInfo contractInfoModel = contractInfoMap[key];
        recommendList.add(
            AssetsTradeModel(tradetype: 1, contractInfo: contractInfoModel));
        break;
      }
    }

    LinkedHashMap marketInfoMap = SpotDataStoreController.to.getMarketInfoMap();
    for (String key in marketInfoMap.keys) {
      if (key.contains(coin!.toLowerCase())) {
        MarketInfoModel marketInfoModel = marketInfoMap[key];
        recommendList.add(
            AssetsTradeModel(tradetype: 2, marketInfoModel: marketInfoModel));
        break;
      }
    }
  }

  getListData({bool ismore = false}) async {
    if (currentIndex == 0) {
      var tempArr = dataList[0].value.data;
      if (tempArr != null && tempArr.isNotEmpty && !ismore) return;
      AssetsHistoryRecord? res = await AssetsApi.instance()
          .getWalletHistoryList(
              'deposit', data.coinName ?? '', 50, 1, '', '', '', null);
      if (res?.financeList != null && res!.financeList!.isNotEmpty) {
        var array = res.financeList!
            .map((item) => AssetsSpotsHistoryModel.fromMap({
                  'type': LocaleKeys.assets35.tr,
                  'name':
                      TextUtil.isEmpty(item.statusText) ? "" : item.statusText,
                  'value': item.amount,
                  'time': item.createTime.toString(),
                }))
            .toList();
        dataList[0].update((val) {
          val?.haveMore = array.length == dataList.first.value.pageSize;
          val?.isInitial = false;
          if (ismore) {
            val?.data?.addAll(array);
          } else {
            val?.data = array;
          }
        });
      } else if (res?.financeList != null && res!.financeList!.isEmpty) {
        dataList[0].update((val) {
          val?.haveMore = false;
          val?.data = [];
          val?.isInitial = false;
        });
      }
    } else if (currentIndex == 1) {
      var tempArr = dataList[1].value.data;
      if (tempArr != null && tempArr.isNotEmpty && !ismore) return;
      AssetsHistoryRecord? res = await AssetsApi.instance()
          .getWalletHistoryList(
              'withdraw', data.coinName ?? '', 50, 1, '', '', '', null);
      if (res?.financeList != null && res!.financeList!.isNotEmpty) {
        var array = res.financeList!
            .map((item) => AssetsSpotsHistoryModel.fromMap({
                  'type': LocaleKeys.assets64.tr,
                  'name':
                      TextUtil.isEmpty(item.statusText) ? "" : item.statusText,
                  'value': '-${item.amount}',
                  'time': item.createTime.toString(),
                }))
            .toList();
        dataList[1].update((val) {
          val?.haveMore = array.length == dataList.first.value.pageSize;
          val?.isInitial = false;
          if (ismore) {
            val?.data?.addAll(array);
          } else {
            val?.data = array;
          }
        });
      } else if (res?.financeList != null && res!.financeList!.isEmpty) {
        dataList[1].update((val) {
          val?.haveMore = false;
          val?.data = [];
          val?.isInitial = false;
        });
      }
    } else if (currentIndex == 2) {
      var tempArr = dataList[2].value.data;
      if (tempArr != null && tempArr.isNotEmpty && !ismore) return;
      final AssetsSpotRecord res =
          await AssetsApi.instance().getSpotList('btcusdt', 50, 1);
      var array = res.orderList
          .map((item) => AssetsSpotsHistoryModel.fromMap({
                'type': item.side == 'BUY'
                    ? LocaleKeys.assets65.tr
                    : LocaleKeys.assets66.tr,
                'name':
                    TextUtil.isEmpty(item.statusText) ? "" : item.statusText,
                'value': (item.side == 'BUY' ? '-' : '') + '${item.totalPrice}',
                'time': item.createdAt.toString(),
              }))
          .toList();
      dataList[2].update((val) {
        val?.haveMore = array.length == dataList.first.value.pageSize;
        val?.isInitial = false;
        if (ismore) {
          val?.data?.addAll(array);
        } else {
          val?.data = array;
        }
      });
    } else if (currentIndex == 3) {
      var tempArr = dataList[3].value.data;
      if (tempArr != null && !ismore) return;
      final AssetsTransferRecord res = await AssetsApi.instance()
          .getTransferList(data.coinName ?? '', 50, 1);
      var array = res.financeList
          .map((item) => AssetsSpotsHistoryModel.fromMap({
                'type': item.transactionTypeText,
                'name': '',
                'value':
                    (item.transactionType == 2 ? '-' : '') + '${item.amount}',
                'time': item.createTime.toString(),
              }))
          .toList();
      dataList[3].update((val) {
        val?.haveMore = array.length == dataList.first.value.pageSize;
        val?.isInitial = false;
        if (ismore) {
          val?.data?.addAll(array);
        } else {
          val?.data = array;
        }
      });
    }
  }

  @override
  void onClose() {
    Bus.getInstance().off(EventType.changeLang, (data) {});
    super.onClose();
  }
}
