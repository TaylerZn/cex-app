import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_deposit_record.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_contract/controllers/assets_contract_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_main/controllers/assets_main_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_overview/model/assets_exchange_rate.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssetsOverviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RefreshController refreshVc = RefreshController();
  var height = 116.0.obs;
  var defaltHeight = 116.0;
  var currentIndex = 0.obs;
  double get topHeight => height.value < 291 ? 291 : 116;
  bool get isDefault => height.value < 291;
  TextEditingController textEditSearch = TextEditingController();

  List<AssetsOverType> actionsArray = [
    AssetsOverType.deposit,
    AssetsOverType.withdraw,
    AssetsOverType.buy,
    AssetsOverType.transfer
  ];
  List<AssetsKLIneModel>? klineArr;
  List<AssetsFiat>? fiatArr;
  List<AssetsHistoryRecordItem> walletHistoryArr = [];

  final List<String> tabs = [LocaleKeys.assets54, LocaleKeys.assets55];
  var tabIndex = 0.obs;
  late TabController tabController;
  bool hiddenPnl = false;

  List<AssetsAccount> get accountList => [
        {
          'name': LocaleKeys.assets56.tr,
          'value': AssetsGetx.to.followBalance,
          'precision': AssetsGetx.to.rateList.isNotEmpty
              ? int.tryParse(AssetsGetx.to.rateList[0].coinPrecision ?? '2') ??
                  2
              : 2,
          'rateCoin': AssetsGetx.to.rateCoin == "USDT"
              ? " ${AssetsGetx.to.rateCoin}"
              : "",
          'tabIndex': 1,
          'pnl': AssetsGetx.to.pnlFollowAmount,
          'pnlRate': AssetsGetx.to.followInfoPnlRate,
          'pieName': LocaleKeys.assets2
        },
        {
          'name': LocaleKeys.assets75.tr, // 标准合约 合约账户
          'value': AssetsGetx.to.standardFuturesBalance,
          'precision': AssetsGetx.to.rateList.isNotEmpty
              ? int.tryParse(AssetsGetx.to.rateList[0].coinPrecision ?? '2') ??
                  2
              : 2,
          'rateCoin': AssetsGetx.to.rateCoin == "USDT"
              ? " ${AssetsGetx.to.rateCoin}"
              : "",
          'tabIndex': 21,
          'pnl': AssetsGetx.to.contrqactPnlAmount(0),
          'pnlRate': AssetsGetx.to.contrqactPnlRate(0),
          'pieName': LocaleKeys.assets16
        },
        {
          'name': LocaleKeys.assets76.tr, //永续合约
          'value': AssetsGetx.to.futuresTotalBalance,
          'precision': AssetsGetx.to.rateList.isNotEmpty
              ? int.tryParse(AssetsGetx.to.rateList[0].coinPrecision ?? '2') ??
                  2
              : 2,
          'rateCoin': AssetsGetx.to.rateCoin == "USDT"
              ? " ${AssetsGetx.to.rateCoin}"
              : "",
          'tabIndex': 2,
          'pnl': AssetsGetx.to.contrqactPnlAmount(1),
          'pnlRate': AssetsGetx.to.contrqactPnlRate(1),
          'pieName': LocaleKeys.assets17
        },
        {
          'name': LocaleKeys.assets58.tr,
          'value': AssetsGetx.to.spotBalance,
          'precision': AssetsGetx.to.rateList.isNotEmpty
              ? int.tryParse(AssetsGetx.to.rateList[0].coinPrecision ?? '2') ??
                  2
              : 2,
          'rateCoin': AssetsGetx.to.rateCoin == "USDT"
              ? " ${AssetsGetx.to.rateCoin}"
              : "",
          'tabIndex': 3,
          'pnl': AssetsGetx.to.pnlSpotAmount,
          'pnlRate': AssetsGetx.to.pnlSpotRate,
          'pieName': LocaleKeys.assets4
        },
        {
          'name': LocaleKeys.assets143.tr,
          'value': AssetsGetx.to.c2cBalance,
          'precision': AssetsGetx.to.rateList.isNotEmpty
              ? int.tryParse(AssetsGetx.to.rateList[0].coinPrecision ?? '2') ??
                  2
              : 2,
          'rateCoin': AssetsGetx.to.rateCoin == "USDT"
              ? " ${AssetsGetx.to.rateCoin}"
              : "",
          'tabIndex': 4,
          'pieName': LocaleKeys.assets142
        }
      ].map((e) => AssetsAccount.fromJson(e)).toList();

  bool get isEmptyView => double.parse(AssetsGetx.to.totalBalance) == 0;
  // bool get isEmptyView => true;
  // bool get isEmptyView => false;
  List<String> historyDataArray = [
    LocaleKeys.assets56.tr,
    LocaleKeys.assets75.tr,
    LocaleKeys.assets76.tr,
    LocaleKeys.assets58.tr,
    LocaleKeys.assets143.tr
  ];
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        tabIndex.value = tabController.index;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() {
    AssetsApi.instance().assetsSearch('halfYear').then((value) {
      klineArr = value;
      update();
    });

    OtcApi.instance().fiatInfo().then((value) {
      fiatArr = value;
      update();
    });

    Future.wait([
      AssetsApi.instance()
          .getWalletHistoryList('deposit', '', 2, 1, '', '', '', null),
      AssetsApi.instance()
          .getWalletHistoryList('withdraw', '', 2, 1, '', '', '', null)
    ]).then((value) {
      walletHistoryArr.clear();
      for (var element in value) {
        if (element != null && element.financeList?.isNotEmpty == true) {
          walletHistoryArr.addAll(element.financeList!);
        }
      }
      walletHistoryArr
          .sort((a, b) => b.createdAtTime.compareTo(a.createdAtTime));
      update();
    }).catchError((e) {
      print(e);
    });
  }

  void actionHandler(val) async {
    if (val == 0) {
      // Get.toNamed(Routes.CURRENCY_SELECT, arguments: {'type': AssetsCurrencySelectEnumn.depoit});
    } else if (val == 1) {
      try {
        final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER,
            arguments: {"from": 3, "to": 1});
        if (res) {
          UIUtil.showSuccess(LocaleKeys.assets10.tr);
          // getSpotsAccountBalance();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void accointItemActionHandler(val) async {
    print(val);
    if (val == 21) {
      // 合约 tab_index =2   然后调整到子tab
      AssetsMainController.to.tabController.index = 2;
      AssetsContractController contractController = Get.find();
      contractController.contractIndex = 0;
    } else {
      AssetsMainController.to.tabController.index = val;
    }
  }

  goHistory(int i) {
    switch (i) {
      case 0: //跟单
        Get.toNamed(Routes.MY_FOLLOW, arguments: {'index': 1});
        break;
      case 1: //标准
        Get.toNamed(Routes.COMMODITY_HISTORY_MAIN);
        break;
      case 2: //永续
        Get.toNamed(Routes.ENTRUST);
        break;
      case 3: //现货
        Get.toNamed(Routes.WALLET_HISTORY, arguments: 0);
        break;
      case 4: //资金
        Get.toNamed(Routes.CUSTOMER_ORDER, arguments: {'isHome': false});
        break;
      default:
    }
  }

  handleActionWithType(AssetsOverType type) async {
    switch (type) {
      case AssetsOverType.deposit:
        Get.toNamed(Routes.CURRENCY_SELECT,
            arguments: {'type': AssetsCurrencySelectEnumn.depoit});

        break;
      case AssetsOverType.withdraw:
        // if (await UserGetx.to.goIsKyc() == true) {
        //   Get.toNamed(Routes.CURRENCY_SELECT, arguments: {'type': AssetsCurrencySelectEnumn.withdraw});
        // }
        RouteUtil.goTo('/withdraw');
        break;

      case AssetsOverType.buy:
        RouteUtil.goTo('/otc-b2c');
        break;
      case AssetsOverType.transfer:
        try {
          final bool res = await Get.toNamed(Routes.ASSETS_TRANSFER,
              arguments: {"from": 3, "to": 0});
          if (res) {
            UIUtil.showSuccess(LocaleKeys.assets10.tr);
            AssetsGetx.to.getTotalAccountBalance();
          }
        } catch (e) {
          print(e);
        }
        break;
      default:
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
