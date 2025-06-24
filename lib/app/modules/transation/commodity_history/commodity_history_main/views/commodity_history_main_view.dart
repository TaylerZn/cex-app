import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity_history/commodity_history_order/views/commodity_history_order_view.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity_history/commodity_history_trade/views/commodity_history_trade_view.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity_history/commodity_history_transaction/views/commodity_history_transaction_view.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity_history/commodity_open_order/views/commodity_open_order_view.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../widgets/basic/my_tab_underline_widget.dart';
import '../../../../../widgets/components/keep_alive_wrapper.dart';
import '../controllers/commodity_history_main_controller.dart';

class CommodityHistoryMainView extends GetView<CommodityHistoryMainController> {
  const CommodityHistoryMainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        title: Text(LocaleKeys.trade4.tr),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            _buildTabBar(Theme.of(context)),
            const Expanded(
              child: TabBarView(children: [
                KeepAliveWrapper(child: CommodityOpenOrderView()),
                KeepAliveWrapper(child: CommodityHistoryOrderView()),
                KeepAliveWrapper(child: CommodityHistoryTradeView()),
                KeepAliveWrapper(child: CommodityHistoryTransactionView()),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(ThemeData themeData) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.only(left: 4.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1.w,
          ),
        ),
      ),
      child: TabBar(
        isScrollable: true,
        indicator: const MyUnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2,
            color: AppColor.color111111,
          ),
        ),
        labelColor: AppColor.color111111,
        unselectedLabelColor: AppColor.colorABABAB,
        labelStyle: AppTextStyle.f_14_500,
        unselectedLabelStyle: AppTextStyle.f_14_500,
        tabAlignment: TabAlignment.start,
        tabs: [
          Tab(text: LocaleKeys.trade12.tr),
          Tab(text: LocaleKeys.trade37.tr),
          Tab(text: LocaleKeys.trade38.tr),
          Tab(text: LocaleKeys.trade39.tr),
        ],
      ),
    );
  }
}
