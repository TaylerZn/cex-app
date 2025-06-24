import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/models/assets/asset_bonus_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_convert_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_deposit_record.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spot_trade_history.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_enum.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_model.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../api/contract/contract_api.dart';

class WalletHistoryListController extends GetxController {
  // final WalletHistoryType currentType;
  // // 接收参数的构造函数
  // WalletHistoryListController({
  //   required this.currentType,
  // });

  late Map<WalletHistoryType, bool> typeMap;

  final RxList<AssetsHistoryRecordItem> depositList = RxList();
  final RxList<AssetsHistoryRecordItem> withdrawalList = RxList();
  final RxList<SpotsTradeHistoryListModel> spotList = RxList();
  final RxList<AssetsHistoryRecordItem> transfertList = RxList();
  final RxList<AssetsHistoryRecordItem> bonusList = RxList();
  final RxList<AssetsConvertRecordItem> convertList = RxList();

  int page = 1;
  int pageSize = 10;
  bool haveMore = false;

  int currentIndex = 0;

  @override
  onInit() {
    typeMap = {
      WalletHistoryType.topUp: false,
      WalletHistoryType.withdrawal: false,
      WalletHistoryType.spotTrading: false,
      WalletHistoryType.transfer: false,
      WalletHistoryType.bonus: false,
    };
    super.onInit();
    // getListData(currentType);
  }

  // onInitFunc(WalletHistoryType currentType) async {
  //   await getListData(currentType);
  //   model.isFirst = false;
  //   model.loadingController.value.setSuccess();
  // }

  getDepositList(WalletHistoryFilterModel model) async {
    if (page == 1) {
      depositList.clear();
    }
    try {
      AssetsHistoryRecord? res = await AssetsApi.instance()
          .getWalletHistoryList(
              'deposit',
              model.coin.value.coinName == LocaleKeys.assets108.tr
                  ? ''
                  : model.coin.value.coinName ?? '',
              pageSize,
              page,
              model.currentAction.id,
              '${model.startTime.value.millisecondsSinceEpoch}',
              '${model.endTime.value.millisecondsSinceEpoch}',
              null);
      if (res != null &&
          res.financeList != null &&
          res.financeList!.isNotEmpty) {
        for (var item in res.financeList ?? []) {
          depositList.add(item);
        }

        haveMore = page == res.pageSize;
        pageLoadingSet(model, MyLoadingStatus.success);
      } else {
        pageLoadingSet(model, MyLoadingStatus.empty);
      }
    } catch (e) {
      print(e);
      Get.log('getDepositList error: $e');
      pageLoadingSet(model, MyLoadingStatus.empty);
    }
  }

  getWithdrawalList(WalletHistoryFilterModel model) async {
    if (page == 1) {
      withdrawalList.clear();
    }
    try {
      AssetsHistoryRecord? res = await AssetsApi.instance()
          .getWalletHistoryList(
              'withdraw',
              model.coin.value.coinName == LocaleKeys.assets108.tr
                  ? ''
                  : model.coin.value.coinName ?? '',
              pageSize,
              page,
              model.currentAction.id,
              '${model.startTime.value.millisecondsSinceEpoch}',
              '${model.endTime.value.millisecondsSinceEpoch}',
              null);
      if (res != null &&
          res.financeList != null &&
          res.financeList!.isNotEmpty) {
        for (var item in res.financeList ?? []) {
          withdrawalList.add(item);
        }
        haveMore = page == res.pageSize;
        pageLoadingSet(model, MyLoadingStatus.success);
      } else {
        pageLoadingSet(model, MyLoadingStatus.empty);
      }
    } catch (e) {
      print(e);
      Get.log('getWithdrawalList error: $e');
      pageLoadingSet(model, MyLoadingStatus.empty);
    }
  }

  //获取现货交易列表
  getTradeListHistory(WalletHistoryFilterModel model) async {
    if (page == 1) {
      spotList.clear();
      model.loadingController.value.setSuccess();
    }
    try {
      print('getSpotList');
      SpotsTradeHistoryModel? res =
          await AssetsApi.instance().getSpotsTradeListHistory(
        model.coinPair.value.symbol,
        model.currentAction.id,
        pageSize,
        page,
        '${model.startTime.value.millisecondsSinceEpoch}',
        '${model.endTime.value.millisecondsSinceEpoch}',
      );

      if (res != null && res.orderList != null && res.orderList!.isNotEmpty) {
        for (var item in res.orderList ?? []) {
          spotList.add(item);
        }
        haveMore = page == res.pageSize;
        pageLoadingSet(model, MyLoadingStatus.success);
      } else {
        pageLoadingSet(model, MyLoadingStatus.empty);
      }
    } catch (e) {
      print(e);
      Get.log('getTradeListHistory error: $e');
      pageLoadingSet(model, MyLoadingStatus.empty);
    }
  }

