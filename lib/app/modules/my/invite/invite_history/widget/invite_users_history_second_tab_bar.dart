import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';

import '../../../../../config/theme/app_text_style.dart';

class InviteuserHistorySecondTabBar extends StatelessWidget {
  final List<String> titles;
  final TabController tabController;

  InviteuserHistorySecondTabBar({
    required this.titles,
    required this.tabController,
  }) : assert(tabController != null, 'tabController must not be null');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.h),
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        unselectedLabelColor: AppColor.color999999,
        labelColor: AppColor.color333333,
        labelStyle: AppTextStyle.f_12_500,
        unselectedLabelStyle: AppTextStyle.f_12_500,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.only(left: 10, right: 10, top: 2),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.color111111),
        ),
        tabs: titles
            .map((f) => Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(f),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
