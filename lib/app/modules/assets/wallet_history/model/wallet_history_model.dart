import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_enum.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//
class WalletHistoryFilterModel {
  WalletHistoryType type;
  String? leftText;
  String? leftTime;
  Rx<String?> transferTypeFrom =
      Rx<String?>('wallet'); // 默认现货 // 默认应为null 但 后台未按约定 处理null值初始状态
  Rx<String?> transferTypeTo =
      Rx<String?>('follow'); //默认跟单 // 默认应为null 但 后台未按约定 处理null值状态
  String timeTitle = '';
  RxBool isFirst = true.obs;
  Rx<MyPageLoadingController> loadingController = MyPageLoadingController().obs;
  RefreshController refreshVc = RefreshController();

  //筛选状态
  RxList<WalletHistoryFilterArrayModel> actionArray = RxList();
  RxInt actionArrayIndex = 0.obs;
  //当前选中的状态
  WalletHistoryFilterArrayModel get currentAction {
    if (actionArray.isNotEmpty) {
      return actionArray[actionArrayIndex.toInt()];
    }
    return WalletHistoryFilterArrayModel(name: '', id: '');
  }

  // 币种
  List<AssetSpotsAllCoinMapModel> tradeCoinList = [];
  RxInt coinIndex = 0.obs;
  Rx<AssetSpotsAllCoinMapModel> get coin {
    var list = tradeCoinList;
    if (list.isNotEmpty) {
      return tradeCoinList[coinIndex.toInt()].obs;
    } else {
      return AssetSpotsAllCoinMapModel().obs;
    }
  }

  // 交易币对
  RxInt coinPairIndex = 0.obs;
  Rx<MarketInfoModel> get coinPair {
    var list = AssetsGetx.to.coinPairList;
    if (list.isNotEmpty) {
      return AssetsGetx.to.coinPairList[coinPairIndex.toInt()].obs;
    } else {
      return MarketInfoModel().obs;
    }
  }

// 开始结束时间
  Rx<DateTime> startTime = MyTimeUtil.old(90).obs;
  Rx<DateTime> endTime = MyTimeUtil.now().obs;

  WalletHistoryBottomType bottomType = WalletHistoryBottomType.defaultView;

  WalletHistoryFilterModel(this.type) {
    switch (type) {
      case WalletHistoryType.topUp:
        tradeCoinList.addAll(AssetsGetx
            .to.assetSpotsList); // 将assetSpotsList中的数据添加到tradeCoinList中
        tradeCoinList.insert(
            0,
            AssetSpotsAllCoinMapModel(
                coinName: LocaleKeys.assets108.tr)); // 在tradeCoinList的开头插入新记录
        leftText = LocaleKeys.assets109.tr;
        actionArray.value = [
          WalletHistoryFilterArrayModel(name: LocaleKeys.assets108.tr, id: ''),
          WalletHistoryFilterArrayModel(name: LocaleKeys.assets110.tr, id: '1'),
          WalletHistoryFilterArrayModel(name: LocaleKeys.assets111.tr, id: '0'),
          WalletHistoryFilterArrayModel(name: LocaleKeys.assets116.tr, id: '2')
        ];
        break;
      case WalletHistoryType.withdrawal:
        tradeCoinList.addAll(AssetsGetx
            .to.assetSpotsList); // 将assetSpotsList中的数据添加到tradeCoinList中
        tradeCoinList.insert(
            0,
            AssetSpotsAllCoinMapModel(
                coinName: LocaleKeys.assets108.tr)); // 在tradeCoinList的开头插入新记录

        bottomType = WalletHistoryBottomType.selectView;
        actionArray.value = [
          WalletHistoryFilterArrayModel(name: LocaleKeys.assets108.tr, id: ''),
          WalletHistoryFilterArrayModel(name: LocaleKeys.assets114.tr, id: '1'),
          WalletHistoryFilterArrayModel(name: LocaleKeys.assets115.tr, id: '2'),
          WalletHistoryFilterArrayModel(name: LocaleKeys.assets116.tr, id: '3'),
        ];
        break;
      case WalletHistoryType.spotTrading:
        bottomType = WalletHistoryBottomType.selectView;
        actionArray.value = [
          WalletHistoryFilterArrayModel(name: LocaleKeys.assets108.tr, id: ''),
          WalletHistoryFilterArrayModel(
              name: LocaleKeys.assets117.tr, id: 'BUY'),
          WalletHistoryFilterArrayModel(
              name: LocaleKeys.assets118.tr, id: 'SELL'),
        ];
        break;
      case WalletHistoryType.transfer:
        // actionArray.value = [
        //   WalletHistoryFilterArrayModel(name: LocaleKeys.assets108.tr, id: ''),
        //   WalletHistoryFilterArrayModel(
        //       name: LocaleKeys.assets94.tr, id: 'wallet'),
        //   WalletHistoryFilterArrayModel(
        //       name: LocaleKeys.assets76.tr, id: 'contract'),
        //   WalletHistoryFilterArrayModel(
        //       name: LocaleKeys.assets56.tr, id: 'follow'),
        //   WalletHistoryFilterArrayModel(
        //       name: LocaleKeys.assets75.tr, id: 'standard'),
        // ];

        bottomType = WalletHistoryBottomType.selectView;
        break;
      case WalletHistoryType.conver:
      case WalletHistoryType.withdrawal:
        tradeCoinList.addAll(AssetsGetx
            .to.assetSpotsList); // 将assetSpotsList中的数据添加到tradeCoinList中
        tradeCoinList.insert(
            0,
            AssetSpotsAllCoinMapModel(
                coinName: LocaleKeys.assets108.tr)); // 在tradeCoinList的开头插入新记录
        break;
      default:
        leftTime = LocaleKeys.assets119.tr;
        bottomType = WalletHistoryBottomType.selEndTimeView;
    }
  }

  WalletHistoryFilterModel clone() {
    return WalletHistoryFilterModel(type)
      ..leftText = leftText
      ..leftTime = leftTime
      ..timeTitle = timeTitle
      ..isFirst = isFirst.value.obs
      ..refreshVc = RefreshController(initialRefresh: refreshVc.initialRefresh)
      ..actionArray = RxList<WalletHistoryFilterArrayModel>.from(
          actionArray.map((item) =>
              WalletHistoryFilterArrayModel(name: item.name, id: item.id)))
      ..actionArrayIndex = actionArrayIndex.value.obs
      ..coinIndex = coinIndex.value.obs
      ..coinPairIndex = coinPairIndex.value.obs
      ..startTime = startTime.value.obs
      ..endTime = endTime.value.obs
      ..bottomType = bottomType
      ..transferTypeFrom = transferTypeFrom.value.obs
      ..transferTypeTo = transferTypeTo.value.obs;
  }

  void updateFrom(WalletHistoryFilterModel other) {
    leftText = other.leftText;
    leftTime = other.leftTime;
    timeTitle = other.timeTitle;
    isFirst.value = other.isFirst.value;
    // refreshVc = other.refreshVc;
    actionArray.assignAll(other.actionArray.toList());
    actionArrayIndex.value = other.actionArrayIndex.value;
    coinIndex.value = other.coinIndex.value;
    coinPairIndex.value = other.coinPairIndex.value;
    startTime.value = other.startTime.value;
    endTime.value = other.endTime.value;
    bottomType = other.bottomType;
    transferTypeFrom.value = other.transferTypeFrom.value;
    transferTypeTo.value = other.transferTypeTo.value;
  }
}

class WalletHistoryFilterArrayModel {
  String name;
  String id;

  WalletHistoryFilterArrayModel({required this.name, required this.id});
}