  //获取划转列表
  getTransferList(WalletHistoryFilterModel model) async {
    if (page == 1) {
      transfertList.clear();
    }

    if (isTransferSpot(model)) {
      await fetchTransferSpotListData(model);
    } else if (isTransferNoSpot(model)) {
      await fetchTransferNoSpotListData(model);
    }
  }

  //获取闪兑订单列表
  getConvertList(WalletHistoryFilterModel model) async {
    if (page == 1) {
      convertList.clear();
    }
    try {
      AssetsConvertRecord? res = await AssetsApi.instance().getQuickOrderList(
        pageSize,
        page,
        model.startTime.value.millisecondsSinceEpoch,
        model.endTime.value.millisecondsSinceEpoch,
        model.coin.value.coinName == LocaleKeys.assets108.tr
            ? ''
            : model.coin.value.coinName ?? '',
      );
      if (res != null &&
          res.financeList != null &&
          res.financeList!.isNotEmpty) {
        for (var item in res.financeList ?? []) {
          convertList.add(item);
        }

        haveMore = page == res.pageSize;
        pageLoadingSet(model, MyLoadingStatus.success);
      } else {
        pageLoadingSet(model, MyLoadingStatus.empty);
      }
    } catch (e) {
      print(e);
      Get.log('getConvertList error: $e');
      pageLoadingSet(model, MyLoadingStatus.empty);
    }
  }

  //获取赠金列表
  getBonusList(WalletHistoryFilterModel model) async {
    if (page == 1) {
      bonusList.clear();
    }
    try {
      AssetsHistoryRecord? res = await AssetsApi.instance()
          .getWalletHistoryList(
              'couponCard',
              '',
              pageSize,
              page,
              '',
              '${model.startTime.value.millisecondsSinceEpoch}',
              '${model.endTime.value.millisecondsSinceEpoch}',
              null);
      if (res != null &&
          res.financeList != null &&
          res.financeList!.isNotEmpty) {
        for (var item in res.financeList ?? []) {
          bonusList.add(item);
        }
        haveMore = page == res.pageSize;
        pageLoadingSet(model, MyLoadingStatus.success);
      } else {
        pageLoadingSet(model, MyLoadingStatus.empty);
      }
    } catch (e) {
      print(e);
      Get.log('getWithdrawalList error: $e');
      pageLoadingSet(model, MyLoadingStatus.empty);
    }
  }

  getListData(final WalletHistoryType currentType,
      WalletHistoryFilterModel model) async {
    switch (currentType) {
      case WalletHistoryType.topUp:
        await getDepositList(model);
      case WalletHistoryType.withdrawal:
        await getWithdrawalList(model);
      case WalletHistoryType.spotTrading:
        await getTradeListHistory(model);
      case WalletHistoryType.transfer:
        await getTransferList(model);
      case WalletHistoryType.conver:
        await getConvertList(model);
      case WalletHistoryType.bonus:
        await getBonusList(model);
      default:
        return [];
    }
  }

  pageLoadingSet(WalletHistoryFilterModel model, MyLoadingStatus type) {
    if (model.isFirst.value == true) {
      model.isFirst.value = false;
      switch (type) {
        case MyLoadingStatus.success:
          model.loadingController.value.setSuccess();
          break;
        default:
          model.loadingController.value.setEmpty();

          break;
      }
      update();
    }
  }

  List getListByType(currentType) {
    switch (currentType) {
      case WalletHistoryType.topUp:
        return depositList.value;
      case WalletHistoryType.withdrawal:
        return withdrawalList.value;
      case WalletHistoryType.spotTrading:
        return spotList.value;
      case WalletHistoryType.transfer:
        return transfertList.value;
      case WalletHistoryType.conver:
        return convertList.value;
      case WalletHistoryType.bonus:
        return bonusList.value;
      default:
        return [];
    }
  }

