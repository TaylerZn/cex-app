import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets.dart';
import 'package:nt_app_flutter/app/models/assets/assets_funds.dart';
import 'package:nt_app_flutter/app/models/assets/assets_overview.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

import '../api/assets/assets_contract_api.dart';
import '../api/assets/assets_standard_contract_api.dart';
import '../api/follow/follow.dart';
import '../models/assets/assets_contract.dart';
import '../models/contract/res/position_res.dart';
import '../modules/assets/assets_contract/controllers/assets_contract_controller.dart';

class AssetsGetx extends GetxController {
  static AssetsGetx get to => Get.find();
  late AssetsGetxModel assets;
  FollowGeneralInfoModel followInfoModel = FollowGeneralInfoModel();
  FollowKolTraderInfoModel traderInfoModel = FollowKolTraderInfoModel();
  AssetsContract assetContract = AssetsContract();
  AssetsContract assetStandardContract = AssetsContract();

  AssetsSpots? assetSpots;
  //总览币种列表
  List<AssetSpotsAllCoinMapModel> assetOverViewList = [];

  //现货-资产列表
  List<AssetSpotsAllCoinMapModel> assetSpotsList = [];

  //现货-资产列表搜索结果用的备份
  List<AssetSpotsAllCoinMapModel> assetSpotsListCopy = [];

  //含有余额的现货资产-列表
  List<AssetSpotsAllCoinMapModel> assetSpotsBalanceList = [];

  //资金-资产列表
  List<AssetsFundsAllCoinMapModel> assetFundsList = [];

  //获取余额是否隐藏
  bool get isEyesOpen {
    return assets.eyesOpen;
  }

  //获取是否隐藏0资金资产
  bool get isHideZero {
    return assets.hideZero;
  }

  //获取总览是否隐藏0资金资产
  bool get isOverViewHideZero {
    return assets.hideZeroOverView;
  }

  //关键字
  String get searchKeyword {
    return assets.searchKeyword;
  }

  String get searchKeywordFound {
    return assets.searchKeywordFound;
  }

  //获取总览余额
  String get totalBalance {
    return assets.overViewBalanceInfo?.totalBalance ?? '0.0';
  }

  //获取现货账户余额
  String get spotBalance {
    return assets.overViewBalanceInfo?.balance ?? '0.0';
  }

  //获取现货-USDT可转出余额
  num getSpotCanUseBalance({String coinName = 'USDT'}) {
    String normalBalance = "0.0";
    var array = AssetsGetx.to.assetSpotsList;
    if (array.isNotEmpty) {
      for (AssetSpotsAllCoinMapModel element in array) {
        if (element.coinName == coinName) {
          normalBalance = element.normalBalance ?? '';
        }
      }
    }
    return normalBalance.toDouble();
  }

  //获取资金账户余额
  String get c2cBalance {
    return assets.overViewBalanceInfo?.c2cBalance ?? '0.0';
  }

//获取合约账户总余额
  double get contractTotalBalance {
    return double.parse(futuresTotalBalance) + double.parse(standardFuturesBalance);
  }

  //获取合约账户余额
  String get futuresTotalBalance {
    return assets.overViewBalanceInfo?.futuresTotalBalance ?? '0.0';
  }

  //获取合约-USDT可转出余额
  num getContractCanUseBalance(int index) {
    List<AccountRes> list = AssetsContractController.to.getAssetList(index);
    num canUseAmount = 0.00;
    for (var element in list) {
      if (element.symbol == "USDT") {
        canUseAmount = element.canTransferAmount;
      }
    }
    return canUseAmount;
  }

  // 获取标准合约账户余额
  String get standardFuturesBalance {
    return assets.overViewBalanceInfo?.standardFuturesBalance ?? '0.0';
  }

  // 获跟单账户余额
  String get followBalance {
    return assets.overViewBalanceInfo?.followBalance ?? '0.0';
  }

  // 总览今日盈亏率
  String get pnlRate {
    return assets.overViewBalanceInfo?.pnlRate ?? '0.0%';
  }

  // 获取现货账户今日盈亏率
  String get pnlSpotRate {
    return assetSpots?.pnlRate ?? '0.0%';
  }

  // 获取现货账户今日盈亏额
  String get pnlSpotAmount {
    return assetSpots?.pnlAmount ?? '0.0';
  }

  // 总览今日盈亏额
  String get pnlAmount {
    return assets.overViewBalanceInfo?.pnlAmount ?? '0.0';
  }

  // 合约今日盈亏率
  String contrqactPnlRate(int contractIndex) {
    if (contractIndex == 0) {
      return assetStandardContract.pnlRate ?? '0.0%';
    } else {
      return assetContract.pnlRate ?? '0.0%';
    }
  }

