import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/main_tab/models/trade_type.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_goods_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';

import '../../modules/transation/trades/controllers/trades_controller.dart';

/// 跳转到永续合约
goToContractKline({required ContractInfo contractInfo}) async {
  await Get.toNamed(Routes.CONTRACT_DETAIL, arguments: contractInfo);
  // MainTabController.to.tradeType.value = TradeType.contract;
  // MainTabController.to.jumpPage(2);
  // TradesController.to.onTabChange(1);
}

/// 跳转到标准合约
goToCommodityKline({required ContractInfo contractInfo}) async {
  await Get.toNamed(Routes.COMMONDITY_DETAIL, arguments: contractInfo);
  // MainTabController.to.tradeType.value = TradeType.contract;
  // MainTabController.to.jumpPage(2);
  // TradesController.to.onTabChange(0);
}

/// 现货跳转
gotSpotKline(MarketInfoModel marketInfoModel) async {
  await Get.toNamed(Routes.SPOT_DETAIL, arguments: marketInfoModel);
  // MainTabController.to.tradeType.value = TradeType.spot;
  // MainTabController.to.jumpPage(2);
}

/// index 0:标准合约 1:永续合约 2:现货
goToTrade(int index,
    {ContractInfo? contractInfo, MarketInfoModel? marketInfoModel}) {
  Get.untilNamed(Routes.MAIN_TAB);
  if (index < 2) {
    MainTabController.to.tradeType.value = TradeType.contract;
    TradesController.to.onTabChange(
        index == 0 ? TradeIndexType.standard : TradeIndexType.contract);
  } else {
    // MainTabController.to.tradeType.value = TradeType.spot;
  }

  if (contractInfo != null) {
    if (index == 0) {
      CommodityController.to.changeContractInfo(contractInfo);
    } else {
      ContractController.to.changeContractInfo(contractInfo);
    }
  }
  if (marketInfoModel != null) {
    SpotGoodsController.to.changeMarketInfo(marketInfoModel);
  }
  MainTabController.to.jumpPage(2);
}
