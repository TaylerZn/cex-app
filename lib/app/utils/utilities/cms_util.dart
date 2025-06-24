import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_goods_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';

class CMSRouteUtil {
  static routeTo(String urlString) {
    if (urlString.isEmpty) return;

    Uri uri = Uri.parse(urlString);
    String path = uri.path;
    Map<String, dynamic> parameters = uri.queryParameters;

    /// 标准合约
    if (path == '/trade-commodity') {
      String? contractId = parameters['contractId'];
      // 指定币对
      if (contractId != null) {
        ContractInfo? contractInfo = CommodityDataStoreController.to.getContractInfoByContractId(contractId!.trim().toNum());
        goToTrade(0, contractInfo: contractInfo);
      } else {
        goToTrade(0);
      }
      return;
    }

    /// 永续合约
    if (path == '/trade-feature') {
      String? contractId = parameters['contractId'];
      // 指定币对
      if (contractId != null) {
        ContractInfo? contractInfo = ContractDataStoreController.to.getContractInfoByContractId(contractId!.trim().toNum());
        goToTrade(1, contractInfo: contractInfo);
      } else {
        goToTrade(1);
      }
      return;
    }

    /// 跳转k线详情
    if (path == '/kchart-detail') {
      String? symbol = parameters['subSymbol'];
      int? type = parameters['type'].toString().toInt();
      if (type == 0) {
        ContractInfo? contractInfo = CommodityDataStoreController.to.getContractInfoBySubSymbol(symbol!);
        if (contractInfo != null) {
          Get.toNamed(Routes.COMMONDITY_DETAIL, arguments: contractInfo);
        }
        return;
      }
      if (type == 1) {
        ContractInfo? contractInfo = ContractDataStoreController.to.getContractInfoBySubSymbol(symbol!);
        if (contractInfo != null) {
          Get.toNamed(Routes.CONTRACT_DETAIL, arguments: contractInfo);
        }
        return;
      }
      if (type == 2) {
        MarketInfoModel? marketInfoModel = SpotDataStoreController.to.getMarketInfoBySymbol(symbol!);
        if (marketInfoModel != null) {
          Get.toNamed(Routes.SPOT_DETAIL, arguments: marketInfoModel);
        }
        return;
      }
    }

    /// 社区
    if (path == '/community') {
      MarketDataManager.instance.changeMarketIndex();
      return;
    }

    /// 跟单
    if (path == '/follow-orders') {
      Get.untilNamed(Routes.MAIN_TAB);
      MainTabController.to.changeTabIndex(3);
      return;
    }

    /// 跟单指定用户
    if (path == '/follow-taker-info') {
      String? uid = parameters['uid'];

      if (uid != null) {
        Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': num.parse(uid)});
      } else {
        Get.untilNamed(Routes.MAIN_TAB);
        MainTabController.to.changeTabIndex(3);
      }
      return;
    }

    Get.toNamed(urlString);
  }
}
