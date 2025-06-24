import 'dart:convert';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/markets/market/data/market_index_data.dart';
import 'package:nt_app_flutter/app/modules/my/widgets/Me_About_Us.dart';
import 'package:nt_app_flutter/app/modules/transation/trades/controllers/trades_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

/// 统一的跳转
class RouteUtil {
  static goTo(String route,
      {Map<String, dynamic>? parameters, bool requireLogin = false}) async {
    if (requireLogin && !UserGetx.to.goIsLogin()) return;
    switch (route) {
      /// 跳转到充值
      case '/recharge':
        Get.toNamed(Routes.CURRENCY_SELECT,
            arguments: {'type': AssetsCurrencySelectEnumn.depoit});
        break;
      // 跳转到提现
      case '/withdraw':
        // if (await UserGetx.to.goIsKyc()) {
          Get.toNamed(Routes.CURRENCY_SELECT,
              arguments: {'type': AssetsCurrencySelectEnumn.withdraw});
        // }
        break;
      // c2c交易
      case '/c2c_transaction':
        UIUtil.showToast('暂未开放');
        break;
      // 资产划转
      case '/asset_transfer':
        Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {
          'from': 3,
          'to': 2,
        });
        break;
      // 跳转到标准合约
      case '/trade-commodity':
        goToTrade(0);
        break;
      // 跳转到永续合约
      case '/trade-feature':
        goToTrade(1);
        break;
      // 现货
      case '/trade-spot':
        goToTrade(2);
        break;
      // 跟单
      case '/follow-orders':
        Get.untilNamed(Routes.MAIN_TAB);
        MainTabController.to.changeTabIndex(3);
        break;
      // 闪兑
      case '/immediate-exchange':
        Get.untilNamed(Routes.MAIN_TAB);
        MainTabController.to.jumpPage(2);
        TradesController.to.onTabChange(TradeIndexType.immediate);
        break;

      /// 标准合约
      case '/market/standard':
        MarketDataManager.instance.changeMarketIndex(kindStr: 'B_0');

        break;

      /// 行情-永续合约
      case '/market/feature':
        MarketDataManager.instance.changeMarketIndex(kindStr: 'feature');

        break;

      /// 行情-现货
      case '/market/spot':
        MarketDataManager.instance.changeMarketIndex(kindStr: 'spot');

        break;

      /// 标准合约行情加密货币
      case '/market/cryptocurrency':
        MarketDataManager.instance.changeMarketIndex(kindStr: 'B_0');

        break;
      // 行情股票
      case '/market/stock':
        MarketDataManager.instance.changeMarketIndex(kindStr: 'B_1');

        break;

      /// 行情指数
      case '/market/zhi_shu':
        MarketDataManager.instance.changeMarketIndex(kindStr: 'B_2');
        break;

      /// 行情外汇
      case '/market/foreign_exchange':
        MarketDataManager.instance.changeMarketIndex(kindStr: 'B_3');
        break;

      /// 行情大宗
      case '/market/bulk':
        MarketDataManager.instance.changeMarketIndex(kindStr: 'B_4');

        break;

      /// 行情ETF
      case '/market/etf':
        MarketDataManager.instance.changeMarketIndex(kindStr: 'B_5');

        break;

      /// 社区
      case '/community':
        MarketDataManager.instance.changeMarketIndex(marketIndex: 2);

        break;

      // 卡券中心
      case '/coupon_center':
        Get.toNamed(Routes.COUPONS_INDEX);

        break;

      /// 分享
      case '/share':
        CopyUtil.copyText(LinksGetx.to.downloadUrl);
        break;

      /// 关于我们
      case '/about_us':
        Get.to(MeAboutUs());
        break;

      /// 在线客服
      case '/online_service':
        Get.toNamed(Routes.WEBVIEW,
            arguments: {'url': LinksGetx.to.onlineServiceProtocal});
        break;

      /// 帮助中心
      case '/help_center':
        Get.toNamed(Routes.WEBVIEW,
            arguments: {'url': LinksGetx.to.helpCenter});
        break;

      case Routes.HOT_DETAIL_TOPIC:
        Get.toNamed(Routes.HOT_DETAIL_TOPIC,
            parameters: {'topic': parameters?['data']},
            preventDuplicates: false);
        break;

      case '/quick-entry':
        Get.toNamed(Routes.QUICK_ENTRY);
        // Get.toNamed(Routes.C2C_CHAT, arguments: '12');
        break;
      // 快捷买币
      case '/otc-b2c':
        Get.toNamed(Routes.CUSTOMER_MAIN, arguments: {'index': 0});
        break;
      case '/otc-c2c':
        Get.toNamed(Routes.CUSTOMER_MAIN, arguments: {'index': 1});
        break;
      case '/otc/c2c/entrust':
        Get.toNamed(Routes.COMMISSION_RECORD);
        break;
      case '/otc/c2c/order':
        Get.toNamed(Routes.CUSTOMER_ORDER, arguments: {'isHome': false});
        break;
      default:
        Get.toNamed(route +
            (parameters != null ? '?data=${jsonEncode(parameters)}' : ''));
    }
  }
}