  // 合约今日盈亏额
  String contrqactPnlAmount(int contractIndex) {
    if (contractIndex == 0) {
      return assetStandardContract.pnlAmount ?? '0.0';
    } else {
      return assetContract.pnlAmount ?? '0.0';
    }
  }

  // 跟单总收益
  String get followIncomeAmount {
    return followInfoModel.incomeAmount.toString();
  }

  // 普通用户-跟单账户-总资产估值
  String get followInfoTotal {
    return followInfoModel.followTotal.toString();
  }

  // 交易员-跟单账户-总资产估值
  String get traderInfoTotal {
    return traderInfoModel.followTotal.toString();
  }

  // 普通用户-跟单账户-可用余额
  String get followInfoBalance {
    return followInfoModel.followBalance.toString();
  }

  // 普通用户-跟单账户-今日盈亏率
  String get followInfoPnlRate {
    return followInfoModel.pnlRate.toString();
  }

  // 交易员-跟单账户-可用余额
  String get traderInfoBalance {
    return traderInfoModel.followBalance.toString();
  }

  // 跟单今日盈亏额
  String get pnlFollowAmount {
    return followInfoModel.todayPnl.toString(); //today_pnl
  }

  PublicInfoMarket? marketInfo;

  //汇率
  List<MarketInfoRateModel> rateList = [];

  //当前汇率选择
  int rateCurrentIndex = 0;

  //基于USDT的币对列表
  List<MarketInfoModel> get coinPairList {
    return marketInfo?.market?.uSDT ?? [];
  }

  //当前选中法币信息
  MarketInfoRateModel? get currentRate {
    if (rateList.isNotEmpty) {
      return rateList[rateCurrentIndex];
    }
    return null;
  }

  //计算价格-USDT的法币价格
  String get rateUsdtPrice {
    if (currentRate != null) {
      return currentRate?.usdt ?? '0.00';
    } else {
      return '0.00';
    }
  }

  //计算价格-BTC的法币价格
  String get rateBtcPrice {
    if (currentRate != null) {
      return currentRate?.btc ?? '0.00';
    } else {
      return '0.00';
    }
  }

  //计算价格-法币的langCoin
  String get rateCoin {
    if (currentRate != null) {
      return currentRate?.langCoin ?? '';
    } else {
      return '';
    }
  }

  //计算价格-法币的langLogo
  String get rateLogo {
    if (currentRate != null) {
      return currentRate?.langLogo ?? '';
    } else {
      return '';
    }
  }

  // Method to get the minimum deposit amount for a given coin name
  num getMinDepositAmount(String coinName) {
    for (AssetSpotsAllCoinMapModel element in assetSpotsList) {
      if (element.coinName == coinName) {
        return element.depositMin ?? 0.0;
      }
    }
    return 0.0;
  }

  /// 初始化
  @override
  void onInit() {
    var instance = ObjectKV.assets.get((v) => AssetsGetxModel.fromJson(v as Map<String, dynamic>), defValue: AssetsGetxModel());
    assets = instance!;
    getRefresh();
    super.onInit();
  }

  Future<void> getRefresh({bool notify = true}) async {
    await Future.wait([
      getTotalAccountBalance(notify: notify),
      getAssetSpotsList(notify: notify),
      getFollowInfo(notify: notify),
      getAssetContract(notify: notify),
      getAssetStandardContract(notify: notify),
      getAssetFundsList(notify: notify),
    ]);
    Bus.getInstance().emit(EventType.refreshAsset);
    getOverViewAssetList();
    _save();
  }

  Future getTotalAccountBalance({bool notify = true}) async {
    if (UserGetx.to.isLogin) {
      try {
        var res = await AssetsApi.instance().getTotalAccountBalance();
        assets.overViewBalanceInfo = res;
        if (notify) {
          update();
        }
      } catch (e) {
        Get.log('getTotalAccountBalance error: $e');
      }
    }
  }

  Future getFollowInfo({bool notify = true}) async {
    if (UserGetx.to.isLogin) {
      if (UserGetx.to.isKol) {
        try {
          FollowKolTraderInfoModel? res = await AFFollow.getTraderInfo();
          if (res != null) {
            traderInfoModel = res;
            if (notify) {
              update();
            }
          }
        } catch (e) {
          Get.log('getFollowInfo error: $e');
        }
      } else {
        try {
          var res = await FollowApi.instance().getFollowInfo();
          if (res != null) {
            followInfoModel = res;
            if (notify) {
              update();
            }
          }
        } catch (e) {
          Get.log('getFollowInfo error: $e');
        }
      }
    }
  }