  // getRefreshVc(currentType) {
  //   // RefreshController depositRefreshVc = RefreshController();
  //   // RefreshController withdrawalRefreshVc = RefreshController();
  //   // RefreshController spotRefreshVc = RefreshController();
  //   // RefreshController transfertRefreshVc = RefreshController();
  //   switch (currentType) {
  //     case WalletHistoryType.topUp:
  //       return depositRefreshVc;
  //     case WalletHistoryType.withdrawal:
  //       return withdrawalRefreshVc;
  //     case WalletHistoryType.spotTrading:
  //       return spotRefreshVc;
  //     case WalletHistoryType.transfer:
  //       return transfertRefreshVc;
  //     default:
  //       return RefreshController();
  //   }
  // }

  @override
  onReady() {
    super.onReady();
  }

  @override
  onClose() {
    super.onClose();
  }

  Future<void> fetchTransferSpotListData(WalletHistoryFilterModel model) async {
    try {
      String? transferTypeStr = getTransferTypeStr(model);
      // 配合后台加补丁
      String transfer = 'transfer';
      if (transferTypeStr == 'otc_to_wallet' ||
          transferTypeStr == 'wallet_to_otc') {
        transfer = 'otc_transfer';
      }

      AssetsHistoryRecord? res =
          await AssetsApi.instance().getWalletHistoryList(
        transfer,
        '',
        pageSize,
        page,
        '',
        '${model.startTime.value.millisecondsSinceEpoch}',
        '${model.endTime.value.millisecondsSinceEpoch}',
        '',
        transferType: transferTypeStr,
      );
      if (res != null &&
          res.financeList != null &&
          res.financeList!.isNotEmpty) {
        for (var item in res.financeList ?? []) {
          transfertList.add(item);
        }
        haveMore = page == res.pageSize;
        pageLoadingSet(model, MyLoadingStatus.success);
      } else {
        pageLoadingSet(model, MyLoadingStatus.empty);
      }
    } catch (e) {
      print(e);
      Get.log('getWithdrawalList error: $e');
      pageLoadingSet(model, MyLoadingStatus.empty);
    }
  }

  Future<void> fetchTransferNoSpotListData(
      WalletHistoryFilterModel model) async {
    try {
      String? transferTypeStr = getTransferTypeStr(model);
      AssetsHistoryRecord? res =
          await ContractApi.instance().getWalletHistoryList(
        'transfer',
        '',
        pageSize,
        page,
        '',
        '${model.startTime.value.millisecondsSinceEpoch}',
        '${model.endTime.value.millisecondsSinceEpoch}',
        model.currentAction.id,
        transferType: transferTypeStr,
      );
      if (res != null &&
          res.financeList != null &&
          res.financeList!.isNotEmpty) {
        for (var item in res.financeList ?? []) {
          transfertList.add(item);
        }
        haveMore = page == res.pageSize;
        pageLoadingSet(model, MyLoadingStatus.success);
      } else {
        pageLoadingSet(model, MyLoadingStatus.empty);
      }
    } catch (e) {
      print(e);
      Get.log('getWithdrawalList error: $e');
      pageLoadingSet(model, MyLoadingStatus.empty);
    }
  }

  String? getTransferTypeStr(WalletHistoryFilterModel model) {
    String? from = model.transferTypeFrom.value;
    String? to = model.transferTypeTo.value;
    if (from == null || to == null) {
      return null;
    }
    String transferTypeStr = '${from}_to_${to}';
    return transferTypeStr;
  }

  bool isTransferSpot(WalletHistoryFilterModel model) {
    String? from = model.transferTypeFrom.value;
    String? to = model.transferTypeTo.value;

    if (from == null || to == null) {
      return true; // 如果任何一个为空，默认为 true
    }

    final spotTransfers = {
      'wallet_to_contract',
      'wallet_to_standard',
      'wallet_to_follow',
      'follow_to_wallet',
      'standard_to_wallet',
      'contract_to_wallet',
      'otc_to_wallet',
      'wallet_to_otc',
    };

    String transferTypeKey = '${from}_to_${to}';
    return spotTransfers.contains(transferTypeKey);
  }

  bool isTransferNoSpot(WalletHistoryFilterModel model) {
    String? from = model.transferTypeFrom.value;
    String? to = model.transferTypeTo.value;

    if (from == null || to == null) {
      return false; // 如果任何一个为空，默认为 false
    }

    final noSpotTransfers = {
      'follow_to_standard',
      'follow_to_contract',
      'contract_to_standard',
      'contract_to_follow',
      'standard_to_contract',
      'standard_to_follow',
    };

    String transferTypeKey = '${from}_to_${to}';
    return noSpotTransfers.contains(transferTypeKey);
  }
}
