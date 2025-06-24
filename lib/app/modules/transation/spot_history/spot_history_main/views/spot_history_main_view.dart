import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_history/current_entrust/views/spot_current_entrust_view.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_history/deal/views/spot_deal_view.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_history/history_entrust/views/spot_history_entrust_view.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../widgets/basic/my_tab_underline_widget.dart';
import '../controllers/spot_history_main_controller.dart';

class SpotHistoryMainView extends GetView<SpotHistoryMainController> {
  const SpotHistoryMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        title: Text(LocaleKeys.trade3.tr),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            _buildTabBar(Theme.of(context)),
            const Expanded(
              child: TabBarView(children: [
                SpotCurrentEntrustView(),
                SpotHistoryEntrustView(),
                SpotDealView(),
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
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        border: const Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        isScrollable: true,
        indicator: MyUnderlineTabIndicator(
          borderSide: const BorderSide(
            width: 2,
            color: AppColor.color111111,
          ),
          lineWidth: 24.w,
        ),
        labelColor: AppColor.color111111,
        unselectedLabelColor: AppColor.colorABABAB,
        labelStyle: AppTextStyle.f_14_500,
        unselectedLabelStyle: AppTextStyle.f_14_500,
        tabAlignment: TabAlignment.start,
        tabs: [
          Tab(text: LocaleKeys.trade36.tr),
          Tab(text: LocaleKeys.trade37.tr),
          Tab(text: LocaleKeys.trade38.tr),
        ],
      ),
    );
  }
}