  getKolInfo({bool notify = true}) async {
    if (UserGetx.to.isLogin) {}
  }

  // 获取现货资产列表
  Future getAssetSpotsList({bool notify = true}) async {
    if (UserGetx.to.isLogin) {
      try {
        AssetsSpots? res = await AssetsApi.instance().getSpotsAccountBalance();
        assetSpotsList.clear();
        assetSpotsBalanceList.clear();
        assetSpots = res;
        res?.allCoinMap.forEach((key, value) {
          var coinModel = marketInfo?.coinInfoMap?[key]; //JH: 这里进行币种信息匹配
          if (coinModel != null) {
            if (coinModel.icon?.isNotEmpty ?? false) {
              // coinModel.icon is not null and is not empty
              value.icon = coinModel.icon;
            } else {
              value.icon = MarketDataManager.instance.getIconWithName(key); //打个补丁.给后台接口容错
            }

            value.showPrecision = coinModel.showPrecision; //补充精度处理
          }
          assetSpotsList.add(value);
          if (double.parse(value.allBalance ?? '0') > 0) {
            assetSpotsBalanceList.add(value);
          }
        });
        assetOverViewList = assetSpotsList.map((e) => AssetSpotsAllCoinMapModel.fromJson(e.toJson())).toList();
        if (notify) {
          update();
        }
      } catch (e) {
        Get.log('getassetSpotsList error: $e');
      }
    }
  }

  // 获取资金资产列表
  Future getAssetFundsList({bool notify = true}) async {
    if (UserGetx.to.isLogin) {
      try {
        AssetsFunds? res = await AssetsApi.instance().getOtcAccountBalance();
        if (res != null) {
          assetFundsList.clear();
          assetFundsList.addAll(res.allCoinMap ?? []);

          if (notify) {
            update();
          }
        }
      } catch (e) {
        Get.log('getAssetFundsList error: $e');
      }
    }
  }

  Future getAssetContract({bool notify = true}) async {
    if (UserGetx.to.isLogin) {
      try {
        AssetsContract res = await AssetsContractApi.instance().getContractAccountBalance();

        assetContract = res;
        if (notify) {
          update();
        }
      } catch (e) {
        Get.log('getAssetContract error: $e');
      }
    }
  }

  Future handleAssetContract(AssetsContract res, {bool notify = true}) async {
    if (UserGetx.to.isLogin) {
      try {
        assetContract = res;
        if (notify) {
          update();
        }
      } catch (e) {
        Get.log('getAssetContract error: $e');
      }
    }
  }

  Future getAssetStandardContract({bool notify = true}) async {
    if (UserGetx.to.isLogin) {
      try {
        AssetsContract? res = await AssetsStandardContractApi.instance().getStandardContractAccountBalance();
        assetStandardContract = res;
        if (notify) {
          update();
        }
      } catch (e) {
        Get.log('getAssetContract error: $e');
      }
    }
  }

  Future handleAssetStandardContract(AssetsContract? res, {bool notify = true}) async {
    if (UserGetx.to.isLogin && res != null) {
      try {
        assetStandardContract = res;
        if (notify) {
          update();
        }
      } catch (e) {
        Get.log('getAssetContract error: $e');
      }
    }
  }

  getOverViewAssetList() {
    for (AssetSpotsAllCoinMapModel model in assetOverViewList) {
      if (model.coinName == "USDT") {
        double spotBalance = 0.00;
        if (!TextUtil.isEmpty(model.allBalance)) {
          spotBalance = double.parse(model.allBalance.toString());
        }
        spotBalance = spotBalance + contractTotalBalance + followBalance.toNum();
        model.allBalance = spotBalance.toString();
      }
    }
  }

  setEyesOpen() {
    assets.eyesOpen = !assets.eyesOpen;
    update();
  }

  setSearchKeyword(String searchKeyword) {
    assets.searchKeyword = searchKeyword;
    update();
  }

  setSearchKeyword_Found(String searchKeyword) {
    assets.searchKeywordFound = searchKeyword;
    update();
  }

  void _save() {
    ObjectKV.assets.set(assets);
  }

  void clean() async {
    assets = AssetsGetxModel();
    //币种列表
    assetSpotsList = [];
    //含有余额的币种列表
    assetSpotsBalanceList = [];
    _save();
    update();
  }

  /// 加载完成
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// 控制器被释放
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  exchangeRateAction() {
    update();
  }

  setHideZeroOpen() async {
    assets.hideZero = !assets.hideZero;
    update();
  }

  setHideZeroOpenOVerView() async {
    assets.hideZeroOverView = !assets.hideZeroOverView;
    update();
  }
}
