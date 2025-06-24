import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/search/search/controllers/search_index_controller.dart';
import 'package:nt_app_flutter/app/modules/search/search/model/search_enum.dart';
import 'package:nt_app_flutter/app/modules/search/search/widget/search_list.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_tabbar.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_tab_underline_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';

class SearchResultMainView extends GetView<SearchIndexController> {
  const SearchResultMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: SafeArea(
          child: Column(
        children: [
          EntrustTabbar(
            dataArray: controller.tabs.map((e) => e.value).toList(),
            controller: controller.tabController,
          ).marginOnly(left: 16.w),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: controller.tabs.asMap().entries.map((entry) {
                final int index = entry.key;
                final SearchResultsType type = entry.value;
                return KeepAliveWrapper(
                    child: SearchList(
                        type: type,
                        controller: controller,
                        model: controller.modelList[index]));
              }).toList(),
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildTabBar(ThemeData themeData) {
    return Container(
      height: 40.h,
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
      child: Row(
        children: [
          4.horizontalSpace,
          TabBar(
            isScrollable: true,
            controller: controller.tabController,
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
            tabs: const [
              Tab(text: '所有'),
              Tab(text: '合约'),
            ],
          ),
        ],
      ),
    );
  }
}
